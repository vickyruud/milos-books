class HardcoversController < ApplicationController
  before_action :set_hardcover, only: %i[ show update destroy ]

  # GET /hardcovers
  def index
    @hardcovers = Hardcover.all

    render json: @hardcovers
  end

  def categories 
    @names = get_categories
    render json:@names
    
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
      url = URI("https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=OLwLmtGas8CilAAxE7ZXaSnSfFgvdhGQ")
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Get.new(url)
      request["api-key"] = 'OLwLmtGas8CilAAxE7ZXaSnSfFgvdhGQ'
      request["x-rapidapi-host"] = 'api.nytimes.com'
      response = http.request(request)
      response.read_body     
    end
end

