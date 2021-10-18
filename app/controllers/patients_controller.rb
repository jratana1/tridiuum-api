class PatientsController < ApplicationController
    def index
        patients = Patient.get_all

        render json: patients
    end

    def destroy
        Patient.destroy(params[:id])
        
        patients = Patient.get_all

        render json:patients
    end
end
