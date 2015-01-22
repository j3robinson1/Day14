class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :firstname
      t.string :lastname
      t.date :dob 
      t.text :symptoms
      t.text :gender
      t.text :bloodtype
      t.timestamps null: false
    end
  end
end
