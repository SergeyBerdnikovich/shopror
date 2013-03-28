class Myaccount::MessagesController < Myaccount::BaseController
  # GET /messages
  # GET /messages.json
  def index
    @featured_products = Product.limit(2).active.where(:featured => true)
    @messages = Message.where(:from_user_id => current_user.id).group_by(&:ticket_id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
  end

  def show
    @user_admin = Role.find_by_name('super_administrator').users.first
    @messages = Message.get_dialog_messages(current_user.id, @user_admin.id, params[:ticket_id])
    @message = Message.new(:ticket_id => params[:ticket_id],
                           :from_user_id => current_user.id,
                           :to_user_id => @user_admin.id,
                           :is_read => false)
    Message.get_rcvd_messages(current_user.id, params[:ticket_id]).each do |message|
      message.update_attribute(:is_read, true)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @messages }
    end
  end

  # GET /messages/new
  # GET /messages/new.json
  def new
    @user_admin = Role.find_by_name('super_administrator').users.first
    @message = Message.new(:from_user_id => current_user.id,
                           :to_user_id => @user_admin.id,
                           :is_read => false)
    @message.build_ticket(:is_closed => false)
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

    respond_to do |format|
      if @message.save
        format.html { redirect_to myaccount_message_path(@message, :ticket_id => @message.ticket_id), notice: 'Message was successfully created.' }
        format.json { render json: @message, status: :created, location: @message }
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end
end
