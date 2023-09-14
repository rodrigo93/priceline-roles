# frozen_string_literal: true

class Api::RolesController < ApplicationController
  # TODO:
  # - [] implement
  # - [] Add pagination
  def index; end

  def show
    @role = Role.find(params[:id])

    render json: @role, status: :ok
  end

  def create
    @role = Role.create!(role_params)

    render json: @role, status: :created
  end

  private

  def role_params
    params.require(:role).permit(:name)
  end
end
