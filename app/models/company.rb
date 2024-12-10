class Company < ApplicationRecord
    has_many :employees, dependent: :destroy
    belongs_to :user
    validates :name, presence: true, uniqueness: { scope: :user_id, message: 'should be unique per user' }
end
