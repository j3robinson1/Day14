class MedsController < ApplicationController
  def index
    @hospital = Hospital.find params[:hospital_id]
    @patient = Patient.find params[:patient_id]
    @meds = Med.all
  end
  def show
    @hospital = Hospital.find params[:hospital_id]
    @patient = Patient.find params[:patient_id]
    set_med
  end
  def new
    @hospital = Hospital.find params[:hospital_id]
    @patient = Patient.find params[:patient_id]
    set_med 
  end
  def create
    @hospital = Hospital.find params[:hospital_id]
    @patient = Patient.find params[:patient_id]
    @med = @patient.meds.create med_params
    redirect_to hospital_patient_path(@hospital, @patient)
  end
  def edit
    @hopsital = Hospital.find params[:hospital_id]
    @patient = Patient.find params[:patient_id]
    set_med
  def update
    @hospital = Hospital.find params[:hospital_id]
    @patient = Patient.find params[:id]
    set_med    
    @med.update_attributes med_params
    redirect_to hospital_patient_med_path
  end
  def destroy
    @hopsital = Hospital.find params[:hospital_id]
    @patient = Patient.find params[:patient_id]
    set_med
    @patient.med.delete
    redirect_to hospital_patient_meds_path
  end
private
  def set_med
    @med = Med.find params[:id]
  end
  def med_params
        params.require(:med).permit(:name, :direction)

  end
end
