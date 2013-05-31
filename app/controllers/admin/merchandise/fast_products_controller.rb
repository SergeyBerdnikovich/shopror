class Admin::Merchandise::FastProductsController < Admin::BaseController
  helper_method :all_properties

  def edit
    form_info
    all_properties
    if @prototypes.empty?
      flash[:notice] = "You must create a prototype before you create a product."
      redirect_to new_admin_merchandise_prototype_url
    else
      if params[:id] == '0'
        @product = Product.find_by_name('temporary')
        @product = Product.create!(:permalink => 'temporary',
                                   :shipping_category_id => 1,
                                   :product_type_id => 1,
                                   :name => 'temporary') unless @product
        redirect_to edit_admin_merchandise_fast_product_path(@product), :notice => 'complete this item...'
      else
        @product = Product.includes(:properties,:product_properties, {:prototype => :properties}).find(params[:id])
      end
      @product.prototype ? @product.prototype : @product.prototype = Prototype.new
    end
  end

  def update
    @product = Product.find(params[:id])

    if @product.update_attributes(params[:product])
      redirect_to edit_admin_merchandise_fast_product_path(@product), :notice => 'Successfully updated product.'
    else
      flash[:notice] = "Failed updated product."
      render :action => :edit
    end
  end

  def create_variant
    @product = Product.find(params[:id])
    @product.variants.create!(:sku => 0, :cost => 0, :price => 0)

    redirect_to edit_admin_merchandise_fast_product_path(@product)
  end

  def variant_image
    @product = Product.find(params[:id])
    @image = Image.new(:variant_id => params[:variant_id], :imageable_id => @product.id, :imageable_type => 'Product')
  end

  def price_for_all
    product = Product.find(params[:id])
    if product && params[:price_for_all].present?
      if product.variants.blank?
        product.variants.create!(:sku => 0, :cost => 0, :price => params[:price_for_all])
      else
        product.variants.each do |variant|
          variant.update_attribute(:price, params[:price_for_all])
        end
      end
      redirect_to edit_admin_merchandise_fast_product_path(product), :notice => "Price for product successfully updated."
    else
      redirect_to edit_admin_merchandise_fast_product_path(product), :notice => "Error updated price for product."
    end
  end

  private

  def form_info
    @prototypes               = Prototype.all.collect{|pt| [pt.name, pt.id]}
    @all_properties           = Property.all
    @select_shipping_category = ShippingCategory.all.collect {|sc| [sc.name, sc.id]}
    @brands                   = Brand.order(:name).all.collect {|ts| [ts.name, ts.id]}
  end

  def all_properties
    @all_properties2 ||= Property.all.map{|p| [ p.identifing_name, p.id ]}
  end
end