class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:uuid, :birthday, :current_sign_in_at, :sign_in_count, :gender, :avatar, :current_sign_in_ip, :email, :last_sign_in_ip, :phone, :name, :nickname, :reset_password_token, :encrypted_password, :reset_password_sent_at, :remember_created_at, :last_sign_in_at, :bitmask, :http_user_agent, :avatar_processing, :cpf, :city, :state, :search_range, :zipcode, :street, :street_number, :password_token_expires_at, :neighborhood, :skype, :complement, :source, :validation_code, :created_by_business, :landline, :application_source)
    end
end
