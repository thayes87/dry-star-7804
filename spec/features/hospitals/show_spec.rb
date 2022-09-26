require 'rails_helper'

RSpec.describe 'hospitals show page' do
  describe 'as a visitor, when I visit a doctors show page' do
    it 'I see the hospital\'s name And I see the names of all doctors that work at this hospital' do
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

      visit hospital_path(@salida)

      expect(page).to have_content("Name: Salida Hospital")
      
      within "div#doctors" do
        expect(page).to have_content("Name: Dr. Cole")
        expect(page).to have_content("Name: Dr. Tiesa")
      end
    end

    it 'And next to each doctor I see the number of patients associated with the doctor' do
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

      visit hospital_path(@salida)

      within "div#doctors" do
        expect(page).to have_content("Name: Dr. Cole - Number of Patients: 3")
        expect(page).to have_content("Name: Dr. Tiesa - Number of Patients: 1")
      end
    end
    
    it 'AAnd I see the list of doctors is ordered from most number of patients to least number of patients' do
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

      visit hospital_path(@salida)

      within "div#doctors" do
        expect(page).to have_content("Name: Dr. Tiesa - Number of Patients: 1")
        expect(page).to have_content("Name: Dr. Cole - Number of Patients: 3")
        expect(@tiesa.name).to appear_before(@cole.name)
      end
    end
  end
end 