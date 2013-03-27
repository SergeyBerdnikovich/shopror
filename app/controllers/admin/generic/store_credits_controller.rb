class Admin::Generic::StoreCreditsController < ApplicationController
  layout "admin"

  # GET /store_credits
  # GET /store_credits.json
  def index
    @store_credits = StoreCredit.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @store_credits }
    end
  end

  # GET /store_credits/1
  # GET /store_credits/1.json
  def show
    @store_credit = StoreCredit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @store_credit }
    end
  end

  # GET /admin/pages/1/edit
  def edit
    @store_credit = StoreCredit.find(params[:id])
  end

  # PUT /admin/pages/1
  # PUT /admin/pages/1.json
  def update
    @store_credit = StoreCredit.find(params[:id])

    respond_to do |format|
      if @store_credit.update_attributes(params[:store_credit])
        format.html { redirect_to admin_generic_store_credit_path(@store_credit), notice: 'Store Credit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @store_credit.errors, status: :unprocessable_entity }
      end
    end
  end
end
