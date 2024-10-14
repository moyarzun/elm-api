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
        params.require(:round).permit(:name, matches_attributes: %i[id name _destroy])
      end
    end
  end
end
