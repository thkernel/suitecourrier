class NotificationsController < ApplicationController
  before_action :authenticate_user!
  layout "dashboard"
  
  before_action :set_notification, only: [:show, :edit, :update, :destroy]

  # GET /notifications
  # GET /notifications.json
  def index
    @notifications = current_user.recipient_notifications.order(id: :desc)
  end

  # GET /notifications/1
  # GET /notifications/1.json
  def show
    @notification.update_column(:readed_at, Time.now.strftime("%d/%m/%Y"))
  end

  # GET /notifications/new
  def new
    @notification = Notification.new
  end

  # GET /notifications/1/edit
  def edit
  end

  # POST /notifications
  # POST /notifications.json
  def create
    @notification = Notification.new(notification_params)

    respond_to do |format|
      if @notification.save
        format.html { redirect_to @notification, notice: 'Notification was successfully created.' }
        format.json { render :show, status: :created, location: @notification }
      else
        format.html { render :new }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notifications/1
  # PATCH/PUT /notifications/1.json
  def update
    respond_to do |format|
      if @notification.update(notification_params)
        format.html { redirect_to @notification, notice: 'Notification was successfully updated.' }
        format.json { render :show, status: :ok, location: @notification }
      else
        format.html { render :edit }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete
    @notification = Notification.find_by(uid: params[:notification_id])
  end

  # DELETE /notifications/1
  # DELETE /notifications/1.json
  def destroy
    @notification.destroy
    respond_to do |format|
      format.html { redirect_to notifications_url, notice: 'Notification was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      @notification = Notification.find_by(uid: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def notification_params
      params.require(:notification).permit(:type, :recipient_id, :content, :status, :read_at)
    end
end
