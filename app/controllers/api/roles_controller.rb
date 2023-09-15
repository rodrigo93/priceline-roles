# frozen_string_literal: true

class Api::RolesController < ApplicationController
  before_action :set_role, only: %i[show memberships]

  def index
    @roles = Role.page(params[:page]).per(params[:per])

    render json: @roles, status: :ok
  end

  def show
    render json: @role, status: :ok
  end

  def create
    @role = Role.create!(role_params)

    render json: @role, status: :created
  end

  def memberships
    @memberships = @role.memberships.page(params[:page]).per(params[:per])

    render json: @memberships, status: :ok
  end

  private

  def role_params
    params.require(:role).permit(:name)
  end

  def set_role
    @role = Role.find(params[:id])
  end
end
