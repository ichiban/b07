class Init < ActiveRecord::Migration
  def self.up
    create_table :occurrences do |t|
      t.integer :account_id
      t.string :one
      t.string :two
      t.string :three
    end
    
    add_index :occurrences, [:one, :two], :name => 'occurrences_one_two_index'
  end

  def self.down
    drop_table :occurrences
    remove_index :occurrences, 'occurrences_one_two_index'
  end
end
