require_relative 'lib/database_connection'
require_relative 'lib/artist_repository'
require_relative 'lib/album_repository'

DatabaseConnection.connect('music_library')

album_repository = AlbumRepository.new

album_repository.all.each do |album|
    p album.title
end


# artist_repository = ArtistRepository.new

# artist_repository.all.each do |artist|
#     p artist
# end


