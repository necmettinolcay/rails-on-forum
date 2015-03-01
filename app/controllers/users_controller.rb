class UsersController < ApplicationController
  before_action :select_user, only: [:show, :edit, :update, :destroy]
  before_action :allowed?,    only: [:edit, :create, :destroy]
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	
  	if @user.save
      login(@user)
  	  redirect_to profile_path(@user), notice:'Aramıza hoş geldin.'
  	else
  		render :new
  	end
  end

  def show
  	@data = []

  	if params[:sayfa]
  	  render layout: 'profile', locals: {page: params[:sayfa]}
  	else
  	  render layout: 'profile', locals: {page: 'konular' }
  	end
  end

  def edit
    render layout: "profile"
  end

  def update
  	update_params = user_params
    if update_params.has_key?(:password)
  	  update_params.delete([:password, :password_confirmation])
  	end

    if @user.update(user_params)
  	  redirect_to profile_path(@user), notice: 'Profil bilgilerin güncellendi.'
  	else
  	  render :edit, layout: "profile"
  	end
  end

  def destroy
  	@user.destroy
  	redirect_to '/'
  end 


  private
  

  def user_params
  	params.require(:user).permit!
  end

  def select_user
  	@user = User.find_by_username(params[:id])
  end

  def allowed?
    user = select_user

    unless current_user == user
      redirect_to profile_path(user), alert: 'Bunu yapmaya yetkiniz yok!'
    end
  end
end
