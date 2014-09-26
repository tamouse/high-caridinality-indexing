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
    people = GivenNameIdx.select(:people_ids).where(id: q).first
    return [] unless people
    where(id: people.people_ids.to_a)
  end

  def self.find_all_by_email(q)
    people = EmailIdx.select(:people_ids).where(id: q).first
    return [] unless people
    where(id: people.people_ids.to_a)
  end

  def self.find_all_by_phone(q)
    people = PhoneIdx.select(:people_ids).where(id: q).first
    return [] unless people
    where(id: people.people_ids.to_a)
  end

  # Instance Methods
  def full_name
    [given_name, family_name].join(" ")
  end

  def to_s
    [full_name, email, phone].join(", ")
  end

  private

  def update_indexes
    FamilyNameIdx.update_index(id: self.family_name, person_id: self.id) if self.family_name
    GivenNameIdx.update_index(id: self.given_name, person_id: self.id) if self.given_name
    EmailIdx.update_index(id: self.email, person_id: self.id) if self.email
    PhoneIdx.update_index(id: self.phone, person_id: self.id) if self.phone
  end

end
