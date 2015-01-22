class HospitalsController < ApplicationController
  def index
    @hospitals = Hospital.all
  end
  def show
    @patients = @hospital.patients
  end
  def new
    @hospital = Hospital.new
  end
  def edit
    set_hospital
  end
  def create
    @hospital = Hospital.new(hospital_params)
    if @hospital.save
      flash[:notice] = "Hospital was created"
      redirect_to hospitals_path(@hospital)
    else
      flash[:error] = "Hospital was not created"
      render :new
    end
  end
  def update
    set_hospital
    @hospital.update_attributes hospital_params
    redirect_to hospitals_path
  end
  def destroy
    @hospital.destroy
  end
private
  def set_hospital
    @hospital = Hospital.find(params[:id])
  end
  def hospital_params
    params.require(:hospital).permit(:name, :location)
  end
end