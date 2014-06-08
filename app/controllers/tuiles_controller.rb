class TuilesController < ApplicationController
  before_action :set_tuile, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new]

  # GET /tuiles
  # GET /tuiles.json
  def index
    @tuiles = Tuile.all.reverse
    @users = User.all
  end

  # GET /tuiles/1
  # GET /tuiles/1.json
  def show
  end

  # GET /tuiles/new
  def new
    if admin_signed_in?
      redirect_to root_url, alert: "Vous ne pouvez pas créer de tuiles en tant qu'administrateur."
    end
    @tuile = Tuile.new
  end

  # GET /tuiles/1/edit
  def edit
    unless admin_signed_in? || current_user.id == @tuile.user_id
      redirect_to root_url, alert: "Vous ne pouvez pas modifier une tuile qui ne vous appartient pas."
    end
  end

  # POST /tuiles
  # POST /tuiles.json
  def create
    # @tuile = Tuile.new(tuile_params)
    @tuile = current_user.tuiles.build
    @tuile.attributes = tuile_params
    @tuile.tag_list.add(params[:tag_list], parse: true)

    respond_to do |format|
      if @tuile.save
        format.html { redirect_to @tuile, notice: 'Tuile créée' }
        format.json { render action: 'show', status: :created, location: @tuile }
      else
        format.html { render action: 'new' }
        format.json { render json: @tuile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tuiles/1
  # PATCH/PUT /tuiles/1.json
  def update
    respond_to do |format|
      if @tuile.update(tuile_params)
        format.html { redirect_to @tuile, notice: 'Tuile modifiée' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tuile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tuiles/1
  # DELETE /tuiles/1.json
  def destroy
    if admin_signed_in? || current_user.id == @tuile.user_id
      @tuile.destroy
      respond_to do |format|
        if admin_signed_in?
          format.html { redirect_to root_url, notice: 'Tuile supprimée' }
        else
          format.html { redirect_to tuiles_url, notice: 'Tuile supprimée' }
        end
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tuile
      unless @tuile = Tuile.where(id: params[:id]).first
        flash[:alert] = 'Tuile non trouvée'
        redirect_to root_url
      else
        @tuile = Tuile.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tuile_params
      params.require(:tuile).permit(:lien, :image, :titre, :description, :forme, :tag_list)
    end
end
