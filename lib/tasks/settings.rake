namespace :settings do

  desc "Remove deprecated settings"
  task remove_deprecated_settings: :environment do
    deprecated_keys = [
      "place_name",
      "banner-style.banner-style-one",
      "banner-style.banner-style-two",
      "banner-style.banner-style-three",
      "banner-img.banner-img-one",
      "banner-img.banner-img-two",
      "banner-img.banner-img-three",
      "verification_offices_url"
    ]

    deprecated_keys.each do |key|
      Setting.where(key: key).first&.destroy
    end
  end

  desc "Rename existing settings"
  task rename_setting_keys: :environment do
    Setting.rename_key from: "map_latitude",  to: "map.latitude"
    Setting.rename_key from: "map_longitude", to: "map.longitude"
    Setting.rename_key from: "map_zoom",      to: "map.zoom"

    Setting.rename_key from: "feature.debates",     to: "process.debates"
    Setting.rename_key from: "feature.proposals",   to: "process.proposals"
    Setting.rename_key from: "feature.polls",       to: "process.polls"
    Setting.rename_key from: "feature.budgets",     to: "process.budgets"
    Setting.rename_key from: "feature.legislation", to: "process.legislation"

    Setting.rename_key from: "per_page_code_head", to: "html.per_page_code_head"
    Setting.rename_key from: "per_page_code_body", to: "html.per_page_code_body"

    Setting.rename_key from: "feature.homepage.widgets.feeds.proposals", to: "homepage.widgets.feeds.proposals"
    Setting.rename_key from: "feature.homepage.widgets.feeds.debates",   to: "homepage.widgets.feeds.debates"
    Setting.rename_key from: "feature.homepage.widgets.feeds.processes", to: "homepage.widgets.feeds.processes"
  end

  desc "Adds/Updates Setting key - value"
  task add_upd_key_value: :environment do

    puts "\n Setting key?"
    input_key = STDIN.gets.chomp

    puts "\n Setting value?"
    input_value = STDIN.gets.chomp

    puts "\n Confirm Setting (key: '#{input_key}', value: '#{input_value}')? [Y/N]"
    answer = STDIN.gets.chomp
    if answer == 'Y'
      # your code here
      setting = Setting.where(key: input_key).first
      input_value = nil if input_value.empty?
      if setting
        setting.update(value: input_value)
        puts 'Setting updated successfuly'
      else
        Setting.create(key: input_key, value: input_value)
        puts 'Setting created successfuly'
      end
    elsif answer == 'N'
      puts 'Operation canceled'
    end
  end

  desc "Modifies Setting key"
  task mod_key: :environment do

    puts "\n Setting key?"
    input_key = STDIN.gets.chomp

    puts "\n Setting new key?"
    input_upd_key = STDIN.gets.chomp

    puts "\n Confirm Setting (key from '#{input_key}' to '#{input_upd_key}')? [Y/N]"
    answer = STDIN.gets.chomp
    if answer == 'Y'
      # your code here
      setting = Setting.where(key: input_key).first
      if setting
        setting.update(key: input_upd_key)
        puts 'Setting key updated successfuly'
      else
        puts 'Setting key not found'
      end
    elsif answer == 'N'
      puts 'Operation canceled'
    end
  end
end
