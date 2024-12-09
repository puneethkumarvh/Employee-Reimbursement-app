class ReimbursementClaim < ApplicationRecord
  has_many_attached :receipts, dependent: :destroy
  belongs_to :employee
  before_destroy :update_company_total_reimbursements
  after_commit :update_company_total_reimbursements, on: %i[create update]

  validates :purpose, :date_of_expenditure, :receipts, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }

  private

  def update_company_total_reimbursements
    company = employee.company
    return if company.frozen? || company.destroyed?

    new_total = company.employees.joins(:reimbursement_claims).sum(:amount)
    company.update(reimbursement_total: new_total)
  end
end
