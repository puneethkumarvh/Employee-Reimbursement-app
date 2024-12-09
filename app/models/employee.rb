class Employee < ApplicationRecord
  has_many :reimbursement_claims, dependent: :destroy
  belongs_to :company
  after_create :increment_employee_count
  after_destroy :decrement_employee_count
  before_destroy :reduce_company_reimbursement_total
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

  private

  def increment_employee_count
    company.increment!(:employee_count)
  end

  def decrement_employee_count
    company.decrement!(:employee_count) if company.employee_count > 0
  end

  def reduce_company_reimbursement_total
    claimed_sum = reimbursement_claims.unscope(:where).sum(:amount)
    company.decrement_reimbursement_total(claimed_sum)
  end
end
