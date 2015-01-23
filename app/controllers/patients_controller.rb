class PatientsController < ApplicationController
  def index
    @patients = Patient.all
  end
  def show
    @hospital = Hospital.find(params[:hospital_id])
    set_patient
    @meds = @patient.meds
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
    @patient = Patient.find params[:id]
  end
  def update
    @patient = Patient.find params[:id]
    @patient.update_attributes patient_params
    redirect_to patients_path
  end
  def destroy
    set_patient
    @patient.destroy
    redirect_to patients_path
  end

private
  def set_patient
    @patient = Patient.find(params[:id])
  end
  def patient_params
    params.require(:patient).permit(:firstname, :lastname, :dob, :symptoms, :gender, :bloodtype)
  end
end
