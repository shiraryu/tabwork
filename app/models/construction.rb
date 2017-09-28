class Construction < ActiveRecord::Base
  validates:name,presence:true

  belongs_to :workplace
end
