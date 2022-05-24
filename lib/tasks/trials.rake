namespace :trials do
  desc "Delete users after trial complete"
  task delete_users: :environment do
    DeleteTrialUsersJob.perform_later
  end
end
