class AddPatientIdToMeds < ActiveRecord::Migration
  def change
    add_column :meds, :patient_id, :integer
  end
end
