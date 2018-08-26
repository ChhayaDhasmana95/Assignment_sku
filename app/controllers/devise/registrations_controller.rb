class Devise::RegistrationsController < ApplicationController
  
  # GET /resource/sign_up
  def new
    @user  =User.new
    @date = Time.now().strftime("%B %d, %Y")
  end

  # POST /resource
  def create
    user = User.new(user_params)
    if user.save
      UserMailer.confirmation_email(user).deliver_now 
      flash[:success] = "Please confirm your email address to continue"
      redirect_to new_user_registration_path(user: { email: params[:user][:email], password: params[:user][:password],password_confirmation: params[:user][:password_confirmation]})
    else
      unless params[:user][:password] == params[:user][:password_confirmation]
        flash[:danger] = "Password and Password Confirmation must be same."
        redirect_to new_user_registration_path(user: { email: params[:user][:email], password: params[:user][:password],password_confirmation: params[:user][:password_confirmation]})
      else
        flash[:danger] = "Mobile, Email should be unique and valid"
        redirect_to new_user_registration_path(user: { email: params[:user][:email], password: params[:user][:password],password_confirmation: params[:user][:password_confirmation]})
      end
    end
  end

  def confirm_email(confirm_token)
    @user = User.find_by(confirm_token: confirm_token)
    @user.update(email_confirmed: true)
    
  end

  def user_params
    user_params = params.require(:user).permit( :email, :password, :password_confirmation)
  end
end
