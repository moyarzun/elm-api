class Api::V1::PlayerMatchesController < ApplicationController
  before_action :set_player_match, only: %i[show update destroy]

  # GET /api/v1/players
  def index
    @player_matches = PlayerMatch.all

    render json: @player_matches
  end

  # GET /api/v1/players/1
  def show
    render json: @player_match
  end

  # POST /api/v1/players
  def create
    @player_match = APlayer.new(params)

    if @player_match.save
      render json: @player_match, status: :created, location: @player_match
    else
      render json: @player_match.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/players/1
  def update
    if @player_match.update(player_params)
      render json: @player_match
    else
      render json: @player_match.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/players/1
  def destroy
    @player_match.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_player_match
    @player_match = Player.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def player_match_params
    params.fetch(:player_match, {})
  end
end