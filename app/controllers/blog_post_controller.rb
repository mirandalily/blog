class BlogPostController < ApplicationController

  get '/posts' do
    if session[:user_id]
      @user = User.find_by_id(session[:user_id])
      @posts = Post.all
      erb :'posts/index'
    else
      redirect '/login'
    end
  end

  get '/posts/new' do
    if session[:user_id]
      @user = User.find_by_id(session[:user_id])
      erb :'posts/new'
    else
      redirect '/login'
    end
  end

  post '/posts' do
    if params[:content] == ""
      redirect "/posts/new"
    else
      @user = User.find_by_id(session[:user_id])
      @post = Post.create(:content => params[:content], :title => params[:title], :user_id => @user.id)
      redirect "/posts/#{@post.id}"
    end
  end

  get '/posts/:id' do
    if session[:user_id]
      @user = User.find_by_id(session[:user_id])
      @post = Post.find_by_id(params[:id])
      erb :'posts/show'
    else
      redirect '/login'
    end
  end

  get '/posts/:id/edit' do
    @post = Post.find_by_id(params[:id])
    @user = User.find_by_id(session[:user_id])
    if session[:user_id]
      if @user == @post.user
        erb :'/posts/edit'
      else
        redirect "/posts/#{@post.id}"
      end
    else
      redirect '/login'
    end
  end

  patch '/posts/:id' do
      if params[:content] == ""
        redirect to "/posts/#{params[:id]}/edit"
      else
        @post = Post.find_by_id(params[:id])
        @post.content = params[:content]
        @post.save
        redirect to "/posts/#{@post.id}"
      end
    end

  delete '/posts/:id/delete' do
    @post = Post.find(params[:id])
    @user = User.find_by_id(session[:user_id])
    if @user == @post.user
        @post.delete
        redirect '/posts'
    else
      redirect "/posts/#{params[:id]}"
    end
  end

end
