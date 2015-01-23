class RemoveHospitalIdFromMeds < ActiveRecord::Migration
  def change
    remove_column :meds, :hospital_id, :integer
  end
end
