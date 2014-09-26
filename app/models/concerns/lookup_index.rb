require 'active_support/concern'

module LookupIndex
  extend ActiveSupport::Concern

  included do
    raise "Must have key :id" unless method_defined?(:id)
    raise "Must have column :people_ids" unless method_defined?(:people_ids)
  end
  
  module ClassMethods
    def update_index(id:, person_id:)
      index = new(id: id)
      index.people_ids << person_id
      index.send(:update)
      find_by_id(id)
    end

    def find_people_ids(query)
      this_id = find_by_id(query)
      this_id.people_ids if this_id
    end

  end
  
end
