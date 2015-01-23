class MedsController < ApplicationController
  def index
    @meds = Med.all
  end
  def show
    @med = med.find params[:id]
  end
  def new
    @patient = patient.find params[:patient_id]
    @med = @patient.meds.new
  end
  def create
    @patient = patient.find params[:patient_id]
    @med = @patient.meds.create med_params
    redirect_to patient_path(@patient)
  end
  def edit
    @med = med.find params[:id]
  end
  def update
    @med = med.find params[:id]
    @med.update_attributes med_params
    redirect_to meds_path
  end
  def destroy
    @med = med.find params[:id]
    @med.delete
    redirect_to meds_path
  end
private
  def med_params
        params.require(:med).permit(:name, :direction)

  end
end
