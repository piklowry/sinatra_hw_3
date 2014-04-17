class CreateEvent < ActiveRecord::Migration
	def change
    	create_table :events do |t|
  		t.string :name
  		t.string :location
  		t.string :age
  
   end
 end
end