class ReimbursementClaim < ApplicationRecord
  has_many_attached :receipts, dependent: :destroy
  belongs_to :employee
end
