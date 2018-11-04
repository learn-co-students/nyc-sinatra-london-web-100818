class LandmarksController < ApplicationController

  get '/landmarks' do
    erb :'/landmarks/index'
  end

  get '/landmarks/new' do
    erb :'/landmarks/new'
  end

  post "/landmarks" do
    @landmark = Landmark.create(params[:landmark])
    params[:landmark][:figure_ids].each do |fig|
      @figure = Figure.find_or_create_by(fig)
      @figure.landmark_id = @landmark.id
    redirect "/landmarks/#{Landmark.last.id}"
    end
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    erb :'/landmarks/show'
  end

  get "/landmarks/:id/edit" do
    @landmark = Landmark.find(params[:id])
    erb :'/landmarks/edit'
  end

  patch "/landmarks/:id" do
    #binding.pry
    @landmark = Landmark.update(params[:id], params[:landmark])
    redirect "/landmarks/#{@landmark.id}"
  end
end
