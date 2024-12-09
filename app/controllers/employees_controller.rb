class EmployeesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_company

  def index
    @employees = @company.employees
  end

  def show
    @employee = @company.employees.find(params[:id]) rescue nil
    unless @employee 
      render json: { error: "Employee not found" }, status: :not_found
    end
  end

  def new
    @employee = @company.employees.new
  end

  def create
    @employee = @company.employees.new(employee_params)
    if @employee.save
      redirect_to company_employee_path(@company, @employee), notice: 'Employee was successfully created.'
    else
      render :new
    end
  end

  def edit
    @employee = @company.employees.find(params[:id])
  end

  def update
    @employee = @company.employees.find(params[:id])
    if @employee.update(employee_params)
      redirect_to @employee, notice: 'Employee was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @employee = @company.employees.find(params[:id])
    @employee.destroy
    redirect_to company_employees_path(@employee.company), notice: 'Employee was successfully destroyed.'
  end

  private

  def employee_params
    params.require(:employee).permit(:name, :email)
  end

  def set_company
    @company = current_user.companies.find_by(id: params[:company_id])
    unless @company
      render json: { error: "Company not found or does not belong to you" }, status: :not_found
    end
  end
end
