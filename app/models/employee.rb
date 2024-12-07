class Employee < ApplicationRecord
  has_many :reimbursement_claims
  belongs_to :company
end
