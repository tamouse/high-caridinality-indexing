class Person
  include Cequel::Record

  key :id, :uuid, auto: true

  column :family_name, :text
  column :given_name,  :text
  column :email,       :text
  column :phone,       :text

  # Class Methods
  ## Aggregate search methods
  def self.find_all_by_family_name(q)
    
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
  
end
