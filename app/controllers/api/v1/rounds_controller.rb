module Api
  module V1
    class RoundsController < ApplicationController
      before_action :set_round, only: %i[show update destroy]

      # GET /api/v1/rounds
      def index
        @rounds = Round.includes(:matches).all
        render json: @rounds, include: :matches
      end

      # GET /api/v1/rounds/:id
      def show
        render json: @round, include: :matches
      end

      # GET /api/v1/matches/by_round/:round_id
      def by_tournament
        @rounds = Round.where(tournament_id: params[:tournament_id])
        render json: @rounds.map { |round| round_response(round) }
      end

      # POST /api/v1/rounds
      def create
        @round = Round.new(round_params)
        if @round.save
          render json: @round, status: :created, location: api_v1_round_url(@round)
        else
          render json: @round.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/rounds/:id
      def update
        if @round.update(round_params)
          render json: @round
        else
          render json: @round.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/rounds/:id
      def destroy
        @round.destroy
      end

      private

      def set_round
        @round = Round.find(params[:id])
      end

      def round_params
        params.permit(:tournament_id)
      end

      # Construir la respuesta JSON para un match
      def round_response(round)
        {
          id: round.id,
          matches: round.matches.map do |match|
            {
              id: match.id,
              players_amount: match.players.length,
              locked: match.locked
            }
          end
        }
      end
    end
  end
end
