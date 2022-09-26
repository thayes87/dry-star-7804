require 'rails_helper'

RSpec.describe 'doctors show page' do
  describe 'as a visitor, when I visit a doctors show page' do
    it 'I see allof that doctors info such including name, specialty, university' do
      @salida = Hospital.create!(name: "Salida Hospital")
      @bv = Hospital.create!(name: "BV Hospital")
      
      @cole = @salida.doctors.create!(name: "Dr. Cole", specialty: "urology", university: "St. Louis")
      @tiesa = @salida.doctors.create!(name: "Dr, Tiesa", specialty: "general", university: "CU Denver")

      @tom = Patient.create!(name: "Tom", age: 33)
      @emmie = Patient.create!(name: "Emmie", age: 32)
      @frank = Patient.create!(name: "Frank", age: 52)
      @jeanie = Patient.create!(name: "Jeanie", age: 19)

      DoctorPatient.create!(doctor_id: @cole.id, patient_id: @tom.id)
      DoctorPatient.create!(doctor_id: @cole.id, patient_id: @emmie.id)
      DoctorPatient.create!(doctor_id: @cole.id, patient_id: @frank.id)
      DoctorPatient.create!(doctor_id: @tiesa.id, patient_id: @jeanie.id)

      visit doctor_path(@cole)

      expect(page).to have_content("Name: Dr. Cole")
      expect(page).to have_content("Specialty: urology")
      expect(page).to have_content("University: St. Louis")

      expect(page).to_not have_content("Name: Dr. Tiesa")
      expect(page).to_not have_content("Specialty: general")
      expect(page).to_not have_content("University: CU Denver")

      within "div#patients" do
        expect(page).to have_content("Name: Tom")
        expect(page).to have_content("Name: Emmie")
        expect(page).to have_content("Name: Frank")
        expect(page).to_not have_content("Name: Jeanie")  
      end

      within "div#hospital" do
        expect(page).to have_content("Name: Salida Hospital")
        expect(page).to_not have_content("Name: BV Hospital")
      end
    end
  end
end