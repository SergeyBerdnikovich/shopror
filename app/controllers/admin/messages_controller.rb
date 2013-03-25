class Admin::MessagesController < ApplicationController
  layout "admin"

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.get_rcvd_messages(current_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @message = Message.find(params[:id])
    @dialog_messages = Message.get_dialog_messages(@message.from_user.id, current_user.id)
    Message.get_rcvd_messages(current_user.id).each do |message|
      message.update_attribute(:is_read, 't')
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.json
  def new
    @message = Message.new(:to_user_id => params[:user_id])

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
    @message.is_read = :false

    respond_to do |format|
      if @message.save
        format.html { redirect_to admin_messages_path, notice: 'Message was successfully created.' }
        format.json { render json: @message, status: :created, location: @message }
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end
end
