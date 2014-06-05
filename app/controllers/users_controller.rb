class UsersController < ApplicationController
  def index
    @users = User.all
  end
  def show
    @user = User.find(params[:id])
    @messages = @user.messages
    @messages = @messages.reverse
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    if @user.destroy
        redirect_to adminpanel_index_path, notice: "Utilisateur supprimé."
    end
  end
end
