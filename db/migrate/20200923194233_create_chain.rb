class CreateChain < ActiveRecord::Migration[5.2]
  def change
    create_table :chains do |t|
    	t.string :cnpj
    	t.string :name
    	t.timestamps	 
    end    
  end
end
