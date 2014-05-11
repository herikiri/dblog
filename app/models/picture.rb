class Picture < ActiveRecord::Base
	belongs_to :imageable, polymorphic: true

	mount_uploader :name, PictureUploader

	private
	    def self.reset_sequence!
	      ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = '#{table_name}'")
	    end
end
