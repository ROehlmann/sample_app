class SessionsController < ApplicationController
  
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  	  sign_in user
  	  redirect_back_or user
  	else 
  	  flash.now[:error] = 'Invalid email/password combination.'
  	  # We use flash.now instead of flash because a flash is displayed for 1 request.
  	  # As 'render' does not count as request the flash message will persist when
  	  # we click on the link to another page.
  	  render 'new'
  	end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
