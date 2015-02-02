class AddHospitalIdToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :hospital_id, :integer
    add_column :patients, :workflow_state, :string
  end
end
