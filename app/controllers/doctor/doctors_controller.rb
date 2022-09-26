class Doctor::DoctorsController < ApplicationController
  def show
    @doctor = Doctor.find(params[:id])
    @patients = @doctor.patients
    @hospital = @doctor.hospital
  end
end