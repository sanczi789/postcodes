class Office < ApplicationRecord
  validates :name, :postcode, presence: true
end
