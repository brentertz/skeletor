class Admin::UsersController < Admin::BaseController
  before_filter :find_user, only: [:edit, :update, :delete, :destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 20)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: 'User created successfully'
    else
      render :new
    end
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete :password
      params[:user].delete :password_confirmation
    end

    if @user.update_attributes(user_params)
      redirect_to admin_users_path, notice: 'User updated successfully'
    else
      render :edit
    end
  end

  def delete
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, success: 'User deleted'
  end

  private

  def find_user
    id = params[:id] == 'current' ? current_user.id : params[:id]
    @user = User.find(id)
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
