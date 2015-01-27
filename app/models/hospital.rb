class Hospital < ActiveRecord::Base
  has_many :patients, dependent: :destroy
  has_many :doctors, as: :doctorable
end
