class HardcoversController < ApplicationController
  before_action :set_hardcover, only: %i[ show update destroy ]

  # GET /hardcovers
  def index
    @hardcovers = Hardcover.all

    render json: @hardcovers
  end

  def categories 
    get_categories
    put(get_categories)
  end

  # GET /hardcovers/1
  def show
    render json: @hardcover
  end

  # POST /hardcovers
  def create
    @hardcover = Hardcover.new(hardcover_params)

    if @hardcover.save
      render json: @hardcover, status: :created, location: @hardcover
    else
      render json: @hardcover.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /hardcovers/1
  def update
    if @hardcover.update(hardcover_params)
      render json: @hardcover
    else
      render json: @hardcover.errors, status: :unprocessable_entity
    end
  end

  # DELETE /hardcovers/1
  def destroy
    @hardcover.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hardcover
      @hardcover = Hardcover.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def hardcover_params
      params.require(:hardcover).permit(:display_name, :list_name, :list_name_encoded, :newest_published_date, :oldest_published_date, :updated)
    end

    def get_categories
      # get JSON
      url = 'https://api.nytimes.com/svc/books/v3/lists/names?api-key=OLwLmtGas8CilAAxE7ZXaSnSfFgvdhGQ'
      
      result = RestClient.get(url)

      # parse JSON
      json = result

      # save data to DB
      json['results']['books'][1..-1].each do |data| # [1..-1] ignores first dummy element
        Category.create(
          display_name: data['display_name'],
          list_name: data['list_name'],
          list_name_encoded: data['list_name_encoded'], # .gsub removes thousands separator
          newest_published_date: data['newest_published_date'],
          oldest_published_date: data['oldest_published_date'],
          updated: data['updated']
        )
    end
end

end
