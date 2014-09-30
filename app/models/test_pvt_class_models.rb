module TestPvtClassModels
  
  class CanonicalModel
    include Cequel::Record
    key :id, :uuid, auto: true
    column :name, :text
    column :phone, :text
    column :email, :text
  end

  class NameIndex
    include Cequel::Record
    key :id, :text
    set :models, :uuid
  end

end
