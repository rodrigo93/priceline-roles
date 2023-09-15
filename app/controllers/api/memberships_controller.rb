# frozen_string_literal: true

class Api::MembershipsController < ApplicationController
  def show
    @membership = Membership.find(params[:id])

    render json: @membership, status: :ok
  end

  def create
    @membership = Membership.create!(membership_params)

    render json: @membership, status: :created
  end

  private

  def membership_params
    params.require(:membership).permit(:user_id, :role_id, :team_id)
  end
end
