require_relative "./album"

class AlbumRepository
    # Selecting all records
    # No arguments
    def all
      sql = "SELECT * FROM albums;"
      result_set = DatabaseConnection.exec_params(sql, [])
      albums = []
      result_set.each do |record|
        album = Album.new
        album.id = record["id"]
        album.title = record["title"]
        album.release_year = record["release_year"]
        album.artist_id = record["artist_id"]
        albums << album
      end
      return albums
    end
end