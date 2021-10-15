require 'simplecov'
SimpleCov.start 'rails'
require 'rails_helper'
require 'spec_helper'

describe MoviesController do
  describe 'Search movies by the same director' do
    it 'should call Movie.similar_movies' do
      expect(Movie).to receive(:similar_movies).with('Aladdin')
      get :search, { title: 'Aladdin' }
    end

    it 'Need to assign similar movies if director exists' do
      movies = ['Seven Pounds', 'Pursuit of Happiness']
      Movie.stub(:similar_movies).with('Seven Pounds').and_return(movies)
      get :search, { title: 'Seven Pounds' }
      expect(assigns(:similar_movies)).to eql(movies)
    end

    it "should redirect to home page if director isn't known" do
      Movie.stub(:similar_movies).with('No name').and_return(nil)
      get :search, { title: 'No name' }
      expect(response).to redirect_to(movies_path)
    end

    it 'destroys a movie with given id' do
        movie = Movie.create(:title => "Batman", :director => "Christopher Nolan")
        delete :destroy, :id => movie.id
        expect{Movie.find(movie.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end
    
    it 'tests creation of a movie' do
        post :create, :movie => { :title => "P", :director => "Director", :rating => "Rating", :release_date =>"09/09/2010"}
        expect(flash[:notice]).to be_present
        expect(response).to redirect_to(movies_path)
    end
  end
end