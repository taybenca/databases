require_relative 'lib/database_connection'
require_relative 'lib/artist_repository'
require_relative 'lib/album_repository'

# DatabaseConnection.connect('music_library')

# album_repository = AlbumRepository.new
# artist_repository = ArtistRepository.new

# album_repository.all.each do |album|
#     puts album.title
# end

# artist_repository.all.each do |artist|
#     puts "#{artist.id}. #{artist.name} - #{artist.genre}"
# end

class Application
    # The Application class initializer
    # takes four arguments:
    #  * The database name to call `DatabaseConnection.connect`
    #  * the Kernel object as `io` (so we can mock the IO in our tests)
    #  * the AlbumRepository object (or a double of it)
    #  * the ArtistRepository object (or a double of it)
    def initialize(database_name, io, album_repository, artist_repository)
      DatabaseConnection.connect('music_library')
      @io = io
      @album_repository = album_repository
      @artist_repository = artist_repository
    end

    def run
      # "Runs" the terminal application
      # so it can ask the user to enter some input
      # and then decide to run the appropriate action
      # or behaviour.
      # Use `@io.puts` or `@io.gets` to
      # write output and ask for user input.
      index = 1
      puts "Welcome to the music library manager!\n"
      puts "\nWhat would you like to do?\n  1 - List all albums \n  2 - List all artists\n"
      puts "\nEnter your choice:"
      user_input = @io.gets.chomp 
      case user_input
      when '1'
        @album_repository.all.each do |album|
            puts "* #{index} - #{album.title}"
            index +=1
        end
      when '2'
        @artist_repository.all.each do |artist|
            puts "* #{index} - #{artist.name}"
            index +=1
        end
      end
    end
  end
  # If we run this file using `ruby app.rb`,
  # run the app.
  if __FILE__ == $0
    app = Application.new(
      'music_library',
      Kernel,
      AlbumRepository.new,
      ArtistRepository.new
    )
    app.run
  end
