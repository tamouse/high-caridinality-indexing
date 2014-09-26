class Person
  include Cequel::Record
  # include ActiveModel::Serialization

  key :id, :uuid, auto: true

  column :family_name, :text
  column :given_name,  :text
  column :email,       :text
  column :phone,       :text

  # Callbacks

  after_save :update_indexes

  # Validations

  validates_presence_of :family_name, :email

  # Class Methods
  ## Aggregate search methods
  def self.find_all_by_family_name(q)
    where(id: FamilyNameIdx.find_people_ids(q).to_a)
  end

  def self.find_all_by_given_name(q)
    where(id: GivenNameIdx.find_people_ids(q).to_a)
  end

  def self.find_all_by_email(q)
    where(id: EmailIdx.find_people_ids(q).to_a)
  end

  def self.find_all_by_phone(q)
    where(id: PhoneIdx.find_people_ids(q).to_a)
  end

  def self.find_all_by_fullname(family_name:, given_name:)
    where(id: FullnameIdx.find_people_ids(family_name: family_name, given_name: given_name).to_a)
  end

  # Instance Methods
  def full_name
    [given_name, family_name].join(" ")
  end

  def to_s
    [full_name, email, phone].join(", ")
  end

  def as_json
    # NOTE Need to do this to get the actual ID as a string in the JSON
    attributes.merge(id: id.to_s)
  end

  private

  def update_indexes
    FamilyNameIdx.update_index(id: self.family_name, person_id: self.id) if self.family_name
    GivenNameIdx.update_index(id: self.given_name, person_id: self.id) if self.given_name
    EmailIdx.update_index(id: self.email, person_id: self.id) if self.email
    PhoneIdx.update_index(id: self.phone, person_id: self.id) if self.phone
    FullnameIdx.update_index(family_name: self.family_name, given_name: self.given_name, person_id: self.id) if (family_name && given_name)
  end

end
