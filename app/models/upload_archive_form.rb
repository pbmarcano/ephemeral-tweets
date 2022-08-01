class UploadArchiveForm
  include ActiveModel::Model

  attr_accessor :archive
  attr_accessor :user

  validates :archive, presence: true

  def save
    if valid?
      user.archive.attach(archive)
      UploadArchiveJob.perform_later(user)
    else
      return false
    end
  end
end
