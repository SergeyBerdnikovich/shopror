class Admin::MessagesController < ApplicationController
  layout "admin"

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.where(:to_user_id => current_user.id).group_by(&:ticket_id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @message = Message.find(params[:id])
    current_user.id == @message.from_user.id ? from_user_id = @message.to_user.id : from_user_id = @message.from_user.id
    current_user.id == @message.from_user.id ? to_user_id = @message.to_user.id : to_user_id = @message.from_user.id
    @dialog_messages = Message.get_dialog_messages(from_user_id, current_user.id, params[:ticket_id])
    @new_message = Message.new(:ticket_id => params[:ticket_id],
                               :from_user_id => current_user.id,
                               :to_user_id => to_user_id,
                               :is_read => false)
    Message.get_rcvd_messages(current_user.id, params[:ticket_id]).each do |message|
      message.update_attribute(:is_read, true)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @message }
    end
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(params[:message])

    respond_to do |format|
      if @message.save
        format.html { redirect_to admin_message_path(@message, :ticket_id => @message.ticket_id), notice: 'Message was successfully created.' }
        format.json { render json: @message, status: :created, location: @message }
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end
end
