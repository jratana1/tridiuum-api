class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.get_all
    query = "
    SELECT
      *
    FROM
      #{self.name + "s"}
    ORDER BY created_at DESC"

    ActiveRecord::Base.connection.execute(query)
  end

  def self.destroy(id)
    query = "
    DELETE 
    FROM 
      #{self.name + "s"}
    WHERE
      Id = #{id}"

    ActiveRecord::Base.connection.execute(query)
  end

  def self.edit(record)

    columns = ""

    record.each do |name, value|
      if name != "id"
      columns = columns + "#{name} = '#{value}',"
      end
    end

    columns = columns.chomp(",")
    byebug
    query = "
    UPDATE #{self.name + "s"}
    SET #{columns}
    WHERE Id = #{record[:id]}"

    ActiveRecord::Base.connection.execute(query)
  end
end
