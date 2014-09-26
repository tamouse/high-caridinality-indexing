class PhoneIdx
  include Cequel::Record

  key :id, :text
  set :people_ids, :uuid

  include LookupIndex

end
