module Api
  module V1
    class SessionsController < ApplicationController
      before_action :load_user

      def create
        @session = @current_user.sessions.find_by(device: params[:device], application: params[:device], provider: params[:device], provider_uuid: params[:device])
        if @session.blank?
          @session = @current_user.sessions.new(permitted_params)
          unless @session.save
            render nothing: true, status: 422
          end
        end
        render json: @session.reload
      end

      def update
        @session = @current_user.sessions.find_by(device: params[:device], application: params[:device], provider: params[:device], provider_uuid: params[:device])
        if @session.update(permitted_params)
          render json: @session
        else
          render nothing: true, status: 422
        end
      end

      private

      def permitted_params
        params[:data][:attributes].permit(:device, :application, :provider, :provider_uuid)
      end

      def load_user
        @current_user = User.find_by(email: params[:email], encrypted_password: params[:encrypted_password])
        render nothing: true, status: 422 unless @current_user.present?
      end
    end
  end
end
