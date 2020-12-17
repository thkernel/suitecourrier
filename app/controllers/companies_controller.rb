class CompaniesController < ApplicationController
  before_action :authenticate_user!
  layout "dashboard"

  before_action :set_company, only: [:show, :edit, :update, :destroy]

  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.all
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
  end

  # GET /companies/new
  def new
    @company = Company.new
    @activity_fields = ActivityField.all
  end

  # GET /companies/1/edit
  def edit
    @activity_fields = ActivityField.all

  end

  # POST /companies
  # POST /companies.json
  def create
    @company = current_user.companies.build(company_params)

    respond_to do |format|
      if @company.save
        @companies = Company.all

        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @company }
        format.js
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        @companies = Company.all


        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end


  def delete
    @company = Company.find(params[:company_id])
  end


  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    @companies = Company.all

    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :activity_field_id, :slogan, :address_one,  :city,  :country, :phone)
    end
end
