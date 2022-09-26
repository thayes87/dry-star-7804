class PatientsController < ApplicationController
  def index
    @patients = Patient.all
    @sorted_adults = @patients.sorted_adults
  end
end