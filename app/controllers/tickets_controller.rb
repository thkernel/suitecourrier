class TicketsController < ApplicationController
  authorize_resource
  before_action :authenticate_user!
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  layout "dashboard"
  # GET /tickets
  # GET /tickets.json
  def index
    @tickets = Ticket.order(id: :desc)
    record_activity("Afficher la liste des tickets")

  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @ticket_priorities = TicketPriority.all
    @ticket_types = TicketType.all
    @ticket_statuses = TicketStatus.all
    role_ids = Role.where("name NOT IN (?)", ["superuser"]).map {|role| role.id}
    @recipients = User.where("role_id IN (?)", role_ids).map {|user| user.profile }
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
    @ticket_priorities = TicketPriority.all
    @ticket_types = TicketType.all
    @ticket_statuses = TicketStatus.all

    role_ids = Role.where("name NOT IN (?)", ["superuser"]).map {|role| role.id}
    @recipients = User.where("role_id IN (?)", role_ids).map {|user| user.profile }

    ticket_users = @ticket.ticket_users

    puts "EDIT TICKET: #{ticket_users.inspect}"

    @selected_ticket_users = ticket_users unless ticket_users.blank?


  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = current_user.tickets.build(ticket_params)

    #@ticket.ticket_status_id = TicketStatus.find_by(name: "En attente").id

    ticket_users = params[:recipients][:id]
    
    ticket_users.each do |ticket_user|
      unless ticket_user.empty?
        @ticket.ticket_users.build(recipient_id: ticket_user)
       

      end
    end

    respond_to do |format|
      if @ticket.save

        ticket_users.each do |ticket_user|
          unless ticket_user.empty?
            TicketAttributionEmailJob.perform_now(ticket_user, @ticket)
          end
        end

        puts "AFTER SAVE: #{@ticket.ticket_users.inspect}"
        
        record_activity("Créer un ticket (ID: #{@ticket.id})")

        @tickets = Ticket.order(id: :desc)
        format.html { redirect_to @ticket, notice: 'Ticket enregistré avec succès.' }
        format.json { render :show, status: :created, location: @ticket }
        format.js
      else

        @ticket_priorities = TicketPriority.all
        @ticket_types = TicketType.all
        @ticket_statuses = TicketStatus.all

        role_ids = Role.where("name NOT IN (?)", ["superuser"]).map {|role| role.id}
        @recipients = User.where("role_id IN (?)", role_ids).map {|user| user.profile }

        format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    @ticket.ticket_users.delete_all

    params[:recipients][:id].each do |ticket_user|
      unless ticket_user.empty?
        @ticket.ticket_users.build(recipient_id: ticket_user)
      end
    end
    respond_to do |format|
      if @ticket.update(ticket_params)
        record_activity("Modifier un ticket (ID: #{@ticket.id})")

        @tickets = Ticket.order(id: :desc)
        format.html { redirect_to @ticket, notice: 'Ticket modifié avec succès.' }
        format.json { render :show, status: :ok, location: @ticket }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end


  def delete
    @ticket = Ticket.find_by(uid: params[:ticket_id])
  end


  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      record_activity("Supprimer un ticket (ID: #{@ticket.id})")

      format.html { redirect_to tickets_url, notice: 'Ticket supprimé avec succès.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find_by(uid: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ticket_params
      params.require(:ticket).permit(:title, :ticket_type_id, :ticket_status_id, :ticket_priority_id, :content, :due_date, :start_date, :completed_date, files: [])
    end
end
