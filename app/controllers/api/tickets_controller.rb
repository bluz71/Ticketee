class API::TicketsController < ApplicationController
  attr_reader :current_user
  before_action :find_project
  before_action :authenticate_user

  def create
    @ticket = @project.tickets.build(ticket_params)
    authorize @ticket, :create?
    if @ticket.save
      render json: @ticket, status: 201
    else
      render json: { errors: @ticket.errors.full_messages }, status: 422
    end
  end

  def show
    @ticket = @project.tickets.find(params[:id])
    authorize @ticket, :show?
    render json: @ticket
  end

  private

    def not_authorized
      render json: { error: "Unauthorized" }, status: 403
    end

    def authenticate_user
      authenticate_with_http_token do |token|
        @current_user = User.find_by(api_key: token)
      end

      if @current_user.nil?
        render json: { error: "Unauthorized" }, status: 401
        return
      end
    end

    def find_project
      @project = Project.find(params[:project_id])
    end

    def ticket_params
      params.require(:ticket).permit(:name, :description)
    end
end
