class UsersController < ApplicationController

  def create
    @user = User.new user_params
    @user.source = 'web'

    if @user.valid? && @user.save
      sign_in @user
      render jsonapi: @user
    else
      existing_user ||= User.check_existence_by_email_or_phone(@user.try(:email), @user.try(:phone).try(:value)).first
      if check_errors_params(@user) && existing_user.present?
        if user_params[:validation_code] && existing_user.validate_code(user_params[:validation_code].to_i) && check_password
          existing_user.update(user_params)
          sign_in existing_user.reload
          flash[:success] = 'Cadastro realizado com sucesso!'
          render "success_sign_up", locals: { path: root_path }
        elsif existing_user.generate_code
          @user.errors.add(:email, 'Conflito de email') if existing_user.email.present?
          render "validation_code_sign_up"
        else
          @user.errors.add(:email_existing, existing_user.email)
          render "error_sign_up"
        end

      else
        render "error_sign_up"
      end
    end
  end

  def registration_edit
    @current_user = current_user
  end

  def senha
    @current_user = current_user
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update_password
    if current_user.update_with_password(permitted_params)
      sign_in(current_user, :bypass => true)
      flash[:success] = "Cadastro atualizado!"
      render json
      render :senha
    else
      flash[:error] = "Não foi possível atualizar seu cadastro."
      render :senha
    end
  end

  def update
    if current_user.update(permitted_params)
      flash[:success] = "Cadastro atualizado!"
      render :registration_edit
    else
      flash[:error] = "Não foi possível atualizar seu cadastro."
      render :registration_edit
    end
  end

  def delete
    unless current_user.destroy
      flash[:error] = "Erro ao tentar cancelar conta. Entre em contato com o suporte."
    else
      redirect_to root_url
    end
  end

  private

  def check_password
    params[:user][:password].present? &&
    params[:user][:password_confirmation].present? &&
    params[:user][:password] == params[:user][:password_confirmation]
  end

  def check_errors_params(user)
    (user.errors.messages.values
         .flatten
         .all? & [I18n.t('activerecord.errors.models.user.attributes.email.taken'),
                  I18n.t('devise.registrations.phone_uniqueness')])
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation, :current_password, :email, :phone, :name, :provider, :gender, :birthday, :avatar_url, :accepts_terms, :source, :validation_code)
  end

    def permitted_params
      params.require(:user).permit(
        :name, :nickname, :cpf, :phone, :gender, :birthday,
        :zipcode, :state, :city, :neighborhood, :street,
        :street_number, :complement, :accepts_sms,
        :accepts_email, :skype,
        :current_password, :password, :password_confirmation
      )
    end
end
