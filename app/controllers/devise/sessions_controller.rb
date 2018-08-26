class Devise::SessionsController < ApplicationController

  def new
    @meta_title = "Sign In | Test App"
  end

  def create
  	user = User.find_by(email: params[:user][:email])
  	if user.present?
  	  status = user.valid_password?(params[:user][:password])
      if status && user.email_confirmed == true
  	  	sign_in(user)
        flash[:success] = "Login Successful."
        redirect_to new_sku_path
      else
        if user.email_confirmed == true
          flash[:danger] = "Invalid login credentials."
          redirect_to "/login"
        else
          flash[:danger] = "Please Confirm Email before login."
        end
      end
    else
      flash[:danger] = "Invalid login credentials."
      redirect_to "/login"
    end
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    redirect_to new_user_registration_path
  end
end
