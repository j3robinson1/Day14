class Patient < ActiveRecord::Base
  validate :check_dob
  belongs_to :hospital
  has_many :meds, dependent: :destroy
  has_many :doctors, as: :doctorable
  def check_dob
    gap = 10.years.ago
    if self.dob > gap
      errors.add(:dob, "need's to be older 10 yrs old")
    end
  end
  include Workflow
  workflow do
    state :waiting_room do
      event :wait, transitions_to: :waiting_room
      event :checkup, transitions_to: :doctor_checkup
      event :xray, transitions_to: :xray_appointment
      event :surgery, transitions_to: :surgery_appointment
      # all but pay/leave
    end
    state :doctor_checkup do
      event :wait, transitions_to: :waiting_room
      event :checkup, transitions_to: :doctor_checkup
      event :xray, transitions_to: :xray_appointment
      event :surgery, transitions_to: :surgery_appointment
      event :pay, transitions_to: :pay_bills
      event :leave, transitions_to: :leaving
      # all
    end
    state :xray_appointment do
      event :wait, transitions_to: :waiting_room
      event :checkup, transitions_to: :doctor_checkup
      event :xray, transitions_to: :xray_appointment
      event :surgery, transitions_to: :surgery_appointment
      event :pay, transitions_to: :pay_bills
      event :leave, transitions_to: :leaving
      # all but doctor_checkup
    end
    state :surgery_appointment do
      event :checkup, transitions_to: :doctor_checkup
      event :xray, transitions_to: :xray_appointment
      event :surgery, transitions_to: :surgery_appointment
      event :pay, transitions_to: :pay_bills
      event :leave, transitions_to: :leaving
      # all but waiting_room
    end
    state :pay_bills do
      event :leave, transitions_to: :leaving
      # leave
    end
    state :leaving do
      # nothing
    end
  end
end
