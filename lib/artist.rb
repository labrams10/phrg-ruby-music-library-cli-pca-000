require 'pry'
class Artist
  extend Concerns::Findable
  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
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

  def self.create(artist)
    artist = Artist.new(artist)
    self.all << artist
    artist
  end

  def songs
    @songs
  end

  def add_song(song)
    @songs << song unless
    @songs.include? song
    song.artist = self unless
    song.artist == self
  end

  def genres
    non_unique_genres = songs.collect do |song|
      song.genre
    end
    non_unique_genres.uniq
  end


end
