require 'bundler'
require './idea'
Bundler.require

class IdeaBoxApp < Sinatra::Base
  set :method_override, true

  not_found do
    erb :error
  end

  post '/' do
    idea = Idea.new(params[:idea])
    idea.save
    redirect '/'
  end

  delete '/:id' do |id|
    Idea.delete(id.to_i)
    redirect '/'
  end

  get '/:id/edit' do |id|
    idea = Idea.find(id.to_i)
    erb :edit, locals: {id: id, idea: idea}
  end

  put '/:id' do |id|
    Idea.update(id.to_i, params[:idea])
    redirect '/'
  end

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :index, locals: {ideas: Idea.all, idea: Idea.new}
  end

end
