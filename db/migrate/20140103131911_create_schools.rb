class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.references   :user
      t.string       :name
      t.string       :email
      t.string       :owner
      t.string       :phone
      t.string       :mobile
      t.string       :address
      t.string       :state
      t.string       :city
      t.integer      :country_id
      t.timestamps
    end
  end
end
