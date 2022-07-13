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
      expect(response.body).to include('<h1>Albums</h1>')
      expect(response.body).to include('Title: Doolittle')
      expect(response.body).to include('<a href="/albums/2">')
      expect(response.body).to include('<a href="/albums/3">')
    end
  end

  context "GET /album/new" do
    it 'returns 200 OK and shows the forms' do
      response = get("/album/new")
      expect(response.status).to eq (200)
      expect(response.body).to include('Create the album')
      expect(response.body).to include('<form action="/albums" method="POST">')
      expect(response.body).to include('<h1>Add an album</h1>')
    end
  end

  context "GET /artist/new" do
    it 'returns 200 OK and shows the forms' do
      response = get("/artist/new")
      expect(response.status).to eq (200)
      expect(response.body).to include('Create the artist')
      expect(response.body).to include('<form action="/artists" method="POST">')
      expect(response.body).to include('<h1>Add an artist</h1>')
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

      response = post('/albums')
      expect(response.body).to include('<h1>Your album was added!</h1>')
    end
  end

  context "POST /artists" do
    it 'returns 200 OK and create a new artist' do
      response = post(
        '/artists', 
        name: 'Gogi', 
        genre: 'Pop'
        )
      expect(response.status).to eq(200)

      response = post('/artists')
      expect(response.body).to include('<h1>Your artist was added!</h1>')
    end
  end

  context "GET /artists" do
    it 'returns 200 OK and the correct content' do
      response = get('/artists')
      expect(response.status).to eq(200)
      expect(response.body).to include("Name: Pixies")
      expect(response.body).to include("Name: ABBA")
      expect(response.body).to include("Name: Taylor Swift")
      expect(response.body).to include("Name: Nina Simone")
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
  
  context "GET /artists/:id" do
    it "returns 200 OK and the correct artist information" do
      response = get('/artists/1')
      expect(response.status).to eq(200)
      expect(response.body).to include("<h1>Pixies</h1>")
      expect(response.body).to include("Genre: Rock")
    end
  end
end