class Workplace < ActiveRecord::Base
  validates:name,presence:true,length:{maximum: 200}

  has_many :constructions,dependent: :destroy

end
