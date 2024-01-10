class TicketsController < ApplicationController
  before_action :authenticate_user, {only: %i[new show edit update destroy]}
  before_action :ensure_correct_user, {only: %i[edit update destroy]}

  # ticketのみ404エラ−に検索機能を実装する際に使用
  # rescue_from ActiveRecord::RecordNotFound,   with: :render_404
  # rescue_from ActionController::RoutingError, with: :render_404

  def index
    if @current_user.nil?
      redirect_to new_login_path
    else
      @tickets = Ticket.all.includes(:user).order(created_at: :desc)
    end
  end

  def show
    @comment = Comment.new
    @ticket = Ticket.find(params[:id])
    @user = @ticket.user
    @likes_count = Like.where(ticket_id: @ticket.id).count
    @comments = @ticket.comments.includes(:user)
    @likes = Like.find_by(user_id: @current_user.id, ticket_id: @ticket.id)
  end

  def new; end

  def create
    @team = Team.find(params[:team_id])
    @ticket = @current_user.tickets.new(ticket_params)
    redirect_to room_team_path(@team.id) if @ticket.save
  end

  def edit
    @ticket = Ticket.find(params[:id])
  end

  def update
    @ticket = Ticket.find(params[:id])
    if @ticket.update(ticket_params)
      flash[:notice] = t('flash_messages.ticket_updated')
      redirect_to room_team_path(@team.id)
    else
      render :edit
    end
  end

  def destroy
    @team = Team.find(params[:team_id])
    @tickets = @team.tickets.find(params[:id])

    return unless @current_user.id == @tickets.user.id

    @tickets.destroy
    flash[:notice] = t('flash_messages.ticket_deleted')
    redirect_to room_team_path(@team.id)
  end

  private

    # ticketのみ404エラ−に検索機能を実装する際に使用
    # def render_404
    #   respond_to do |format|
    #     # defaultの404ページを表示させる場合↓
    #     format.html { redirect_to not_found_404_path }
    #     format.xml  { head :not_found_404 }
    #     format.any  { head :not_found_404 }
    #   end
    # end

    def ensure_correct_user
      @ticket = Ticket.find(params[:id])
      redirect_to room_team_path(@team.id) if @ticket.user_id != @current_user.id
    end

    def ticket_params
      params.require(:ticket).permit(
        :subject,
        :content,
        :team_id,
        :image
      )
    end
end
