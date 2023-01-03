class LeaguesController < ActionController::API
  def index
    render json: League.all.to_json(include: :league_days)
  end
end
