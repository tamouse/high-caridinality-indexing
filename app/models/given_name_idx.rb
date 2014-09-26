class GivenNameIdx
  include Cequel::Record

  key :id, :text # the given name
  set :people_ids, :uuid

  # Class Methods

  def self.update_index(id:, person_id:)
    # cql = "UPDATE #{FamilyNameIdx.table_name} set people_ids = people_ids + { #{person_id} } where id = '#{id}'"
    # connection.execute(cql)
    index = new(id: id)
    index.people_ids << person_id
    index.send(:update)
    find_by_id(id)
  end

end
