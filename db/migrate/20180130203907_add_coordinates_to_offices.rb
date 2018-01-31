class AddCoordinatesToOffices < ActiveRecord::Migration[5.1]
  def change
    add_column :offices, :latitude, :float
    add_column :offices, :longitude, :float
  end
end
