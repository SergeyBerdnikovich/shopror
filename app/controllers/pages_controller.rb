class PagesController < ApplicationController
  layout "welcome"

  def show_page
    @page = Page.find(params[:id])
    @featured_products = Product.limit(2).active.where(:featured => true)
    #UserMailer.welcome_email(User.last).deliver
  end
end
