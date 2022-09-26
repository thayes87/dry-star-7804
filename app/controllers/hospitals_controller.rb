class HospitalsController < ApplicationController
  def show 
    @hospital = Hospital.find(params[:id])
    @hospital_doctors = @hospital.doctors
  end
end