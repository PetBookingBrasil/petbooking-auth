class UsersController < ApplicationController

  def index
    render json: User.search('*').results
  end

  def show
    render json: User.search(params['q'], fields:[:name, :cpf, :phone, :email], match: :word_start).results
  end

  def create
    ActiveRecord::Base.transaction do
      @user = User.new(user_attributes)
      @user.save!
      @session = @user.sessions.new(session_attributes)
      @session.save!
    end
  rescue => e
    render :nothing, status: 422
  end

  def update
  end

  private

  def user_attributes
    params[:data][:attributes].permit(:email, :password, :name, :phone, :provider)
  end

  def session_attributes
    params[:data][:attributes].permit(:device, :application, :provider, :provider_uuid)
  end
end
