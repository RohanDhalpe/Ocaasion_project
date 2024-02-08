class UsersController < ApplicationController
  def index
    @users = User.all
    if params[:email]
      @users = @users.find_by!(email: params[:email])
    elsif params[:name]
      @users = @users.find_by!(name: params[:name])
    end
    render json: @users
  end

  def create
    @user = User.create!(create_params)
    if @user.valid?
      @token = encode_token(@user.id)
      render json: { user: @user, token: @token }
    else
      render json: { error: 'Invalid parameters.' }
    end
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }
    else
      render json: { error: 'Invalid email or password.' }
    end
  end

  def update
    @user = User.find_by(email: params[:email])
    if @user
      @user.update(update_params)
      render json: @user
    else
      render json: { error: 'User not found.' }
    end
  end

  def search
    begin
      @user = User.find_by!(email: params[:email])
      render json: @user
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'User not found.' }
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    if @user
      @user.destroy
      render json: { message: 'User deleted successfully.' }
    else
      render json: { error: 'User not found.' }, status: :not_found
    end
  end

  private

  def create_params
    params.require(:user).permit(:email, :password, :name)
  end

  def update_params
    params.require(:user).permit(:name)
  end
end
