class UserFile < ActiveRecord::Base
  mount_uploader :file, UserFilesUploader 
  validate :file_size
  belongs_to :user
  private
  
    def file_size
      if file.file.size.to_f > 3.megabytes
        errors.add(:file, "You cannot upload a file greater  than 3 megabytes")
      end
    end
end
