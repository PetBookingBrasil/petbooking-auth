# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  def create
    super
  end

  def update
    super
  end

  private

  def permitted_params
  end
end
