class FiguresController < ApplicationController
  
  get '/figures' do
    @figures = Figure.all

    erb :'figures/index'

  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/new'
  end

  post '/figures' do
    figure = Figure.create(params[:figure])
    if params[:landmark].values.any?{|v| v.length >  0}
      landmark = Landmark.create(params[:landmark])
      figure.landmarks << landmark
    elsif params[:title].values.any?{|v| v.length >  0}
      title = Title.create(params[:title])
      figure.titles << title
    end
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/edit'
  end

  patch '/figures/:id' do
    
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])
    if params[:landmark].values.any?{|v| v.length >  0}
      landmark = Landmark.create(params[:landmark])
      @figure.landmarks << landmark
    elsif params[:title].values.any?{|v| v.length >  0}
      title = Title.create(params[:title])
      @figure.titles << title
    end
    redirect "/figures/#{@figure.id}"
  end

end
