# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end

  # View all the albums
  get '/albums' do
    repo = AlbumRepository.new
    @albums = repo.all
    return erb(:album)
  end
  
  # Create a new album
  post '/albums' do
    repo = AlbumRepository.new
    new_album = Album.new
    new_album.title = params[:title]
    new_album.release_year = params[:release_year]
    new_album.artist_id = params[:artist_id]
    repo.create(new_album)
    return ''
  end

  # View a specific album
  get "/albums/:id" do
    repo = AlbumRepository.new
    id_to_find = params[:id]
    @album = repo.find(id_to_find)
    repo = ArtistRepository.new
    @artist = repo.find(@album.artist_id)
    return erb(:album_id)
  end

  # View all artists
  get '/artists' do
    repo = ArtistRepository.new
    @artists = repo.all
    return erb(:artist)
  end

  # Create an Artist
  post '/artists' do
    repo = ArtistRepository.new
    new_artist = Artist.new
    new_artist.name = params[:name]
    new_artist.genre = params[:genre]
    repo.create(new_artist)
    return ''
  end

  # View a specific Artist
  get '/artists/:id' do 
    repo = ArtistRepository.new
    id_to_find = params[:id]
    @artist = repo.find(id_to_find)
    return erb(:artist_id)
  end
end