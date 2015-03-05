class PatientsController < ApplicationController
  before_action :set_hospital, only: [:waiting_room, :doctor_checkup, :xray_appointment, :surgery_appointment, :pay_bills, :leaving]
  before_action :set_patient, only: [:waiting_room, :doctor_checkup, :xray_appointment, :surgery_appointment, :pay_bills, :leaving]
  def index
    set_hospital
    if !params[:search].blank?
      @patients = Patient.where("firstname LIKE ?", "%#{params[:search]}%")
    else  
    @patients = Patient.all
    end
  end
  def show
    set_hospital
    set_patient
    @meds = @patient.meds
    @doctor = Doctor.new
  end
  def create_doctor
    set_hospital
    set_patient
    @doctor = @patient.doctors.create doctor_params
    redirect_to hospital_patient_path(@hospital, @patient)
  end
  def delete_doctor
    @doctor = Doctor.find(params[:id])
    @doctor.destroy
    redirect_to hospital_path(@hospital, @patient)
  end
  def waiting_room
    @patient.wait!
    redirect_to hospital_patients_path(@hospital)
  end
  def doctor_checkup
    @patient.checkup!
    redirect_to hospital_patients_path(@hospital)
  end
  def xray_appointment
    @patient.xray!
    redirect_to hospital_patients_path(@hospital)
  end
  def surgery_appointment
    @patient.surgery!
    redirect_to hospital_patients_path(@hospital)
  end
  def pay_bills
    @patient.pay!
    redirect_to hospital_patients_path(@hospital)
  end
  def leaving
    @patient.leave!
    redirect_to hospital_patients_path(@hospital)
  end
  def new
    set_hospital
    @patient = Patient.new
  end
  def create
    set_hospital
    @patient = @hospital.patients.create patient_params
    redirect_to hospital_path(@hospital)
  end
  def edit
    set_hospital
    set_patient
  end
  def update
    set_hospital
    set_patient
    @patient.update_attributes patient_params
    redirect_to hospital_path(@hospital)
  end
  def destroy
    set_patient
    @patient.destroy
    redirect_to hospital_patients_path(@hospital)
  end

private
  def set_hospital
    @hospital = Hospital.find(params[:hospital_id])
  end
  def set_patient
    @patient = Patient.find params[:id]
  end
  def doctor_params
    params.require(:doctor).permit(:name)
  end
  def patient_params
    params.require(:patient).permit(:firstname, :lastname, :dob, :symptoms, :gender, :bloodtype, :workflow_state, :hospital_id)
  end
end
