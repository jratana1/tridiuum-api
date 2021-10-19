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
    string = self.name.split /(?=[A-Z])/
    table =string.join("_")

    query = "
    DELETE 
    FROM 
      #{table + "s"}
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

    query = "
    UPDATE #{self.name + "s"}
    SET #{columns}
    WHERE Id = #{record["id"]}"

    ActiveRecord::Base.connection.execute(query)
  end

  def self.create(record)

    keys = ""
    values = ""

    record.each do |name, value|
      keys = keys + "#{name},"
      values = values + "'#{value}',"
    end

    keys = keys + "created_at,updated_at"
    values = values + "'#{Time.current.utc}','#{Time.current.utc}'"


    query = "
    INSERT
    INTO #{self.name + "s"}
    (#{keys})
    VALUES
    (#{values});"

    ActiveRecord::Base.connection.execute(query)
  end

  def self.associate(table1, table2, id1, id2)

    query= "INSERT INTO
    #{table1}_#{table2}s (
      #{table1}_id,
      #{table2}_id,
      created_at,
      updated_at 
    )
    SELECT
    '#{id1}',
    '#{id2}',
    '#{Time.current.utc}',
    '#{Time.current.utc}'
    WHERE
    NOT EXISTS (SELECT * FROM #{table1}_#{table2}s WHERE #{table2}_id = '#{id2}' AND #{table1}_id = '#{id1}')"

    ActiveRecord::Base.connection.execute(query)
  end

  def self.get_last
    query = "
    SELECT * 
    FROM #{self.name + "s"} 
    ORDER BY ID DESC LIMIT 1"
    
    ActiveRecord::Base.connection.execute(query)
  end

  def self.get_all_associations(association, id)
    table = ""
    if self.name.downcase < association
      table =  self.name + "_" + association + "s"
    else
      table =  association + "_" + self.name + "s"
    end

    query= "
    SELECT
    *
    FROM
      #{table}
    WHERE #{self.name}_id = #{id}
    ORDER BY created_at DESC"

    ActiveRecord::Base.connection.execute(query)
  end


end
