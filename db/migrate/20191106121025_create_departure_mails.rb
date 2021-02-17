class CreateDepartureMails < ActiveRecord::Migration[5.2]
  def change
    create_table :departure_mails do |t|
      t.string :uid
      t.references :register, foreign_key: true
      t.string :internal_reference, unique: true
     
      
      t.datetime :departure_date
      
      t.string :linked_to_mail
      t.string :reference_linked_mail

      t.string :to_answer
      t.datetime :response_limit_time
      t.datetime :response_date

      
      t.references :support, foreign_key: true
      t.references :nature, foreign_key: true
      t.references :correspondent, foreign_key: true
      t.string :object
      t.text :description
      t.string :priority
      t.references :folder, foreign_key: true
      t.string :status
      t.references :user, foreign_key: true

      

      t.timestamps
    end
  end
end
