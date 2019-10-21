class UsersController < ApplicationController

  def index
    render json: User.search('*').results
  end

  def show
    render json: User.search(params['q'], fields:[:name, :cpf, :phone, :email, :petname], match: :word_start).results
  end
end
