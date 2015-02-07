class PatientsController < ApplicationController
  before_action :set_hospital, only: [:waiting_room, :doctor_checkup, :xray_appointment, :surgery_appointment, :pay_bills, :leaving]
  before_action :set_patient, only: [:show, :edit, :update, :destroy, :waiting_room, :doctor_checkup, :xray_appointment, :surgery_appointment, :pay_bills, :leaving]
  def index
    @hospital = Hospital.find params[:hospital_id]
    if !params[:search].blank?
      @patients = Patient.where("firstname LIKE ?", "%#{params[:search]}%")
    else  
    @patients = Patient.all
    end
  end
  def show
    @hospital = Hospital.find params[:hospital_id]
    set_patient
    @meds = @patient.meds
    @doctor = Doctor.new
  end
  def create_doctor
    @hospital = Hospital.find(params[:hospital_id])
    @doctor = @patient.doctors.create doctor_params
    redirect_to hospital_patient_path
  end
  def delete_doctor
    @doctor = Doctor.find(params[:id])
    @doctor.destroy
    redirect_to hospital_patient_path
  end
  def waiting_room
    @patient.wait!
    redirect_to hospital_patients_path
  end
  def doctor_checkup
    @patient.checkup!
    redirect_to hospital_patients_path
  end
  def xray_appointment
    @patient.xray!
    redirect_to hospital_patients_path
  end
  def surgery_appointment
    @patient.surgery!
    redirect_to hospital_patients_path
  end
  def pay_bills
    @patient.pay!
    redirect_to hospital_patients_path
  end
  def leaving
    @patient.leave!
    redirect_to hospital_patients_path
  end
  def new
    @hospital = Hospital.find(params[:hospital_id])
    @patient = @hospital.patients.new
  end
  def create
    @hospital = Hospital.find params[:hospital_id]
    @patient = @hospital.patients.create patient_params
    redirect_to hospital_path(@hospital)
  end
  def edit
    @hospital = Hospital.find params[:hospital_id]
  end
  def update
    @hospital = Hospital.find params[:hospital_id]
    @patient.update_attributes patient_params
    redirect_to hospital_patients_path
  end
  def destroy
    @hospital = Hospital.find params[:hospital_id]
    @patient.destroy
    redirect_to hospital_patients_path
  end

private
  def set_hospital
    @hospital = Hospital.find(params[:hospital_id])
  end
  def set_patient
    @patient = Patient.find(params[:id])
  end
  def doctor_params
    params.require(:doctor).permit(:name)
  end
  def patient_params
    params.require(:patient).permit(:firstname, :lastname, :dob, :symptoms, :gender, :bloodtype, :workflow_state)
  end
end
