# frozen_string_literal: true

require 'dotenv/load'
require './api_client'
require './excel'

client = API::Client.new(ENV['SUB_DOMAIN'], ENV['API_KEY'])

data = {
  custom_fields: client.get('custom_fields.json'),
  locations: client.get('locations.json'),
  departments: client.get('departments.json'),
  divisions: client.get('divisions.json'),
  structure_group_ones: client.get('structure_custom_group_ones.json')
}

excel = Excel::Client.new('structure.xlsx')

excel.write(data)
