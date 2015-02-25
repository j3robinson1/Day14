class MedsController < ApplicationController
  def index
    @hospital = Hospital.find params[:hospital_id]
    @patient = Patient.find params[:patient_id]
    if !params[:search].blank?
      @meds = Med.where("name LIKE ?", "%#{params[:search]}%")
    else  
    @meds = Med.all
    end
  end
  def show
    @hospital = Hospital.find params[:hospital_id]
    @patient = Patient.find params[:patient_id]
    set_med
    @meds = @patient.meds
  end
  def new
    @hospital = Hospital.find params[:hospital_id]
    @patient = Patient.find params[:patient_id]
    @med = @patient.meds.new
  end
  def create
    @hospital = Hospital.find params[:hospital_id]
    @patient = Patient.find params[:patient_id]
    @med = @patient.meds.create med_params
    redirect_to hospital_patient_meds_path(@hospital, @patient, @med)
  end
  def edit
    @hospital = Hospital.find params[:hospital_id]
    @patient = Patient.find params[:patient_id]
    set_med
  end
  def update
    @hospital = Hospital.find params[:hospital_id]
    @patient = Patient.find params[:patient_id]
    set_med    
    @med.update_attributes med_params
    redirect_to hospital_patient_meds_path(@hospital, @patient, @med)
  end
  def destroy
    @hospital = Hospital.find params[:hospital_id]
    @patient = Patient.find params[:patient_id]
    set_med
    @med.destroy
    redirect_to hospital_patient_meds_path(@hospital, @patient, @med)
  end
private
  def set_med
    @med = Med.find params[:id]
  end
  def med_params
    params.require(:med).permit(:name, :direction)
  end
end
