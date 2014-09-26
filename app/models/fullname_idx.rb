class FullnameIdx
  include Cequel::Record

  key :family_name, :text
  key :given_name, :text
  set :people_ids, :uuid

  def self.update_index(family_name:, given_name:, person_id:)
    index = new(family_name: family_name, given_name: given_name)
    index.people_ids << person_id
    index.send(:update)
    find_by_family_name_and_given_name(family_name, given_name)
  end

  def self.find_people_ids(family_name:, given_name:)
    this_id = find_by_family_name_and_given_name(family_name, given_name)
    this_id.people_ids if this_id
  end

end
