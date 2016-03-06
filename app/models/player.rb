class Player < ActiveRecord::Base
  # Associations

  # Validations
  validates :name, presence: true, length: { in: 3..100 }
end
