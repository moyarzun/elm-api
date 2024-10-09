class Api::V1::MatchesController < ApplicationController
  before_action :set_match, only: %i[show update destroy]

  # GET /api/v1/matches
  def index
    @matches = Match.all

    render json: @matches.as_json(
      except: %i[created_at updated_at],
      include: {
        players: {
          except: %i[created_at updated_at],
          methods: :score
        }
      }
    )
  end

  # GET /api/v1/matches/1
  def show
    render json: @match.as_json(
      except: %i[created_at updated_at],
      include: {
        players: {
          except: %i[created_at updated_at],
          methods: :score
        }
      }
    )
  end

  # POST /api/v1/matches
  def create
    @match = Match.new(match_params)

    if @match.save
      render json: @match, status: :created, location: @match
    else
      render json: @match.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/matches/1
  def update
    if @match.update(match_params)
      render json: @match
    else
      render json: @match.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/matches/1
  def destroy
    @match.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_match
    @match = Match.includes(:players).find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def match_params
    params.fetch(:match, {})
  end
end
