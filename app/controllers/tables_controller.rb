class TablesController < ActionController::API
  def index
    render json: Table.all
  end
end
