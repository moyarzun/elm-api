class Api::V1::TournamentsController < ApplicationController
  before_action :set_tournament, only: %i[show update destroy]

  # GET /api/v1/tournaments
  def index
    @tournaments = Tournament.includes(:rounds).all
    render json: @tournaments, include: :rounds
  end

  # GET /api/v1/tournaments/:id
  def show
    render json: @tournament, include: :rounds
  end

  # POST /api/v1/tournaments
  def create
    @tournament = Tournament.new(tournament_params)
    if @tournament.save
      render json: @tournament, status: :created, location: api_v1_tournament_url(@tournament)
    else
      render json: @tournament.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/tournaments/:id
  def update
    if @tournament.update(tournament_params)
      render json: @tournament
    else
      render json: @tournament.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/tournaments/:id
  def destroy
    @tournament.destroy
  end

  private

  def set_tournament
    @tournament = Tournament.find(params[:id])
  end

  def tournament_params
    params.permit(:name, :scoring_type, :players_per_match)
  end
end
