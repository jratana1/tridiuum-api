class CreateJoinTableHospitalProviders < ActiveRecord::Migration[6.0]
  def change
    create_table :hospital_providers do |t|
      t.integer :hospital_id
      t.integer :provider_id

      t.timestamps
    end
  end
end
