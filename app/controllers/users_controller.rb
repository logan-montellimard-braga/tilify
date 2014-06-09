class UsersController < ApplicationController
  before_action :set_user
  def index
    @users = User.all
  end
  def show
    @user = User.find(params[:id])
    @messages = @user.messages
    @messages = @messages.reverse
    @tuiles = @user.tuiles
    @tuiles = @tuiles.reverse
    @favs = @user.favorites.order('created_at DESC')
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    if @user.destroy
        redirect_to adminpanel_index_path, notice: "Utilisateur supprimé."
    end
  end

  def set_user
    unless @user = User.where(id: params[:id]).first
      if admin_signed_in?
        flash[:alert] = 'Utilisateur non trouvé.'
      else
        flash[:alert] = "Vous n'avez pas l'autorisation de visualiser ce profil."
      end
      redirect_to root_url
    else
      @user = User.find(params[:id])
    end
  end
end
