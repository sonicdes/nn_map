require 'roda'
require 'airrecord'
require 'rufus-scheduler'
require 'json'
require 'dotenv'
Dotenv.load

use Rack::Static, :urls => ['/data']

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
     d[prob.id] = {
       title: prob["Заголовок"],
       description: prob["Описание"],
       latlng: [prob["Широта"],prob["Долгота"]]
     }
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
      Problem.create(
        'Заголовок' => r.params['title'],
        'Описание' => r.params['description'],
        'Широта' => r.params['lat'].to_f,
        'Долгота' => r.params['lng'].to_f
      )
      r.redirect "#{ENV['HOSTNAME']}/thanks_man"
    end

  end
end

run App.freeze.app
