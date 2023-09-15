# frozen_string_literal: true

class Api::MembershipsController < ApplicationController
  before_action :set_membership, only: %i[show role]

  def show
    render json: @membership, status: :ok
  end

  def create
    @membership = Membership.create!(membership_params)

    render json: @membership, status: :created
  end

  def role
    render json: @membership.role, status: :ok
  end

  private

  def set_membership
    @membership = Membership.find(params[:id])
  end

  def membership_params
    params.require(:membership).permit(:user_id, :role_id, :team_id)
  end
end
