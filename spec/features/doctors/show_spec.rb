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

      within "div#patient_#{@tom.id}" do
        expect(page).to have_content("Name: Tom")
        expect(page).to_not have_content("Name: Jeanie")  
      end

      within "div#patient_#{@emmie.id}" do
        expect(page).to have_content("Name: Emmie")
        expect(page).to_not have_content("Name: Jeanie")  
      end
      
      within "div#patient_#{@frank.id}" do
        expect(page).to have_content("Name: Frank")
        expect(page).to_not have_content("Name: Jeanie")  
      end

      within "div#hospital" do
        expect(page).to have_content("Name: Salida Hospital")
        expect(page).to_not have_content("Name: BV Hospital")
      end
    end
  end

  describe 'Remove a Patient from a Doctor' do
    describe 'When I visit a Doctor\'s show page' do
      it 'Next to each patient\'s name, I see a button to remove that patient from that doctor\'s caseload' do
      
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

        within "div#patient_#{@tom.id}" do
          expect(page).to have_link("Delete Patient") 
        end
      end

      it 'When I click that button for one patient I\'m brought back to the Doctor\'s show page And I no longer see that patient\'s name listed' do
        
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

        within "div#patient_#{@tom.id}" do
          expect(page).to have_link("Delete Patient")
          click_on("Delete Patient")
        end

        expect(current_path).to eq(doctor_path(@cole))

        expect(page).to_not have_content("Tom")
        expect(page).to have_content("Name: Emmie")
        expect(page).to have_content("Name: Frank")
      end
    end
  end
end