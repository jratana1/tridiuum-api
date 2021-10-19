class Patient < ApplicationRecord
    def self.get_with_providers
        patients_hash= {patients: []}

        query = "
        SELECT Patients.created_at, Patients.id, Patients.first_name, Patients.last_name, Patients.mrn, Providers.id AS Provider_id, Providers.last_name AS Provider_last_name, Providers.first_name AS Provider_first_name
        FROM Patients
        LEFT JOIN Patient_providers
        ON Patients.Id=Patient_providers.patient_id
        LEFT JOIN Providers
        ON Patient_providers.provider_id=Providers.Id
        ORDER BY created_at DESC"

        result = ActiveRecord::Base.connection.execute(query)

        result.each do |row|
            if patients_hash[:patients].any? {|h| h[:id] == row["id"]}
                provider = {
                        id: row["provider_id"],
                        last_name: row["provider_last_name"],
                        first_name: row["provider_first_name"]
                        }

                match_index = patients_hash[:patients].index(patients_hash[:patients].find { |h| h[:id] == row["id"] })  
                
                patients_hash[:patients][match_index][:providers].push(provider)
            else
                patient = {id: row["id"],
                            last_name: row["last_name"],
                            first_name: row["first_name"],
                            mrn: row["mrn"],
                            providers: [{
                                        id: row["provider_id"],
                                        last_name: row["provider_last_name"],
                                        first_name: row["provider_first_name"]
                                        }
                                        ]
                            }
                patients_hash[:patients].push(patient)
            end
        end
        patients_hash
    end
end
