class Office < ApplicationRecord
  validates :name, :postcode, presence: true
  validates :postcode, format: { without: /\s/ }
  # --- Google Maps api ---
  geocoded_by :postcode
  after_validation :geocode, if: :postcode_changed?
end
