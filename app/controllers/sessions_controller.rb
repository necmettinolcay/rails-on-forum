class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_username(params[:session][:username])

    if user && user.authenticate(params[:session][:password]) 
      login(user)
      redirect_to profile_path(user), notice: 'Oturum Açıldı.'
    else
      flash.now[:error] = "Kullanıcı adı/parola hatalı."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: 'Oturumunuz sonlandırıldı.'
  end
end
