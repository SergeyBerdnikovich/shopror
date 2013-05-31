class Admin::Merchandise::SimpleProductsController < Admin::BaseController
  helper_method :all_properties

  def new
    form_info
    if @prototypes.empty?
      flash[:notice] = "You must create a prototype before you create a product."
      redirect_to new_admin_merchandise_prototype_url
    else
      @product            = Product.new
      @product.prototype  = Prototype.new
    end
  end

  def create
    @product = Product.new(params[:product])

    if @product.save
      flash[:notice] = "Success, You should create a variant for the product."
      redirect_to edit_admin_merchandise_simple_product_path(@product)
    else
      form_info
      flash[:error] = "The product could not be saved"
      render :action => :new
    end
  end

  def edit
    @product = Product.includes(:properties,:product_properties, {:prototype => :properties}).find(params[:id])
    form_info
  end

  def update
    @product = Product.find(params[:id])

    if @product.update_attributes(params[:product])
      @product.variants.each_with_index do |variant, i|
        variant.inventory.update_attributes(params[:product][:variants_attributes]["#{i}"][:inventory_attributes])
      end
      redirect_to edit_admin_merchandise_simple_product_path(@product)
    else
      form_info
      render :action => :edit
    end
  end

  def description_form
    @product = Product.find(params[:id])
  end

  def description
    @product = Product.find(params[:id])

    if @product.update_attributes(params[:product])
      flash[:notice] = "Successfully updated description."
      redirect_to description_form_admin_merchandise_simple_product_path(@product)
    else
      render :action => :description_form
    end
  end

  def property_form
    @product = Product.find(params[:id])
  end

  def property
    @product = Product.find(params[:id])

    if @product.update_attributes(params[:product])
      flash[:notice] = "Successfully updated properties."
      redirect_to property_form_admin_merchandise_simple_product_path(@product)
    else
      render :action => :property_form
    end
  end

  def variant_form
    @product = Product.includes(:properties,:product_properties, {:prototype => :properties}).find(params[:id])
    variant_form_info
  end

  def variant
    @product = Product.find(params[:id])

    if @product.update_attributes(params[:product])
      flash[:notice] = "Successfully updated variants"
      redirect_to variant_form_admin_merchandise_simple_product_path(@product)
    else
      variant_form_info
      render :action => :variant_form
    end
  end

  def create_variant
    @product = Product.find(params[:id])
    @product.variants.create!(:sku => 0, :cost => 0, :price => 0)

    redirect_to variant_form_admin_merchandise_simple_product_path(@product)
  end

  def variant_image
    @product = Product.find(params[:id])
    @image = Image.new(:variant_id => params[:variant_id], :imageable_id => @product.id, :imageable_type => 'Product')
  end

  def inventory
    @product = Product.includes(:variants).find(params[:id])
  end

  def images_form
    @product = Product.includes(:images).find(params[:id])
  end

  def destroy_image
    @image = Image.find(params[:id])
    @image.destroy
    product = Product.find(params[:permalink])

    respond_to do |format|
      if params[:permalink].present?
        format.html { redirect_to images_form_admin_merchandise_simple_product_path(product) }
      else
        format.html { redirect_to admin_images_url }
        format.json { head :no_content }
      end
    end
  end

  def price_for_all
    product = Product.find(params[:id])
    if product && params[:price_for_all].present?
      product.variants.each do |variant|
        variant.update_attribute(:price, params[:price_for_all])
      end
      flash[:notice] = "Price for all products successfully updated."
      redirect_to edit_admin_merchandise_simple_product_path(product)
    else
      flash[:notice] = "Error updated price for all products."
      redirect_to edit_admin_merchandise_simple_product_path(product)
    end
  end

  private

    def form_info
      @prototypes               = Prototype.all.collect{|pt| [pt.name, pt.id]}
      @all_properties           = Property.all
      @select_shipping_category = ShippingCategory.all.collect {|sc| [sc.name, sc.id]}
      @brands                   = Brand.order(:name).all.collect {|ts| [ts.name, ts.id]}
    end

    def variant_form_info
      @brands = Brand.all.collect{|b| [b.name, b.id] }
    end

    def all_properties
     @all_properties ||= Property.all.map{|p| [ p.identifing_name, p.id ]}
    end
end