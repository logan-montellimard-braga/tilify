class TuilesController < ApplicationController
  before_action :set_tuile, only: [:show, :edit, :update, :destroy, :favorite]
  before_action :authenticate_user!, only: [:new]

  # GET /tuiles
  # GET /tuiles.json
  def index
    if params[:search] && params[:tagOnly]
      query = params[:search].split(' ')
      @tuiles = Tuile.tagged_with(query, :any => true).order('created_at DESC')
    elsif params[:search] && params[:typeOnly]
      @tuiles = Tuile.where("forme LIKE ?", "%#{params[:search]}%").order('created_at DESC')
    elsif params[:search]
      @tuiles = []
      query = params[:search].split(' ')
      query.map { |q| @tuiles += Tuile.search(q) }
      @tuiles += Tuile.tagged_with(query, :any => true)
      @tuiles = @tuiles.uniq.sort { |x,y| y.created_at <=> x.created_at }
    else
      @tuiles = Tuile.all.order('created_at DESC')
    end

    @users = User.all
    @best_tags = get_most_used_tags(10)
    @number = Tuile.count
    @favs = current_user.favorites if user_signed_in?
  end

  # PUT Favorites
  def favorite
    # favs = current_user.favorites
    # if favs.include?(@tuile)
    #   current_user.favorites.delete(@tuile)
    #   redirect_to :back, notice: "Favori supprimé : #{@tuile.titre}."
    # else
    #   current_user.favorites << @tuile
    #   redirect_to :back, notice: "Favori ajouté : #{@tuile.titre}."
    # end
    type = params[:toggle]
    if type == 'add'
      current_user.favorites << @tuile
      redirect_to :back, notice: "Favori ajouté : #{@tuile.titre}."
    elsif type == 'del'
      current_user.favorites.delete(@tuile)
      redirect_to :back, notice: "Favori supprimé : #{@tuile.titre}."
    else
      redirect_to :back, alert: "Pas d'action spécifiée ; aucun changement."
    end
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
    unless admin_signed_in? || (user_signed_in? && current_user.id == @tuile.user_id)
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

    def get_most_used_tags(limit)
      return Tuile.tag_counts_on(:tags).limit(limit).order('count desc')
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tuile_params
      params.require(:tuile).permit(:lien, :image, :titre, :description, :forme, :tag_list)
    end
end
