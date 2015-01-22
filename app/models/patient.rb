class Patient < ActiveRecord::Base
  validate :check_dob
  belongs_to :hospital
  def check_dob
    gap = 10.years.ago
    if self.dob > gap
      errors.add(:dob, "need's to be older 10 yrs old")
    end
  end
end
