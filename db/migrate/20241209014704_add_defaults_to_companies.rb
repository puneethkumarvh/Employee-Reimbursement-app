class AddDefaultsToCompanies < ActiveRecord::Migration[7.0]
  def change
    change_column_default :companies, :employee_count, 0
    change_column_default :companies, :reimbursement_total, 0
  end
end
