class CustomUsersController < ApplicationController
	
		before_action :authenticate_user!
		layout "dashboard"

    before_action :set_user, only: [:show, :edit, :update, :destroy] # probably want to keep using this
    
    

    
		def new
		
		
			@entity_types = EntityType.all
			@entities = Entity.all
			
			@roles = Role.where.not(name: "superuser")
		
			#@roles = Role.all
			@user = User.new
			@user.build_profile
		end

		def get_entities
			puts "ID: #{params[:id]}"
			@entities = Entity.where(entity_type_id: params[:id])#.map { |entity| [entity.name, entity.id] }.unshift('Sélectionner')
			puts "ENTITIES: #{@entities.inspect}"
		end

		def get_services
			puts "ID: #{params[:id]}"
			@services = Service.where(division_id: params[:id]).map { |service| [service.name, service.id] }.unshift('Sélectionner')
		end
	
		def create
			
		@user = User.new(user_params)
		@user.created_by = current_user.id

			respond_to do |format|
				if @user.save
					#@user.build_profile
					@users = User.where.not(id: current_user.id)
					record_activity("Créer un nouvel utilisateur (ID: #{@user.id})")

					format.html { redirect_to all_users_path, notice: "Compte d'utilisateur crée avec succès" }
					format.json { render :show, status: :created, location: @user }
					format.js
		

			
			
				else
					format.html { render :new }
					format.json { render json: @user.errors, status: :unprocessable_entity }
					format.js
				end
			end
		end
		
		def create_admin
		end

	# Index
    def index
    	
			@users = User.where.not(id: current_user.id)
		
			record_activity("Afficher la liste des utilisateurs.")

    end
    
    def unregistered
     
    end
	
    # GET /users/1
    # GET /users/1.json
	def show
		
    end

    # GET /users/1/edit
		def edit
			
			@entity_types = EntityType.all
			@entities = Entity.all

			@roles = Role.where.not(name: "superuser")
			@user.profile || @user.build_profile 
    end

    def delete
    	@user = User.find(params[:id])
    end

    def get_disable
        @user = User.find(params[:id]) if params[:id].present?
     
	end
	
    def post_disable
	  	@user = User.find(params[:id]) if params[:id].present?
	  
      	respond_to do |format|
        	if @user.update_attributes(status: 'disable')
						@users = User.where.not(id: current_user.id)
						record_activity("Désactiver le compte d'un utilisateur (ID: #{@user.id})")

				format.html { redirect_to @user, notice: "Compte d'utilisateur désactiver avec succès." }
				format.json { render :show, status: :ok, location: @user }
				format.js
        
				# Send mail to user.
				#url = user_session_url
				#UserMailer.disable_user_mail(@user.email, @user.password, url).deliver_now
			else
				format.html { render :edit }
				format.json { render json: @user.errors, status: :unprocessable_entity }
				format.js
			end
		end
   
    end

    def get_enable
    	@user = User.find(params[:id]) if params[:id].present?
   
	end
	
	# Enable user account.
  	def post_enable
		@user = User.find(params[:id]) if params[:id].present?
		respond_to do |format|
      		if @user.update_attributes(status: 'enable')
						@users = User.where.not(id: current_user.id)
						record_activity("Activer le compte d'un utilisateur (ID: #{@user.id})")

				format.html { redirect_to @user, notice: "Compte d'utilisateur activé avec succè." }
				format.json { render :show, status: :ok, location: @user }
				format.js
      
				

				Thread.new do
					Rails.application.executor.wrap do
					  # your code here
					end
				  end
			  
			else
				format.html { render :edit }
				format.json { render json: @user.errors, status: :unprocessable_entity }
				format.js
			end
      	end
 
  	end

    

	def destroy
    	@users = User.all
    
    	if @user.destroy
				@users = User.where.not(id: current_user.id)
        record_activity("Supprimer un utilisateur (ID: #{@user.id})")

				respond_to do |format|
					format.html { redirect_to all_users_path, notice: "Compte d'utilisateur a été supprimer avec succès!" }
					format.json { head :no_content }
					format.js
			
					
			
				end
		end

 	end

   	

    # # PATCH/PUT /users/1
    # # PATCH/PUT /users/1.json
    def update
		respond_to do |format|
			
			if params[:user][:password].blank? #&& params[:user][:password_confirmation].blank?
				params[:user].delete(:password)
				params[:user].delete(:password_confirmation)
			end

			if @user.update(user_params)
				@users = User.where.not(id: current_user.id)
        record_activity("Modifier un utilisateur (ID: #{@user.id})")

				format.html { redirect_to all_users_path, notice: "Compte d'utilisateur modifié avec succès." }
				format.json { render :show, status: :ok, location: @user }
				format.js
			

	
				  
				
			else
				format.html { render :edit }
				format.json { render json: @user.errors, status: :unprocessable_entity }
				format.js
			end
      	end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
      if !@user.nil?
        return @user
        
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password,:password_confirmation, :role_id,  profile_attributes: [:first_name, :last_name, :civility,  :entity_id, :position])
    end

end