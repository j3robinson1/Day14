class AddHospitalIdToMeds < ActiveRecord::Migration
  def change
    add_column :meds, :hospital_id, :integer
  end
end
