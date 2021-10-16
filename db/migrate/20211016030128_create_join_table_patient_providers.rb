class CreateJoinTablePatientProviders < ActiveRecord::Migration[6.0]
  def change
    create_table :patient_providers do |t|
      t.integer :patient_id
      t.integer :provider_id

      t.timestamps
  end
end
