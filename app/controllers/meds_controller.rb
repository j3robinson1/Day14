class MedsController < ApplicationController
  def index
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
    @med = @patient.meds.new
  end
  def create
    @hospital = Hospital.find params[:hospital_id]
    @patient = Patient.find params[:patient_id]
    @med = @patient.meds.create med_params
    redirect_to hospital_patient_path(@hospital, @patient)
  end
  def edit
    @hospital = Hospital.find params[:hospital_id]
    @patient = Patient.find params[:patient_id]
    @med = Med.find params[:id]
  end
  def update
    @med = Med.find params[:id]
    @med.update_attributes med_params
    redirect_to hospital_patient_med_path
  end
  def destroy
    set_med
    @med.destroy
    redirect_to hospital_patient_path
  end
private
  def set_med
    @med = Med.find(params[:id])
  end
  def med_params
        params.require(:med).permit(:name, :direction)

  end
end
