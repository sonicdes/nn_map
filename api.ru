require 'roda'
require 'airrecord'
require 'rufus-scheduler'
require 'json'
require 'dotenv'
Dotenv.load


Airrecord.api_key = ENV['AIRTABLE_API_KEY']

class Problem < Airrecord::Table
  self.base_key = ENV['AIRTABLE_BASE_ID']
  self.table_name = "Проблемы"

  def self.in_progress
    all(filter: '{Status} = "In progress"')
  end

  # has_many :documents, class: "Document", column: "Документы"
end


scheduler = Rufus::Scheduler.new
scheduler.every '30m' do
  data = Problem.in_progress.inject(Hash.new) do |d,prob|
     d[prob.id] = {description: prob["Описание"], latlng: [prob["Широта"],prob["Долгота"]]}
     d
  end
  File.write("data/all_locations.json", data.to_json)
end

class App < Roda
  plugin :all_verbs
  plugin :json
  route do |r|
    response['Access-Control-Allow-Origin'] = '*'
    r.options do
      response['Access-Control-Allow-Headers'] = 'content-type,x-requested-with'
      ""
    end

    r.is "v1" do
      "OK"
    end

    r.post "problem" do
      data = JSON.parse( request.body.read )
      Problem.create(
        'Описание' => data['description'],
        'Широта' => data['latlng'][0].to_f,
        'Долгота' => data['latlng'][1].to_f
      )
      "ОК"
    end

  end
end

run App.freeze.app
