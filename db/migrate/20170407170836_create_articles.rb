class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.datetime :scrape_session
      t.string :publication
      t.string :url
      t.text :body
      t.datetime :pub_date

      t.timestamps
    end
  end
end
