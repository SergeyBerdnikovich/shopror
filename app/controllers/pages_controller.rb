class PagesController < ApplicationController
  layout "welcome"

  def show_page
    @page = Page.find(params[:id])
    @featured_products = Product.limit(2).active.where(:featured => true)
  end
end
