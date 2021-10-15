require 'simplecov'
SimpleCov.start 'rails'
require 'spec_helper'
require 'rails_helper'

describe Movie do
  describe '.find_similar_movies' do
    let!(:movie1) { FactoryGirl.create(:movie, title: 'Pursuit of Happiness', director: 'Gabriele Muccino') }
    let!(:movie2) { FactoryGirl.create(:movie, title: 'Iron man', director: 'Jon Favreau') }
    let!(:movie3) { FactoryGirl.create(:movie, title: "Seven Pounds", director: 'Gabriele Muccino') }
    let!(:movie4) { FactoryGirl.create(:movie, title: "Stop") }

    context 'director exists' do
      it 'find movies with same director correctly' do
        expect(Movie.similar_movies(movie1.title)).to eql(['Pursuit of Happiness', "Seven Pounds"])
        expect(Movie.similar_movies(movie1.title)).to_not include(['Iron man'])
        expect(Movie.similar_movies(movie2.title)).to eql(['Iron man'])
      end
    end

  end
end