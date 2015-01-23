class PatientsController < ApplicationController
  def index
    @patients = Patient.all
  end
  def show
    @patient = Patient.find params[:id]
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
    @patient = Patient.find params[:id]
    @patient.delete
    redirect_to patients_path
  end

private
  def patient_params
    params.require(:patient).permit(:firstname, :lastname, :dob, :symptoms, :gender, :bloodtype)
  end
end
