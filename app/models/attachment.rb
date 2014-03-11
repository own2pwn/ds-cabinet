class Attachment < ActiveRecord::Base
  has_and_belongs_to_many :messages
  mount_uploader :attachment, AttachmentUploader
end
