class Api::V1::PlayersController < ApplicationController
  before_action :set_api_v1_player, only: %i[ show update destroy ]

  # GET /api/v1/players
  def index
    @api_v1_players = Api::V1::Player.all

    render json: @api_v1_players
  end

  # GET /api/v1/players/1
  def show
    render json: @api_v1_player
  end

  # POST /api/v1/players
  def create
    @api_v1_player = Api::V1::Player.new(api_v1_player_params)

    if @api_v1_player.save
      render json: @api_v1_player, status: :created, location: @api_v1_player
    else
      render json: @api_v1_player.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/players/1
  def update
    if @api_v1_player.update(api_v1_player_params)
      render json: @api_v1_player
    else
      render json: @api_v1_player.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/players/1
  def destroy
    @api_v1_player.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_player
      @api_v1_player = Api::V1::Player.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_v1_player_params
      params.fetch(:api_v1_player, {})
    end
end
