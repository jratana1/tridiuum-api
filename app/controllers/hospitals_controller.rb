class HospitalsController < ApplicationController
    def index
        hospitals = Hospital.get_all

        render json: hospitals
    end
end