class FiguresController < ApplicationController
  
  get '/figures' do
    erb :'/figures/index'
  end

  get '/figures/new' do
    erb :'/figures/new'
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])
    if params[:figure][:landmark_ids]
      params[:figure][:landmark_ids].each do |lm|
        @landmark = Landmark.find_or_create_by(lm)
        @landmark.figure_id = @figure.id
      end
    else
      @figure.landmarks << Landmark.create(params[:landmark])
    end
    if !params[:title][:name].empty?
      @figure.titles << Title.create(params[:title])
    end
    redirect "/figures/#{Figure.last.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  get "/figures/:id/edit" do
    @figure = Figure.find(params[:id])
    erb :'/figures/edit'
  end


  patch "/figures/:id" do
    
    @figure = Figure.update(params[:id], params[:figure])
    @figure.landmarks << Landmark.find_or_create_by(params[:landmark])
    @figure.save
    redirect "/figures/#{@figure.id}"
  end

end
