class Api::V1::PlayersController < ApplicationController
  before_action :set_api_v1_player, only: %i[show update destroy]

  # GET /api/v1/players
  def index
    @players = Player.all

    render json: @players
  end

  # GET /api/v1/players/1
  def show
    render json: @player
  end

  # POST /api/v1/players
  def create
    @player = APlayer.new(params)

    if @player.save
      render json: @player, status: :created, location: @player
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/players/1
  def update
    if @player.update(player_params)
      render json: @player
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/players/1
  def destroy
    @player.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_player
    @player = Player.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def player_params
    params.fetch(:player, {})
  end
end
