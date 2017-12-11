class Workplace < ActiveRecord::Base
  validates:name,presence:true,length:{maximum: 200}

  has_many :constructions,dependent: :destroy,:inverse_of => :workplace #validate時に必要


end
