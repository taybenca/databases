require "album_repository"

describe AlbumRepository do
    def reset_albums_table
        seed_sql = File.read('spec/seeds_albums.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
        connection.exec(seed_sql)
    end

    before(:each) do 
        reset_albums_table
    end

    it "returns all albums" do
        repo = AlbumRepository.new
        albums = repo.all
        expect(albums.length).to eq 3
        expect(albums.first.id).to eq '1'
        expect(albums.first.title).to eq 'Abbey Road'
        expect(albums.last.release_year).to eq '1991'
    end

    it 'return only the record with id 1' do
        repo = AlbumRepository.new
        album = repo.find(1)
        expect(album.title).to eq('Abbey Road')
        expect(album.release_year).to eq('1969')
        expect(album.artist_id).to eq('7')
    end

    it 'return only the record with id 3' do
        repo = AlbumRepository.new
        album = repo.find(3)
        expect(album.title).to eq('Nevermind')
        expect(album.release_year).to eq('1991')
        expect(album.artist_id).to eq('8')
    end

    it 'creates an album' do
        repo = AlbumRepository.new
        album = Album.new
        album.title = 'Trompe le Monde'
        album.release_year = '1991'
        album.artist_id = 1
        repo.create(album)
        albums = repo.all
        last_album = albums.last

        expect(album.title).to eq('Trompe le Monde')
        expect(album.release_year).to eq('1991')
        expect(album.artist_id).to eq(1)
        
       
    end
end