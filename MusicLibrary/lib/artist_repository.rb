require_relative './artist'

class ArtistRepository
  def all
    sql = 'SELECT id, name, genre FROM artists;'
    result_set = DatabaseConnection.exec_params(sql, [])

    artists = []

    result_set.each do |record|
      artist = Artist.new
      artist.id = record['id']
      artist.name = record['name']
      artist.genre = record['genre']
      artists << artist
    end
    return artists
  end

  def find(id)
    sql = 'SELECT id, name, genre FROM artists WHERE id = $1;'
    result_set = DatabaseConnection.exec_params(sql, [id])

    artist = Artist.new
    artist.id = result_set[0]['id'].to_i
    artist.name = result_set[0]['name']
    artist.genre = result_set[0]['genre']

    return artist
  end

  def create(artist)
    sql = 'INSERT INTO artists (name, genre) VALUES ($1, $2);'
    result_set = DatabaseConnection.exec_params(sql, [artist.name, artist.genre])

    return artist
  end
end