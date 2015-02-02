class HospitalsController < ApplicationController
  def index
    @hospitals = Hospital.all
  end
  def show
    set_hospital
    @patients = @hospital.patients
    @doctor = Doctor.new
  end
  def create_doctor
    set_hospital
    @doctor = @hospital.doctors.create doctor_params
    redirect_to hospital_path(@hospital)
  end
  def delete_doctor
    @doctor = Doctor.find params[:id]
    @doctor.destroy
    redirect_to hospital_path
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
    set_hospital
    @hospital.destroy
    redirect_to hospitals_path
  end
private
  def set_hospital
    @hospital = Hospital.find(params[:id])
  end
  def doctor_params
    params.require(:doctor).permit(:name)
  end
  def hospital_params
    params.require(:hospital).permit(:name, :location)
  end
end