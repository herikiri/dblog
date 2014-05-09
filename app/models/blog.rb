class Blog < ActiveRecord::Base
  belongs_to :user
  has_many :articles

  private
	  def self.reset_sequence!
	    ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = '#{table_name}'")
	  end
end
