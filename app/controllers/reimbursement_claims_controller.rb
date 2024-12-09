class ReimbursementClaimsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_company
    before_action :set_employee
  
    def index
      @reimbursement_claims = @employee.reimbursement_claims
    end
  
    def new
      @reimbursement_claim = @employee.reimbursement_claims.new
    end
  
    def create
      @reimbursement_claim = @employee.reimbursement_claims.new(reimbursement_claim_params)
      if @reimbursement_claim.save
        redirect_to company_employee_reimbursement_claims_path(@company, @employee), notice: 'Reimbursement Claim was successfully created.'
      else
        render :new, notice: 'All the fields are mandatory'
      end
    end
  
    def show
      @reimbursement_claim = @employee.reimbursement_claims.find(params[:id])
    end

    def edit
      @reimbursement_claim = @employee.reimbursement_claims.find(params[:id]) # Find the claim to edit
    end

    def update
        @reimbursement_claim = @employee.reimbursement_claims.find(params[:id])
        if @reimbursement_claim.update(reimbursement_claim_params)
            redirect_to company_employee_reimbursement_claims_path(@company, @employee), notice: 'Reimbursement Claim was successfully updated.'
        else
            render :edit, status: :unprocessable_entity
        end
    end

      def destroy
        @reimbursement_claim = @employee.reimbursement_claims.find(params[:id])
      
        # Optionally delete associated receipts if required
        @reimbursement_claim.receipts.purge
      
        @reimbursement_claim.destroy
        respond_to do |format|
          format.html { redirect_to company_employee_reimbursement_claims_path(@company, @employee), notice: 'Reimbursement Claim was successfully deleted.' }
          format.json { head :no_content }
        end
      end
      
    
  
    private
  
    def reimbursement_claim_params
      params.require(:reimbursement_claim).permit(:purpose, :amount, :date_of_expenditure, receipts:[])
    end

    def set_company
        @company = Company.find(params[:company_id])
    end
  
    def set_employee
        @employee = @company.employees.find(params[:employee_id])
    end
  end
  