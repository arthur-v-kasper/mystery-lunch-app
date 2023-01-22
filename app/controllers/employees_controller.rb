# frozen_string_literal: true

class EmployeesController < ApplicationController
  before_action :authorize, only: %i[create update destroy]

  def index
    @employees = Employee.all
    render json: @employees, status: :ok
  end

  def create
    Employee.create!(params_employee)
    ManagerLunch::SetLastEmployee.call(MysteryLunch::CURRENT_YEARMONTH)
    render json: 'The employee was created successfully.', status: :ok
  end

  def destroy
    @employee = Employee.find(params[:id])
    @employee.inactivated!
    ManagerLunch::HandleRemainingEmployees.call(@employee.id)
    render json: 'The employee was deleted successfully.', status: :ok
  end

  def update
    @employee = Employee.find(params[:id])
    @employee.update!(params_employee)
    render json: 'The employee was updated successfully.', status: :ok
  end

  private

  def params_employee
    params.require(:employee).permit(:full_name, :email, :department_id)
  end
end
