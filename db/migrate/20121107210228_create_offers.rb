class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string  :link
      t.float   :longitude
      t.float   :latitude
      t.integer :price

      t.timestamps
    end
  end
end
