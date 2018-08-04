class Task < ApplicationRecord

  belongs_to :user

  validates :name, presence: true, uniqueness: true
  validates :detail, presence: true
  validates :due, presence: true

  scope :get_by_name, -> (name) {
    where("name like ?","%#{name}%")
  }
  scope :get_by_status, -> (status) {
    where(status: status)
  }

end
