class Genre
  extend Concerns::Findable
  attr_accessor :name

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

  def self.create(genre)
    genre = Genre.new(genre)
    self.all << genre
    genre
  end

  def songs
    @songs
  end

  def artists
    non_unique_artists = songs.collect do |song|
      song.artist
    end
    non_unique_artists.uniq
  end

end
