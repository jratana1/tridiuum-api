class Provider < ApplicationRecord
    def self.get_providers
        ActiveRecord::Base.connection.execute("
        SELECT
          *
        FROM
          Providers
        ORDER BY created_at DESC")
    end
end
