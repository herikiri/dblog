class Category < ActiveRecord::Base
	has_and_belongs_to_many :articles
	belongs_to :user

	private
    def self.reset_sequence!
      ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = '#{table_name}'")
    end
end
