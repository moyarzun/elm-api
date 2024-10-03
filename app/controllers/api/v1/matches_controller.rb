class Api::V1::MatchesController < ApplicationController
  before_action :set_api_v1_match, only: %i[ show update destroy ]

  # GET /api/v1/matches
  def index
    @api_v1_matches = Api::V1::Match.all

    render json: @api_v1_matches
  end

  # GET /api/v1/matches/1
  def show
    render json: @api_v1_match
  end

  # POST /api/v1/matches
  def create
    @api_v1_match = Api::V1::Match.new(api_v1_match_params)

    if @api_v1_match.save
      render json: @api_v1_match, status: :created, location: @api_v1_match
    else
      render json: @api_v1_match.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/matches/1
  def update
    if @api_v1_match.update(api_v1_match_params)
      render json: @api_v1_match
    else
      render json: @api_v1_match.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/matches/1
  def destroy
    @api_v1_match.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_match
      @api_v1_match = Api::V1::Match.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_v1_match_params
      params.fetch(:api_v1_match, {})
    end
end
