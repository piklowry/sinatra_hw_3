require 'sinatra'
require 'sinatra/activerecord'

set :database, "sqlite3:///create_school.db"
set :database, "sqlite3:///create_event.db"

# schools

get "/schools" do
	@schools = School.all
	erb :"schools/index"
end

get "/" do
	redirect "/schools"
end

# create

get "/schools/new" do
  @school = School.new
  erb :"schools/new"
end

post "/schools/new" do
	puts params.inspect
	@school = School.new(params[:id])
	@school = School.new(params[:school])
  if @school.save
    redirect "/schools"
  else
    erb :"schools/new"
  end
end

# update

get '/schools/:id/edit' do 
	@school = School.find(params[:id])
	erb :"schools/edit"
end

put '/schools/:id' do
	@school = School.find(params[:id])
	if @school.update_attributes(params[:school])
		redirect "/schools"
	else
		redirect "/error"
	end
end

# destroy

delete '/schools/:id' do
	@school = School.find(params[:id])
	if @school.delete
		redirect "/schools"
	else
		redirect "/error"
	end
end


get 'schools/:id' do
 	@school = School.find(params[:id])
	erb :"schools/show"
end



# Events


get "/" do
	redirect "/events"
end

get "/events" do
	@events = Event.all
	erb :"events/index"
end

# create

get "/events/new" do
	@event = Event.new
	erb :"events/new"
end

post "/events/new" do
	puts params.inspect
	@event = Event.new(params[:id])
	@event = Event.new(params[:event])
  if @event.save
    redirect "/events"
  else
    erb :"events/new"
  end
end

# update



get '/events/:id/edit' do 
	@event = Event.find(params[:id])
	erb :"events/edit"
end

put '/events/:id' do
	@event = Event.find(params[:id])
	if @event.update_attributes(params[:event])
		redirect "/events"
	else
		redirect "/error"
	end
end

# destroy

delete '/events/:id' do
	@event = Event.find(params[:id])
	if @event.delete
		redirect "/events"
	else
		redirect "/error"
	end
end


# search 


post '/schools/index' do
  @schools = School.search(params[:search])
  erb :"schools/results"
end

post '/events/index' do
  @events = Event.search(params[:search])
  erb :"events/results"
end

post '/schools/results' do
  @schools = School.search(params[:search])
  erb :"schools/results"
end

post '/events/results' do
  @events = Event.search(params[:search])
  erb :"events/results"
end

get '/schools/results' do
  erb :"/schools/results"
end

get '/events/results' do
  erb :"/events/results"
end

class School  < ActiveRecord::Base

  def self.search(params)
		name = params[:name]
		search = School.all
    if name.present?
    	search = search.where('name LIKE ?', "%#{name}%")
    end
		search
	end
end

class Event < ActiveRecord::Base
def self.search(params)
		name = params[:name]
		search = Event.all
    if name.present?
    	search = search.where('name LIKE ?', "%#{name}%")
    end
		search
	end
end