class LandmarksController < ApplicationController
  
  get '/landmarks' do
    @landmarks = Landmark.all

    erb :'landmarks/index'
  end
  
  get '/landmarks/new' do
    @titles = Title.all
    @figures = Figure.all
    erb :'landmarks/new'
  end

  post '/landmarks' do
    landmark = Landmark.create(params[:landmark])
    
    if !params[:title][:name].empty?
      title = Title.create(params[:title])
      landmark.titles << title
    elsif !params[:figure][:name].empty?
      figure = figure.create(params[:figure])
      landmark.figures << figure
    end

    redirect "/landmarks/#{landmark.id}"
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])

    erb :'landmarks/show'
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])
    @titles = Title.all
    @figures = Figure.all

    erb :'landmarks/edit'
  end
  
  patch '/landmarks/:id' do
    landmark = Landmark.find(params[:id])
    landmark.update(params[:landmark])
    
    redirect "/landmarks/#{@landmark.id}"
  end

end
