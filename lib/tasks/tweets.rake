namespace :tweets do
  desc "Fetch new tweets from users"
  task fetch: :environment do
    # TODO: Create jobs to collect user tweets
  end

  desc "Delete outdated tweets for users"
  task sweep: :environment do
    SetupSweepingUsersJob.perform_later
  end
end
