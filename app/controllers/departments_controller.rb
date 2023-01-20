# frozen_string_literal: true

class DepartmentsController < ApplicationController
  def index
    @employees = Department.all
    render json: @employees, status: :ok
  end
end
