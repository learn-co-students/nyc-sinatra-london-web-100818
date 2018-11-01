class FiguresController < ApplicationController

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/new'
  end

  post '/figures' do
    figure = Figure.create(params[:figure])
    # binding.pry
    if !params[:title][:name].empty?
      title = Title.create(params[:title])
      figure.titles << title
    elsif !params[:landmark][:name].empty?
      landmark = Landmark.create(params[:landmark])
      figure.landmarks << landmark
    end
    
    redirect "/figures/#{figure.id}"
  end

end

