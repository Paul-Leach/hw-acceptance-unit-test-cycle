require 'rails_helper'

describe MoviesController do
    describe 'edit' do
        before(:each) do
            @fake_result = [double('movie')]
        end
        it 'calls the model to get the movie' do
            expect(Movie).to receive(:find).with('3').and_return(@fake_result)
            get :edit,{:id=>3}
        end
        describe 'after looking up the movie' do
            before(:each) do
                allow(Movie).to receive(:find).with('3').and_return(@fake_result)
                get :edit,{:id=>3}
            end
            it 'selects the edit page template for rendering' do
                expect(response).to render_template('edit')
            end
            it 'makes the movie available to the templage' do
                expect(assigns(:movie)).to eq(@fake_result)
            end
        end
    end
    describe 'similar' do
        before(:each) do
            @fake_result = double('movie1',:director=>"nobody")
        end
        it 'calls the model to get the movie' do
            expect(Movie).to receive(:find).with('3').and_return(@fake_result)
            get :similar,{:id=>3}
        end
        it 'redirects to /movies if no director info' do
                @fake_result = double('movie2',{:director=>"",:title=>"movie"})
                allow(Movie).to receive(:find).with('3').and_return(@fake_result)
                get :similar,{:id=>3}
                expect(response).to redirect_to('/')
        end
        describe 'after looking up the movie' do
            before(:each) do
                @fake_results = [double('movie3',:director=>"nobody"), double('movie4',:director=>"nobody")]
                allow(Movie).to receive(:find).with('3').and_return(@fake_result)
                expect(Movie).to receive(:where).with({:director => @fake_result.director}).and_return(@fake_results)
                get :similar,{:id=>3}
            end
            it 'selects the index page template for rendering' do
                expect(response).to render_template('index')
            end
            it 'makes the movies available to the template' do
                expect(assigns(:movies)).to eq(@fake_results)
            end
        end
    end
end