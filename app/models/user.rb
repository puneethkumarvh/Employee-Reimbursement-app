class User < ApplicationRecord
  # Validations

  # Ensure google_id is present and unique
  validates :google_id, presence: true, uniqueness: true

  # Ensure name is present and unique.
  validates :name, presence: true, uniqueness: true

  # Ensure email is present, unique, and in proper format.
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Must be a valid email address." }
end
