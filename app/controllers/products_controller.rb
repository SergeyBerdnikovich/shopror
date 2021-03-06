class ProductsController < ApplicationController

  def index
    products = Product.active.includes(:variants)

    product_types = nil
    if params[:product_type_id].present? && product_type = ProductType.find_by_id(params[:product_type_id])
      product_types = product_type.self_and_descendants.map(&:id)
    end
    if product_types
      @products = products.where('product_type_id IN (?)', product_types).paginate(:page => params[:page], :per_page => params[:per])
    else
      @products = products.page(params[:page]).paginate(:page => params[:page], :per_page => params[:per])
    end
  end

  def create
    if params[:q] && params[:q].present?
      @products = Product.standard_search(params[:q]).paginate(:page => pagination_page, :per_page => 15).results
    else
      @products = Product.where('deleted_at IS NULL OR deleted_at > ?', Time.zone.now )
    end

    render :template => '/products/index'
  end

  def show
    @product = Product.active.find(params[:id])
    form_info
    @cart_item.variant_id = @product.active_variants.first.try(:id)

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def form_info
    @cart_item = CartItem.new
  end

  def featured_product_types
    [ProductType::FEATURED_TYPE_ID]
  end
end
