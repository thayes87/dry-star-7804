class Doctor::PatientsController < ApplicationController
  def destroy
    @doctor = Doctor.find(params[:doctor_id])
    @patient = DoctorPatient.find_by(patient_id: params[:id], doctor_id: @doctor.id)
    @patient.destroy
    redirect_to doctor_path(@doctor)
  end
end