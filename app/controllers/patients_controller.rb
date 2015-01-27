class PatientsController < ApplicationController
  def index
    @hospital = Hospital.find params[:hospital_id]
    @patients = Patient.all
  end
  def show
    @hospital = Hospital.find(params[:hospital_id])
    set_patient
    @meds = @patient.meds
    @doctor = Doctor.new
  end
  def create_doctor
    @hospital = Hospital.find(params[:hospital_id])
    set_patient
    @doctor = @patient.doctors.create doctor_params
    redirect_to hospital_patient_path
  end
  def delete_doctor
    @doctor = Doctor.find(params[:id])
    @doctor.destroy
    redirect_to hospital_patient_path
  end
  def new
    @hospital = Hospital.find params[:hospital_id]
    @patient = @hospital.patients.new
  end
  def create
    @hospital = Hospital.find params[:hospital_id]
    @patient = @hospital.patients.create patient_params
    redirect_to hospital_path(@hospital)
  end
  def edit
    @hospital = Hospital.find params[:hospital_id]
    set_patient
  end
  def update
    @hospital = Hospital.find params[:hospital_id]
    set_patient
    @patient.update_attributes patient_params
    redirect_to hospital_patients_path
  end
  def destroy
    @hospital = Hospital.find params[:hospital_id]
    set_patient
    @patient.destroy
    redirect_to hospital_patients_path
  end

private
  def set_patient
    @patient = Patient.find(params[:id])
  end
  def doctor_params
    params.require(:doctor).permit(:name)
  end
  def patient_params
    params.require(:patient).permit(:firstname, :lastname, :dob, :symptoms, :gender, :bloodtype)
  end
end
