class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  validates :name, presence: true, uniqueness: true
  validates :detail, presence: true
  validates :due, presence: true

end
