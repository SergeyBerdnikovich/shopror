class PagesController < ApplicationController
  layout "welcome"

  def show_page
    @page = Page.find(params[:id])
    @featured_products = Product.limit(2).active.where(:featured => true)
  end

  def brands
    @brands = Brand.includes(:products).all
  end

  def new_products
    @latest_products = Product.limit(9).active
  end

  def featured_products
    @featured_products = Product.active.where(:featured => true)
  end
end
