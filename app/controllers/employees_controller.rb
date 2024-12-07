class EmployeesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_company

  def index
    @employees = @company.employees
  end

  def show
    @employee = Employee.find(params[:id])
  end

  def new
    @company = Company.find(params[:company_id])
    @employee = @company.employees.new
  end

  def create
    @company = Company.find(params[:company_id])
    @employee = @company.employees.new(employee_params)
    if @employee.save
      redirect_to company_employee_path(@company, @employee), notice: 'Employee was successfully created.'
    else
      render :new
    end
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def update
    @employee = Employee.find(params[:id])
    if @employee.update(employee_params)
      redirect_to @employee, notice: 'Employee was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy
    redirect_to company_employees_path(@employee.company), notice: 'Employee was successfully destroyed.'
  end

  private

  def employee_params
    params.require(:employee).permit(:name, :email)
  end

  def set_company
    @company = Company.find(params[:company_id])
  end
end
