class SessionsController < ApplicationController
  def new
  end

  def create
    customer = Customer.find_by(login: params[:session][:login], password: params[:session][:password])
    if customer
      # Log the user in and redirect to user's show page
      log_in customer
      redirect_to customer
    else
      # create an error message
      flash.now[:danger] = 'Invalid login/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end
