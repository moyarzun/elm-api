class LeagueDaysController < ActionController::API
  def index
    render json: LeagueDay.all, include: [:tables]
  end
end
