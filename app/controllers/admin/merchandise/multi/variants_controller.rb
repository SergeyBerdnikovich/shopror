class Admin::Merchandise::Multi::VariantsController < Admin::BaseController
  def edit
    @product = Product.includes(:properties,:product_properties, {:prototype => :properties}).find(params[:product_id])

    form_info
    render :layout => 'admin_markup'
  end

  def update
    @product = Product.find(params[:product_id])

    if @product.update_attributes(params[:product])
      flash[:notice] = "Successfully updated variants"
      redirect_to admin_merchandise_product_url(@product)
    else
      form_info
      render :action => :edit, :layout => 'admin_markup'
    end
  end

  def create
    @product = Product.find(params[:product_id])
    @product.variants.create!(:sku => 0, :cost => 0, :price => 0)

    redirect_to edit_admin_merchandise_multi_product_variant_path(@product)
  end

  def variant_image
    @product = Product.find(params[:product_id])
    @image = Image.new(:variant_id => params[:variant_id], :imageable_id => @product.id, :imageable_type => 'Product')
  end

  private

  def form_info
    @brands = Brand.all.collect{|b| [b.name, b.id] }
  end
end