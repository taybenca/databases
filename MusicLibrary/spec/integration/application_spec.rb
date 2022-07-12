require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "GET /albums" do
    it 'returns 200 OK and all the albums' do
      response = get('/albums')
      expected_response = "Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring"

      expect(response.status).to eq(200)
      expect(response.body).to eq (expected_response)
    end
  end

  context "POST /albums" do
    it 'returns 200 OK and create a new album' do
      response = post(
        '/albums', 
        title: 'Voyage', 
        release_year: '2022', 
        artist_id: '2'
        )
      expect(response.status).to eq(200)
      expect(response.body).to eq('')

      response = get('/albums')
      expect(response.body).to include('Voyage')
    end
  end

  context "GET /artists" do
    it 'returns 200 OK and the correct content' do
      response = get('/artists')
      expect(response.status).to eq(200)
      expect(response.body).to eq "Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos"
    end
  end

  context "POST /artists and GET /artists" do
    it 'returns 200 OK, creates an artist and return the total of artists' do 
      response = post('/artists', name: 'Wilde nothing', genre: 'Indie')
      expect(response.status).to eq(200)
      expect(response.body). to eq('')

      response = get('/artists')
      expect(response.body).to include("Wilde nothing")
      expect(response.body).to eq "Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos, Wilde nothing"
    end
  end
end