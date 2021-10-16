class Patient < ApplicationRecord
    def self.get_patients
        ActiveRecord::Base.connection.execute("
        SELECT
          *
        FROM
          Patients
        ORDER BY created_at DESC")
    end
end
