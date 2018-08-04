class User < ApplicationRecord
  rolify
  has_secure_password
  before_save { self.email = email.downcase }

  validates :name, presence: true , length:{maximum: 50}, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, length:{ minimum: 6}

  has_many :tasks
  after_initialize :set_default_role, if: :new_record?
  validates :roles, presence: true
  def set_default_role
    self.add_role(:normal)
  end
end
