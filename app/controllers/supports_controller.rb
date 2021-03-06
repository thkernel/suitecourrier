class SupportsController < ApplicationController
  authorize_resource
  before_action :authenticate_user!
  layout "dashboard"
  before_action :set_support, only: [:show, :edit, :update, :destroy]

  # GET /supports
  # GET /supports.json
  def index
    @supports = Support.order(id: :desc)
    record_activity("Afficher la liste des supports.")

  end

  # GET /supports/1
  # GET /supports/1.json
  def show
  end

  # GET /supports/new
  def new
    @support = Support.new
  end




  def last_support
    last_support = Support.last
    supports = Support.all
    data = {:last_record => last_support, :all_records => supports}
    render :json => data
  end
  

  # GET /supports/1/edit
  def edit
  end

  # POST /supports
  # POST /supports.json
  def create
    @support = current_user.supports.build(support_params)

    respond_to do |format|
      if @support.save
        record_activity("Créer un support (ID: #{@support.id})")

        @supports = Support.order(id: :desc)

        format.html { redirect_to @support, notice: 'Support enregistré avec succès.' }
        format.json { render :show, status: :created, location: @support }
        format.js
      else
        format.html { render :new }
        format.json { render json: @support.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /supports/1
  # PATCH/PUT /supports/1.json
  def update
    respond_to do |format|
      if @support.update(support_params)
        record_activity("Modifier un support (ID: #{@support.id})")

        @supports = Support.order(id: :desc)

        format.html { redirect_to @support, notice: 'Support modifié avec succès.' }
        format.json { render :show, status: :ok, location: @support }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @support.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end


  def delete
    @support = Support.find_by(uid: params[:support_id])
  end

  # DELETE /supports/1
  # DELETE /supports/1.json
  def destroy
    @support.destroy
    @supports = Support.all

    respond_to do |format|
      record_activity("Supprimer un support (ID: #{@support.id})")

      format.html { redirect_to supports_url, notice: 'Support supprimé avec succès.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_support
      @support = Support.find_by(uid: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def support_params
      params.require(:support).permit(:name, :description)
    end
end
