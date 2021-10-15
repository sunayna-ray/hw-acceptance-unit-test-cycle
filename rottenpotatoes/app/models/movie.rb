class Movie < ActiveRecord::Base
    def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def self.similar_movies movie_title
    director = Movie.find_by(title: movie_title).director
    return nil if director.blank? or director.nil?
    Movie.where(director: director).pluck(:title)
  end
  def self.similar_director_movies movie_director
      if not movie_director.nil?
          return Movie.where(director: movie_director).all
      end 
    end
end
