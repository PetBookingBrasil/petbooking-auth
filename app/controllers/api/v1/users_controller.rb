module Api
  module V1
    class UsersController < Grape::API
      version 'v1', using: :header, vendor: :pet_booking
      format :json


      resource :users do
        desc 'Creates a new user'
        post do
          ActiveRecord::Base.transaction do
            @user = User.new(user_attributes)
            @user.save!
            @session = @user.sessions.new(session_attributes)
            @session.save!
          end
        end
      end







      # def create
      #   ActiveRecord::Base.transaction do
      #     @user = User.new(user_attributes)
      #     @user.save!
      #     @session = @user.sessions.new(session_attributes)
      #     @session.save!
      #   end
      # rescue => e
      #   render json: { errors: e.message.as_json }, status: 422
      # end

      # def show
      #   render json: User.search(params['q'], fields:[:name, :cpf, :phone, :email], match: :word_start).results
      # end

      # def update
      #   ActiveRecord::Base.transaction do
      #     @user = User.find(params[:id])
      #     @user.update(user_attributes)
      #   end
      # rescue => e
      #   render json: { errors: e.message.as_json }, status: 422
      # end

      # private

      # def user_attributes
      #   params[:data][:attributes].permit(:email, :password, :name, :phone, :provider, :birthday, :gender, :avatar, :nickname, :cpf, :city,
      #                                     :state, :search_range, :zipcode, :street, :street_number, :neighborhood, :skype, :complement, :source,
      #                                     :validation_code, :created_by_business, :landline, :remember_created_at)
      # end

      # def session_attributes
      #   params[:data][:attributes].permit(:device, :application, :provider, :provider_uuid)
      # end
    end
  end
end