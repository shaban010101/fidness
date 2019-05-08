class SessionsController < ApplicationController
  def new
    @trainer = Trainer.find(params[:trainer_id])
  end

  def create
    purchase = PurchaseForm.new(current_user, sessions_params)
    if purchase.save
      redirect_to action 'show'
    else

    end
  end

  def show

  end
  
  private
  
  def sessions_params
    params.permit(:option, :address_line_1, :city, :post_code, :card_number, :cvv,:expiry_month_year, :trainer_id)
  end
end
