namespace :db do
  desc "Resets the database and loads it from db/dev_seeds.rb"
  task dev_seed: :environment do
    load(Rails.root.join("db", "dev_seeds.rb"))
  end

  desc "Resets the database and loads it from db/csi_seeds.rb"
  task csi_seed: :environment do
    load(Rails.root.join("db", "csi_seeds.rb"))
  end
end
