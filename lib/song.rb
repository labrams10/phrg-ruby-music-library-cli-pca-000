require 'pry'
class Song
  attr_accessor :name, :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist
    self.genre = genre
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    song = Song.new(name)
    self.all << song
    song
  end

  def artist=(artist)
    @artist = artist
    unless artist == nil
    artist.add_song(self)
    end
  end

  def genre=(genre)
    @genre = genre
    unless genre == nil
    genre.songs << self unless genre.songs.include?(self)
    end
  end

  def self.find_by_name(name)
    all.find {|song| song.name == name }
  end


  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end

  def self.new_from_filename(filename)
    parts = filename.split(" - ")
    artist_name, song_name, genre_name = parts[0], parts[1], parts[2].gsub(".mp3", "")

    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)

    new(song_name, artist, genre)
  end

  def self.create_from_filename(filename)
    new_from_filename(filename).tap do |s|
      s.save
    end
  end

end
