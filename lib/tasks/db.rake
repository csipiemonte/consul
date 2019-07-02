namespace :db do
  desc "Resets the database and loads it from db/dev_seeds.rb"
  task :dev_seed, [:print_log] => [:environment] do |t, args|
    @avoid_log = args[:print_log] == "avoid_log"
    load(Rails.root.join("db", "dev_seeds.rb"))
  end

  desc "populate the default pages manually"
  task pages: :environment do
    load(Rails.root.join("db", "pages.rb"))
  end

  desc "Resets the database and loads it from db/csi_seeds.rb"
  task csi_seed: :environment do
    load(Rails.root.join("db", "csi_seeds.rb"))
  end
end
