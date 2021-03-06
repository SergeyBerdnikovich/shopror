class Admin::ImagesController < ApplicationController
  layout "admin"

  # GET /images
  # GET /images.json
  def index
    @images = Image.where(:for_slider => true)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @images }
    end
  end

  # GET /images/1
  # GET /images/1.json
  def show
    @image = Image.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @image }
    end
  end

  # GET /images/new
  # GET /images/new.json
  def new
    @image = Image.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @image }
    end
  end

  # GET /images/1/edit
  def edit
    @image = Image.find(params[:id])
  end

  # POST /images
  # POST /images.json
  def create
    @image = Image.new(params[:image])

    respond_to do |format|
      if @image.save
        format.html { redirect_to admin_image_path @image, notice: 'Image was successfully created.' }
        format.json { render json: @image, status: :created, location: @image }
      else
        format.html { render action: "new" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /images/1
  # PUT /images/1.json
  def update
    @image = Image.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.html { redirect_to admin_image_path @image, notice: 'Image was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_with_variant
    @image = Image.create!(params[:image])

    redirect_to edit_admin_merchandise_multi_product_variant_path(@image.imageable_id)
  end

  def update_with_variant
    @image = Image.find(params[:id])

    @image.update_attribute(:variant_id, params[:variant_id])

    redirect_to edit_admin_merchandise_multi_product_variant_path(params[:product_id])
  end

  def create_with_simple_variant
    @image = Image.create!(params[:image])

    redirect_to variant_form_admin_merchandise_simple_product_path(@image.imageable_id)
  end

  def update_with_simple_variant
    @image = Image.find(params[:id])

    @image.update_attribute(:variant_id, params[:variant_id])

    redirect_to variant_form_admin_merchandise_simple_product_path(params[:product_id])
  end

  def create_with_fast_variant
    @image = Image.create!(params[:image])

    redirect_to edit_admin_merchandise_fast_product_path(@image.imageable_id)
  end

  def update_with_fast_variant
    @image = Image.find(params[:id])

    @image.update_attribute(:variant_id, params[:variant_id])

    redirect_to edit_admin_merchandise_fast_product_path(params[:product_id])
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      if params[:permalink].present?
        format.html { redirect_to edit_admin_merchandise_images_product_path(params[:permalink]) }
      else
        format.html { redirect_to admin_images_url }
        format.json { head :no_content }
      end
    end
  end
end
