class PatientsController < ApplicationController
    def index
        patients = Patient.get_patients

        render json: patients
    end
end
