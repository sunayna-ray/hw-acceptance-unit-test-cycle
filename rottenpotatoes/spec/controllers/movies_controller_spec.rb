require 'rails_helper'

describe MoviesController do
        
  describe 'Search movies by the same director' do
    let!(:movie_1) { Movie.create!(title: 'Star Wars', director: 'George Lucas') }
    let!(:movie_2) { Movie.create!(title: 'Blade Runner', director: 'Ridley Scott') }
    let!(:movie_3) { Movie.create!(title: 'Alien') }
    let!(:movie_4) { Movie.create!(title: 'THX-1138', director: 'George Lucas') }
    
    it 'should assign the list of movies with the same director if director exists' do
      get :similar, id: movie_1.id
      movies=[]
            
      for i in assigns(:sim_movies) 
        movies.append(i.title)
      end

      expect(movies).to eql(['Star Wars', 'THX-1138'])
    end
  
        
    it 'should display the similar.html.erb template if director exists' do
        get :similar, id: movie_1.id
        expect(response).to render_template('similar')
    end

        

    it 'should go back to homepage if director does not exist' do
        get :similar, id: movie_3.id
        expect(response).to redirect_to(movies_path)
    end
 end

    describe 'get index function' do
        let!(:movie_1) { Movie.create!(title: 'Star Wars', director: 'George Lucas') }
        let!(:movie_2) { Movie.create!(title: 'Blade Runner', director: 'Ridley Scott') }
        let!(:movie_3) { Movie.create!(title: 'Alien') }
        let!(:movie_4) { Movie.create!(title: 'THX-1138', director: 'George Lucas') }

        it 'should get all the movies' do
            get :index
            movies = []
            for i in assigns(:movies) 
                movies.append(i.title)
            end
            expect(movies).to eql(['Star Wars','Blade Runner','Alien', 'THX-1138'])
        end



        it 'should render index.html.erb template' do
            get :index
            expect(response).to render_template('index')
        end

    end   



    describe 'get show function' do
        let!(:movie) { Movie.create!(title: 'Star Wars', director: 'George Lucas')}
        
        it 'should get the movie to show' do
            get :show, id: movie.id
            expect(@controller.instance_variable_get(:@movie)).to eql(movie)
        end
        
        

        it 'should render show.html.erb template' do
            get :show, id: movie.id
            expect(response).to render_template('show')
        end

    end
    

    
    describe 'get new function' do
        let!(:movie) { Movie.new }
        it 'should display new.html.erb template' do
            get :new
            expect(response).to render_template('new')
        end
    end
    
    describe 'post create function' do
        let!(:movie_1) { Movie.create!(title: 'Alien') }
        let!(:movie_2) { Movie.create!(title: 'THX-1138', director: 'George Lucas') }
        it 'should create a new movie' do
            post :create, movie: {title: 'Star Wars', director: 'George Lucas'}
            expect(Movie.count).to eql(3)
        end
        it 'should redirect to index page' do
            post :create, movie: {title: 'Star Wars', director: 'George Lucas'}
            expect(response).to redirect_to(movies_path)
        end
    end
    
    describe 'PUT #update' do
    let(:movie1) { FactoryBot.create(:movie) }
    before(:each) do
      put :update, id: movie1.id, movie: FactoryBot.attributes_for(:movie, title: 'Modified')
    end

    it 'updates an existing movie' do
      movie1.reload
      expect(movie1.title).to eql('Modified')
    end

    it 'redirects to the movie page' do
      expect(response).to redirect_to(movie_path(movie1))
    end
  end
  
  describe 'DELETE #destroy' do
    let!(:movie1) { FactoryBot.create(:movie) }

    it 'destroys a movie' do
      expect { delete :destroy, id: movie1.id
      }.to change(Movie, :count).by(-1)
    end

    it 'redirects to movies#index after destroy' do
      delete :destroy, id: movie1.id
      expect(response).to redirect_to(movies_path)
    end
  end
  
    describe 'GET #edit' do
    let!(:movie) { FactoryBot.create(:movie) }
    before do
      get :edit, id: movie.id
    end

    it 'should find the movie' do
      expect(assigns(:movie)).to eq(movie)
    end

    it 'should render the edit template' do
      expect(response).to render_template('edit')
    end
  end
  

end