namespace :tweets do
  desc "Fetch new tweets from users"
  task fetch: :environment do
    SetupFetchingJob.perform_later
  end

  desc "Delete outdated tweets for users"
  task sweep: :environment do
    SetupSweepingJob.perform_later
  end
end
