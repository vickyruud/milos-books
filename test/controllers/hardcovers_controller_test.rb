require "test_helper"

class HardcoversControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hardcover = hardcovers(:one)
  end

  test "should get index" do
    get hardcovers_url, as: :json
    assert_response :success
  end

  test "should create hardcover" do
    assert_difference("Hardcover.count") do
      post hardcovers_url, params: { hardcover: { display_name: @hardcover.display_name, list_name: @hardcover.list_name, list_name_encoded: @hardcover.list_name_encoded, newest_published_date: @hardcover.newest_published_date, oldest_published_date: @hardcover.oldest_published_date, updated: @hardcover.updated } }, as: :json
    end

    assert_response :created
  end

  test "should show hardcover" do
    get hardcover_url(@hardcover), as: :json
    assert_response :success
  end

  test "should update hardcover" do
    patch hardcover_url(@hardcover), params: { hardcover: { display_name: @hardcover.display_name, list_name: @hardcover.list_name, list_name_encoded: @hardcover.list_name_encoded, newest_published_date: @hardcover.newest_published_date, oldest_published_date: @hardcover.oldest_published_date, updated: @hardcover.updated } }, as: :json
    assert_response :success
  end

  test "should destroy hardcover" do
    assert_difference("Hardcover.count", -1) do
      delete hardcover_url(@hardcover), as: :json
    end

    assert_response :no_content
  end
end
