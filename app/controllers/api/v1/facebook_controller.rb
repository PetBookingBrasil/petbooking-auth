module Api
  module V1
    class FacebookController < ApplicationController
      before_action :check_provider
      before_action :check_user_existence
      before_action :set_session

      def auth
        render json: @session, status: :ok
      end

      private

      def check_provider
        if permitted_params[:provider] != 'facebook'
          render json: "Only 'facebook' provider allowed", status: :unprocessable_entity
          return
        end
      end

      def check_user_existence
        if User.find_by(email: permitted_params[:email])
          @user = User.find_by(email: permitted_params[:email])
        else
          render json: "Record not found", status: :not_found
          return
        end
      end

      def set_session
        if Session.find_by(permitted_params.merge(user_id: @user.id).except(:email))
          @session = Session.find_by(permitted_params.merge(user_id: @user.id).except(:email))
        else
          @session = Session.new(
            permitted_params.merge(user_id: @user.id, expires_at: Time.now + 1.years)
                            .except(:email)
          )

          if @session.save
            @session
          else
            render json: @session.errors, status: :unprocessable_entity
            return
          end
        end
      end

      def permitted_params
        params.require(:session)
              .permit(
                :device,
                :application,
                :provider,
                :provider_uuid,
                :email)
      end
    end
  end
end
