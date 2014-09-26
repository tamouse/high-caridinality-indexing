class Person
  include Cequel::Record

  key :id, :uuid, auto: true

  column :family_name, :text
  column :given_name,  :text
  column :email,       :text
  column :phone,       :text

  # Callbacks

  after_save :update_indexes

  # Class Methods
  ## Aggregate search methods
  def self.find_all_by_family_name(q)
    people = FamilyNameIdx.select(:people_ids).where(id: q).first
    return [] unless people
    where(id: people.people_ids.to_a)
  end

  def self.find_all_by_given_name(q)
    
  end

  def self.find_all_by_email(q)
    
  end

  def self.find_all_by_phone(q)
    
  end

  # Instance Methods
  def full_name
    [given_name, family_name].join(" ")
  end

  private

  def update_indexes
    FamilyNameIdx.update_index(id: self.family_name, person_id: self.id)
  end

end
