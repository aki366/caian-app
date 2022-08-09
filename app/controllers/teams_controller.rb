class TeamsController < ApplicationController

  before_action :authenticate_user

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if team_params[:name] == ""
      render :new
    else
      if @team.save
        @member = @team.members.create(
          user_id: @current_user.id,
          team_id: @team.id
        )
        flash[:notice] = "チームを作成しました"
        redirect_to "/teams/#{@team.id}"
      end
    end
  end

  def show
    if @current_user == nil
      redirect_to new_login_path
    else
      @team = Team.find(params[:id])
      @members = @team.members.includes(:user)
    end
  end

  def room
    @team = Team.find(params[:id])
    @team_message = TeamMessage.new
    if Member.where(
      :user_id => @current_user.id,
      :team_id => @team.id
    ).present?
      @members = @team.members
      @team_messages = @team.team_messages.includes(:user)
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
