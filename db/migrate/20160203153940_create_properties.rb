class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.integer :situation, default: 0, index: true
      t.integer :type_property, default: 0, index: true
      t.integer :commercial_situation, default: 0, index: true
      
      t.boolean :status, default: true
      
      t.string :iptu
      t.date   :expiration_date

      t.string  :cep
      t.string  :uf

      t.string :city
      t.string :region
      t.string :address
      t.string :group
      t.string :number
      t.string :block
      t.string :complement
      t.string :reference_point

      t.string :name
      t.integer :rooms, default: 0
      t.string :unit
      t.float  :value, default: 0.00
      t.integer :suit, default: 0
      t.float :value_m2, default: 0.00
      t.float :area, default: 0.00
      t.integer :parking_spaces, default: 0
      t.integer :floor, default: 0
      t.string :sun_position
      t.float :value_rent, default: 0.00
  
      t.references :property_attributes, array: true, default: []
      
      t.text  :description
      
      t.boolean :elevator,    default: false
      t.boolean :coverage,    default: false

      t.references :block, index: true
      t.timestamps null: false
    end
  end
end
