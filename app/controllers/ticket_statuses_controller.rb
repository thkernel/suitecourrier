class TicketStatusesController < ApplicationController
  authorize_resource
  before_action :authenticate_user!

  before_action :set_ticket_status, only: %i[ show edit update destroy ]

  layout "dashboard"

  # GET /ticket_statuses or /ticket_statuses.json
  def index
    @ticket_statuses = TicketStatus.all
  end

  # GET /ticket_statuses/1 or /ticket_statuses/1.json
  def show
  end

  # GET /ticket_statuses/new
  def new
    @ticket_status = TicketStatus.new
  end

  # GET /ticket_statuses/1/edit
  def edit
  end

  # POST /ticket_statuses or /ticket_statuses.json
  def create
    @ticket_status = TicketStatus.new(ticket_status_params)

    respond_to do |format|
      if @ticket_status.save
        @ticket_statuses = TicketStatus.all
        format.html { redirect_to @ticket_status, notice: "Ticket status was successfully created." }
        format.json { render :show, status: :created, location: @ticket_status }
        format.js
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ticket_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ticket_statuses/1 or /ticket_statuses/1.json
  def update
    respond_to do |format|
      if @ticket_status.update(ticket_status_params)
        @ticket_statuses = TicketStatus.all
        format.html { redirect_to @ticket_status, notice: "Ticket status was successfully updated." }
        format.json { render :show, status: :ok, location: @ticket_status }
        format.js
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ticket_status.errors, status: :unprocessable_entity }
      end
    end
  end


  def delete
    @ticket_status = TicketStatus.find(params[:ticket_status_id])
  end

  # DELETE /ticket_statuses/1 or /ticket_statuses/1.json
  def destroy
    @ticket_status.destroy
    respond_to do |format|
      format.html { redirect_to ticket_statuses_url, notice: "Ticket status was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket_status
      @ticket_status = TicketStatus.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ticket_status_params
      params.require(:ticket_status).permit(:name)
    end
end
