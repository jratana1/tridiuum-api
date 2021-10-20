class Provider < ApplicationRecord
    def self.get_with_hospitals
        providers_hash= {providers: []}

        query = "
        SELECT Providers.created_at,
                Providers.id,
                Providers.first_name,
                Providers.last_name,
                Hospitals.id AS Hospital_id,
                Hospitals.name, 
                (SELECT
                    COUNT(*)
                FROM
                    Patient_providers
                WHERE
                    provider_id=Providers.id
                ) as cnt
        FROM Providers
        LEFT JOIN Patient_providers
        ON Providers.Id=Patient_providers.provider_id
        LEFT JOIN Hospital_providers
        ON Providers.Id=Hospital_providers.provider_id
        LEFT JOIN Hospitals
        ON Hospital_providers.hospital_id=Hospitals.Id
        ORDER BY created_at DESC"

        result = ActiveRecord::Base.connection.execute(query)

        result.each do |row|
            if providers_hash[:providers].any? {|h| h[:id] == row["id"]}
                hospital = {
                        id: row["hospital_id"],
                        name: row["name"]
                        }

                match_index = providers_hash[:providers].index(providers_hash[:providers].find { |h| h[:id] == row["id"] })  
                
                providers_hash[:providers][match_index][:hospitals].push(hospital)
            else
                provider = {id: row["id"],
                            last_name: row["last_name"],
                            first_name: row["first_name"],
                            count: row["cnt"],
                            hospitals: [{
                                        id: row["hospital_id"],
                                        name: row["name"]
                                        }
                                        ]
                            }
                providers_hash[:providers].push(provider)
            end
        end
        providers_hash
    end
end
