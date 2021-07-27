class DashboardController < ApplicationController
	
	before_action :authenticate_user!
	

	layout 'dashboard'
	
	def index

		
		@total_arrival_mails = current_user.arrival_mails.count
		@total_departure_mails = current_user.departure_mails.count
		#@total_requests = current_user.requests.count
		@total_documents = current_user.documents.count

		#@current_user_arrival_mails = current_user.arrival_mails.take(5)
		
		last_imputations = Imputation.where("recipient_id = ? OR user_id = ?", current_user.id, current_user.id)
		#last_imputations = last_imputations.select {|imputation| imputation.imputation_items.present?}
		@last_tasks = last_imputations.map {|imputation| imputation.imputation_items}.flatten
		
		#@last_requests = current_user.requests
		@last_arrival_mails = current_user.arrival_mails

		
		overdue_imputations = Imputation.where("recipient_id = ? OR user_id = ?", current_user.id, current_user.id)
		#overdue_imputations = overdue_imputations.select {|imputation| imputation.imputation_items.present?}

		@overdue_tasks = overdue_imputations.map {|imputation| imputation.imputation_items.where("due_date < ? AND task_status_id <> ? ", Time.now, TaskStatus.find_by(name: "Terminée").id)}.flatten
		@overdue_arrival_mails = ArrivalMail.where("to_answer = ? AND response_limit_time < ?", "Oui", Time.now)
		@overdue_tickets = Ticket.where("due_date < ? AND ticket_status_id <> ?", Time.now, TicketStatus.find_by(name: "Résolu").id).take(5)

		record_activity("Afficher le tableau de bord")
		
	end

	def unauthorize
		render layout: 'unauthorize'
	end

	
	
	

end