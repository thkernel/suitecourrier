class TicketTypesController < ApplicationController
  authorize_resource
  before_action :authenticate_user!


  before_action :set_ticket_type, only: [:show, :edit, :update, :destroy]
  layout "dashboard"

  # GET /ticket_types
  # GET /ticket_types.json
  def index
    @ticket_types = TicketType.all
  end

  # GET /ticket_types/1
  # GET /ticket_types/1.json
  def show
  end

  # GET /ticket_types/new
  def new
    @ticket_type = TicketType.new
  end

  # GET /ticket_types/1/edit
  def edit
  end

  # POST /ticket_types
  # POST /ticket_types.json
  def create
    @ticket_type = current_user.ticket_types.build(ticket_type_params)

    respond_to do |format|
      if @ticket_type.save
        @ticket_types = TicketType.all
        format.html { redirect_to @ticket_type, notice: 'Ticket type was successfully created.' }
        format.json { render :show, status: :created, location: @ticket_type }
        format.js
      else
        format.html { render :new }
        format.json { render json: @ticket_type.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /ticket_types/1
  # PATCH/PUT /ticket_types/1.json
  def update
    respond_to do |format|
      if @ticket_type.update(ticket_type_params)
        @ticket_types = TicketType.all

        format.html { redirect_to @ticket_type, notice: 'Ticket type was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket_type }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @ticket_type.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end


  def delete
    @ticket_type = TicketType.find(params[:ticket_type_id])
  end


  # DELETE /ticket_types/1
  # DELETE /ticket_types/1.json
  def destroy
    @ticket_type.destroy
    respond_to do |format|
      format.html { redirect_to ticket_types_url, notice: 'Ticket type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket_type
      @ticket_type = TicketType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ticket_type_params
      params.require(:ticket_type).permit(:name, :description)
    end
end
