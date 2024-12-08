class Employee < ApplicationRecord
  has_many :reimbursement_claims, dependent: :destroy
  belongs_to :company
end
