class EmailIdx
  include Cequel::Record

  key :id, :text # the email
  set :people_ids, :uuid

  # Class Methods

  def self.update_index(id:, person_id:)
    index = new(id: id)
    index.people_ids << person_id
    index.send(:update)
    find_by_id(id)
  end

end
