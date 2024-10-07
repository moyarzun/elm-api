require "test_helper"

class Api::V1::PlayersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_v1_player = api_v1_players(:one)
  end

  test "should get index" do
    get api_v1_players_url, as: :json
    assert_response :success
  end

  test "should create api_v1_player" do
    assert_difference("Api::V1::Player.count") do
      post api_v1_players_url, params: { api_v1_player: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show api_v1_player" do
    get api_v1_player_url(@api_v1_player), as: :json
    assert_response :success
  end

  test "should update api_v1_player" do
    patch api_v1_player_url(@api_v1_player), params: { api_v1_player: {  } }, as: :json
    assert_response :success
  end

  test "should destroy api_v1_player" do
    assert_difference("Api::V1::Player.count", -1) do
      delete api_v1_player_url(@api_v1_player), as: :json
    end

    assert_response :no_content
  end
end
