class TagController < ApplicationController

  get '/tags' do
    if session[:user_id]
      @user = User.find_by_id(session[:user_id])
      @tags = Tag.all
      erb :'tags/index'
    else
      redirect '/login'
    end
  end

  get '/tags/new' do
    if session[:user_id]
      @user = User.find_by_id(session[:user_id])
      erb :'tags/new'
    else
      redirect '/login'
    end
  end

  post '/tags' do
    if params[:name] == ""
      redirect "/tags/new"
    else
      @user = User.find_by_id(session[:user_id])
      @tag = Tag.create(:name => params[:name])
      redirect "/tags/#{@tag.id}"
    end
  end

  get '/tags/:id' do
    if session[:user_id]
      @user = User.find_by_id(session[:user_id])
      @tag = Tag.find_by_id(params[:id])
      erb :'tags/show'
    else
      redirect '/login'
    end
  end

  get '/tags/:id/edit' do
    @tag = Tag.find_by_id(params[:id])
    @user = User.find_by_id(session[:user_id])
    if session[:user_id]
      if @user == @tag.user
        erb :'/tags/edit'
      else
        redirect "/tags/#{@tag.id}"
      end
    else
      redirect '/login'
    end
  end

  patch '/tags/:id' do
      if params[:name] == ""
        redirect to "/tags/#{params[:id]}/edit"
      else
        @tag = Tag.find_by_id(params[:id])
        @tag.name = params[:name]
        @tag.save
        redirect to "/tags/#{@tag.id}"
      end
    end

    delete '/tags/:id/delete' do
      @tag = Tag.find(params[:id])
      @user = User.find_by_id(session[:user_id])
      if @user == @tag.user
          @tag.delete
          redirect '/tags'
      else
        redirect "/tags/#{params[:id]}"
      end
    end


end
