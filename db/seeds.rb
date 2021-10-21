# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#

  
require 'faker'
require "securerandom"

Hospital.create(name: 'Tridiuum Health')
Hospital.create(name: 'Ratana Quacks')
Hospital.create(name: 'Final Resting Place')
Hospital.create(name: 'Deep Sleep')

# generate 100 Patients
(1..100).each do |id|
    Patient.create!(
# each user is assigned an id from 1-100
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        mrn: Faker::IDNumber.valid
    )
end

(1..40).each do |id|
    Provider.create!(
# each user is assigned an id from 1-40
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name
    )
end
