require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }


  def reset_artists_table
    seed_sql = File.read('spec/seeds/artists_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  def reset_albums_table
    seed_sql = File.read('spec/seeds/albums_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_artists_table
    reset_albums_table
  end

  context "GET /albums" do
    it 'returns 200 OK and all the albums' do
      response = get('/albums')

      expect(response.status).to eq(200)
      expect(response.body).to include("<h1>Albums</h1>")
      expect(response.body).to include("Doolittle")
      expect(response.body).to include("1989")
      expect(response.body).to include("Fodder on My Wings")
      expect(response.body).to include("1982")
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
      expect(response.body).to eq "Pixies, ABBA, Taylor Swift, Nina Simone"
    end
  end

  context "POST /artists and GET /artists" do
    it 'returns 200 OK, creates an artist and return the total of artists' do 
      response = post('/artists', name: 'Wilde nothing', genre: 'Indie')
      expect(response.status).to eq(200)
      expect(response.body). to eq('')

      response = get('/artists')
      expect(response.body).to include("Wilde nothing")
      expect(response.body).to eq "Pixies, ABBA, Taylor Swift, Nina Simone, Wilde nothing"
    end
  end

  context "GET /albums/:id" do
    it "returns 200 OK and the correct album content" do
      response = get("/albums/1")

      expect(response.status).to eq(200)
      expect(response.body).to include("<h1>Doolittle</h1>")
      expect(response.body).to include("Release year: 1989")
      expect(response.body).to include("Artist: Pixies")
    end

    it "returns 200 OK and the correct album content" do
      response = get("/albums/2")

      expect(response.status).to eq(200)
      expect(response.body).to include("<h1>Surfer Rosa</h1>")
      expect(response.body).to include("Release year: 1988")
      expect(response.body).to include("Artist: Pixies")
    end
  end 
end