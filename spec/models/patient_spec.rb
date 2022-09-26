require 'rails_helper'

RSpec.describe Patient do
  describe 'relationships' do
    it {should have_many :doctor_patients}
    it {should have_many(:doctors).through (:doctor_patients)}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :age}
  end

  describe "class methods" do
    describe '#self.sorted_adults' do
      it 'retirns all patients who are over 18 years old in alphabetical order' do
      
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

        expect(Patient.sorted_adults).to eq([@emmie, @frank, @tom])
      end
    end
  end
end