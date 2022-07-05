require_relative 'lib/database_connection'
require_relative 'lib/artist_repository'
require_relative 'lib/album_repository'

DatabaseConnection.connect('music_library')

album_repository = AlbumRepository.new
artist_repository = ArtistRepository.new

#album_repository.find(3)

album_repository.all.each do |album|
    puts album.title
end

artist_repository.all.each do |artist|
    puts "#{artist.id}. #{artist.name} - #{artist.genre}"
end


