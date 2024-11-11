class Api::V1::MatchesController < ApplicationController
  before_action :set_match, only: %i[show update destroy score_update lock unlock]

  # GET /api/v1/matches
  def index
    @matches = Match.all

    render json: @matches.map { |match| match_response(match) }
  end

  # GET /api/v1/matches/1
  def show
    render json: match_response(@match)
  end

  # GET /api/v1/matches/by_round/:round_id
  def by_round
    @matches = Match.where(round_id: params[:round_id])
    render json: @matches.map { |match| match_response(match) }
  end

  # POST /api/v1/matches
  def create
    @match = Match.new(match_params)

    if @match.save
      render json: @match, status: :created
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

  # PATCH/PUT /api/v1/matches/:id/score_update
  def score_update
    players_params = params.dig(:match, :players)

    if players_params.nil?
      render json: { errors: ['Players parameter is missing'] }, status: :unprocessable_entity
      return
    end

    ActiveRecord::Base.transaction do
      players_params.each do |player_params|
        player_match = @match.player_matches.find_by(player_id: player_params[:id])
        unless player_match
          raise ActiveRecord::RecordInvalid.new(@match), "Player with ID #{player_params[:id]} not found in match"
        end

        player_match.update!(score: player_params[:score])
      end
      @match.update!(locked: true)
    end

    render json: match_response(@match)
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  # DELETE /api/v1/matches/1
  def destroy
    @match.destroy
  end

  # PUT /api/v1/matches/1/lock
  def lock
    @match.lock.save!
    render json: match_response(@match)
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  # PUT /api/v1/matches/1/unlock
  def unlock
    @match.unlock.save!
    render json: match_response(@match)
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_match
    @match = Match.includes(:players).find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def match_params
    params.permit(:tournament_id, :round_id, :locked)
  end

  def score_params
    params.require(:match).permit(:id, :tournament_id, :round_id, :locked, players: %i[id name score])
  end

  # Construir la respuesta JSON para un match
  def match_response(match)
    {
      id: match.id,
      max_players: match.tournament.players_per_match || nil,
      locked: match.locked || false,
      players: match.players.map do |player|
        {
          id: player.id,
          name: player.name,
          score: player.player_matches.find_by(match_id: match.id)&.score || '-'
        }
      end
    }
  end
end
