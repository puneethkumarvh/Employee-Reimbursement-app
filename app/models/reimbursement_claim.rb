class ReimbursementClaim < ApplicationRecord
  has_many_attached :receipts
  belongs_to :employee
end
