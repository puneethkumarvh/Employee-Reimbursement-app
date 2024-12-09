class Company < ApplicationRecord
    has_many :employees, dependent: :destroy
    belongs_to :user

    def adjust_reimbursement_total(amount)
        update(reimbursement_total: reimbursement_total + amount)
    end
    
    def increment_reimbursement_total(amount)
        adjust_reimbursement_total(amount)
    end
    
    def decrement_reimbursement_total(amount)
        adjust_reimbursement_total(-amount)
    end
end
