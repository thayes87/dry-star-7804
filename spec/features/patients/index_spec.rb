require 'rails_helper'

RSpec.describe 'patients index page' do
  describe 'as a visitor, when I visit a patients index page' do
    it 'I see the names of all adult patients in ascending alphabetical order' do
      @salida = Hospital.create!(name: "Salida Hospital")

      @cole = @salida.doctors.create!(name: "Dr. Cole", specialty: "urology", university: "St. Louis")

      @tom = Patient.create!(name: "Tom", age: 33)
      @emmie = Patient.create!(name: "Emmie", age: 32)
      @frank = Patient.create!(name: "Frank", age: 52)
      @jeanie = Patient.create!(name: "Jeanie", age: 17)
      @maura = Patient.create!(name: "Maura", age: 4)

      DoctorPatient.create!(doctor_id: @cole.id, patient_id: @tom.id)
      DoctorPatient.create!(doctor_id: @cole.id, patient_id: @emmie.id)
      DoctorPatient.create!(doctor_id: @cole.id, patient_id: @frank.id)
      DoctorPatient.create!(doctor_id: @cole.id, patient_id: @jeanie.id)
      DoctorPatient.create!(doctor_id: @cole.id, patient_id: @maura.id)

      visit patients_path

      within "div#adult_patients" do
        expect(page).to have_content("Name: Tom")
        expect(page).to have_content("Name: Emmie")
        expect(page).to have_content("Name: Frank")
        expect(page).to_not have_content("Name: Jeanie")
        expect(page).to_not have_content("Name: Maura")
        expect(@emmie.name).to appear_before(@frank.name)
        expect(@frank.name).to appear_before(@tom.name)
      end
    end
  end
end