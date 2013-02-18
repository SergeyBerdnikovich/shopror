class Myaccount::CreditCardsController < Myaccount::BaseController
  def index
    @credit_cards = current_user.payment_profiles
  end

  def show
    @credit_card = current_user.payment_profiles.find(params[:id])
  end

  def new
    @credit_card = current_user.payment_profiles.new
  end

  def create
    @credit_card = current_user.payment_profiles.new(params[:credit_card])
    if @credit_card.save
      flash[:notice] = "Successfully created credit card."
      redirect_to myaccount_credit_card_url(@credit_card)
    else
      render :action => 'new'
    end
  end

  def edit
    @credit_card = current_user.payment_profiles.find(params[:id])
  end

  def update
    @credit_card = current_user.payment_profiles.find(params[:id])
    if @credit_card.update_attributes(params[:credit_card])
      flash[:notice] = "Successfully updated credit card."
      redirect_to myaccount_credit_card_url(@credit_card)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @credit_card = current_user.payment_profiles.find(params[:id])
    @credit_card.inactivate!
    flash[:notice] = "Successfully destroyed credit card."
    redirect_to myaccount_credit_cards_url
  end

  private

  def selected_myaccount_tab(tab)
    tab == 'credit_cards'
  end
end
