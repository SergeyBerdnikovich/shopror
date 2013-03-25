class Myaccount::MessagesController < Myaccount::BaseController
  # GET /messages
  # GET /messages.json
  def index
    @featured_products = Product.limit(2).active.where(:featured => true)
    @user_admin = Role.find_by_name('super_administrator').users.first
    @messages = Message.get_dialog_messages(current_user.id, @user_admin.id)
    Message.get_rcvd_messages(current_user.id).each do |message|
      message.update_attribute(:is_read, 't')
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
  end

  # GET /messages/new
  # GET /messages/new.json
  def new
    @message = Message.new
    @featured_products = Product.limit(2).active.where(:featured => true)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(params[:message])
    @message.from_user_id = current_user.id
    @message.to_user_id = Role.find_by_name('super_administrator').users.first.id
    @message.is_read = :false

    respond_to do |format|
      if @message.save
        format.html { redirect_to myaccount_messages_path, notice: 'Message was successfully created.' }
        format.json { render json: @message, status: :created, location: @message }
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end
end
