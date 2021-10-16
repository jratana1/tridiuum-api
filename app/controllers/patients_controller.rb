class PatientsController < ApplicationController
    def index
        patients = Patient.get_all

        render json: patients
    end
end
