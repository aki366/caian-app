class TeamsController < ApplicationController
  before_action :authenticate_user

  def show
    if @current_user.nil?
      redirect_to new_login_path
    else
      @team = Team.find(params[:id])
      @members = @team.members.includes(:user)
      @tickets = @team.tickets.includes(:user)
    end
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if team_params[:name] == ""
      render :new
    elsif @team.save
      @member = @team.members.create(
        user_id: @current_user.id,
        team_id: @team.id
      )
      flash[:notice] = t('flash_messages.team_created')
      redirect_to "/teams/#{@team.id}"
    end
  end

  def room
    @team = Team.find(params[:id])
    @team_message = TeamMessage.new
    @ticket = Ticket.new
    if Member.where(
      user_id: @current_user.id,
      team_id: @team.id
    ).present?
      @members = @team.members
      @team_messages = @team.team_messages.includes(:user)
      @tickets = @team.tickets.includes(:user)
      @team_contents = @team_messages | @tickets
      @team_contents.sort! { |a, b| a.created_at <=> b.created_at }
    else
      redirect_back(fallback_location: root_path)
    end

    # teams/roomでMemberを表示
    @team_users = @team.members.includes(:user)
    @not_current_member = @team_users.where.not(user: @current_user)

    # 投稿フォーム切替用
    @form_switch = form_params
  end

  private

    def team_params
      params.require(:team).permit(:name)
    end

    # 投稿フォーム切替用
    def form_params
      params[:form_switch]
    end
end
