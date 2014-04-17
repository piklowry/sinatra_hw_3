require 'sinatra'
require 'sinatra/activerecord'

set :database, "sqlite3:///create_school.db"
set :database, "sqlite3:///create_event.db"



get "/schools" do
	@all_schools = School.all
	@new_events = Event.all
	erb :"schools/index"
end
get "/" do
	redirect "/schools"
end

get '/edit' do
  erb :"schools/edit"
end

get "/schools" do
	@all_schools = School.all
	erb :"schools/index"
end

get "/schools/new" do
	erb :"schools/new"
end

get "/schools/new" do
  @title = "New School"
  @school = School.new
  erb :"schools/new"
end


post "/schools/new" do
	puts params.inspect
	@school = School.new(params[:school])
  if @school.save
    redirect "/schools/new"
  else
    erb :"schools/new"
  end
end

post "/schools/new" do
	puts params.inspect
	@event = Event.new(params[:event])
	@event.save
	redirect ""
end

delete '/schools/:id' do
	@school = School.find(params[:id])
	if @school.delete
		redirect "/schools"
	else
		redirect "/error"
	end
end

put '/schools/:id' do
	@school = School.find(params[:id])
	if @school.update_attributes(params[:school])
		redirect "/schools/#{@school.id}"
	else
		redirect "/error"
	end
end

get '/schools/:id/edit' do 
	@school = School.find(params[:id])
	erb :"schools/edit"
end


class School  < ActiveRecord::Base
	end




class Event < ActiveRecord::Base
end