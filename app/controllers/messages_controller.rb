class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  # before_action :authenticate_user!
  before_action :verify_identity

  def verify_identity
    admin_signed_in? ? true : authenticate_user!
  end

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.where(:public => true)
    @users = User.all
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    unless @message.public
      unless admin_signed_in? || current_user.id == @message.user_id
        redirect_to root_url, alert: "Vous n'avez pas l'autorisation de visualiser ce message"
      end
    end
  end

  # GET /messages/new
  def new
    if admin_signed_in?
      redirect_to root_url, alert: "Vous ne pouvez pas envoyer de messages en tant qu'administrateur"
    end
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
    unless admin_signed_in? || current_user.id == @message.user_id
      redirect_to root_url, alert: "Vous ne pouvez pas modifier un message qui ne vous appartient pas."
    end
  end

  # POST /messages
  # POST /messages.json
  def create
    # @message = Message.new(message_params)
    @message = current_user.messages.build
    @message.attributes = message_params
    # @message.user = current_user

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message envoyé' }
        format.json { render action: 'show', status: :created, location: @message }
      else
        format.html { render action: 'new' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message modifié' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    if admin_signed_in? || current_user.id == @message.user_id
      @message.destroy
      respond_to do |format|
        if admin_signed_in?
          format.html { redirect_to root_url, notice: 'Message supprimé' }
        else
          format.html { redirect_to messages_url, notice: 'Message supprimé' }
        end
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      unless @message = Message.where(id: params[:id]).first
        flash[:alert] = 'Message non trouvé'
        redirect_to root_url
      else
        @message = Message.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:title, :content, :public, :user_id)
    end
end
