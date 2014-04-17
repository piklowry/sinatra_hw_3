class CreateSchool < ActiveRecord::Migration
	def change
    	create_table :schools do |t|
  		t.string :name
  		t.string :location
  		t.string :age
  end
 end
end
