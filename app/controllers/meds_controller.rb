class MedsController < ApplicationController
  def index
    set_hospital
    set_patient
    if !params[:search].blank?
      @meds = Med.where("name LIKE ?", "%#{params[:search]}%")
    else  
    @meds = Med.all
    end
  end
  def show
    set_hospital
    set_patient
    set_med
  end
  def new
    set_hospital
    set_patient
    @med = @patient.meds.new
  end
  def create
    set_hospital
    set_patient
    @med = @patient.meds.create med_params
    redirect_to hospital_patient_path(@hospital, @patient)
  end
  def edit
    set_hospital
    set_patient
    set_med
  end
  def update
    set_hospital
    set_patient
    set_med    
    @med.update_attributes med_params
    redirect_to hospital_patient_path(@hospital, @patient)
  end
  def destroy
    set_med
    @med.destroy
    redirect_to hospital_patient_meds_path(@hospital, @patient, @med)
  end
private
  def set_hospital
    @hospital = Hospital.find(params[:hospital_id])
  end
  def set_patient
    @patient = Patient.find(params[:patient_id])
  end
  def set_med
    @med = Med.find params[:id]
  end
  def med_params
    params.require(:med).permit(:name, :direction)
  end
end
