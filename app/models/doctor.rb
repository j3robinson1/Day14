class Doctor < ActiveRecord::Base
  belongs_to :Doctorable, polymorphic: true
end
