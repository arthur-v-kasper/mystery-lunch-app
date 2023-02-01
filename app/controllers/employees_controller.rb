# frozen_string_literal: true

class EmployeesController < ApplicationController
  before_action :authorize, only: %i[create update destroy]
  before_action :set_employee, only: %i[show update destroy]

  def index
    @department_id = params['department']
    return employees_by_department if @department_id

    @employees = Employee.all
  end

  def show; end

  def create
    Employee.create!(params_employee)
    ManagerLunch::SetLastEmployee.call(MysteryLunch::CURRENT_YEARMONTH)
    render json: { messsage: 'The employee was created successfully.' }, status: :ok
  end

  def destroy
    @employee.inactivated!
    ManagerLunch::HandleRemainingEmployees.call(@employee.id)
    render json: { messsage: 'The employee was deleted successfully.' }, status: :ok
  end

  def update
    @employee.update!(params_employee)
    render json: { messsage: 'The employee was updated successfully.' }, status: :ok
  end

  private

  def params_employee
    params.require(:employee).permit(:full_name, :email, :department_id)
  end

  def employees_by_department
    @employees = Employee.where(department_id: @department_id)
  end

  def set_employee
    @employee = Employee.find(params[:id])
  end
end
