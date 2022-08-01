require "test_helper"

class UploadArchiveMailerTest < ActionMailer::TestCase
  test "bad_file" do
    mail = ArchiveUploaderMailer.bad_file
    assert_equal "Bad file", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
