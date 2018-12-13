namespace :settings do

  desc "Changes Setting key per_page_code for per_page_code_head"
  task per_page_code_migration: :environment do
    per_page_code_setting = Setting.where(key: 'per_page_code').first

    Setting['per_page_code_head'] = per_page_code_setting&.value.to_s if Setting.where(key: 'per_page_code_head').first.blank?
    per_page_code_setting.destroy if per_page_code_setting.present?
  end

  desc "Create new Attached Documents feature setting"
  task create_attached_documents_setting: :environment do
    Setting['feature.allow_attached_documents'] = true
  end

  desc "Enable recommendations settings"
  task enable_recommendations: :environment do
    Setting['feature.user.recommendations'] = true
    Setting['feature.user.recommendations_on_debates'] = true
    Setting['feature.user.recommendations_on_proposals'] = true
  end

  desc "Enable Help page"
  task enable_help_page: :environment do
    Setting['feature.help_page'] = true
  end

  desc "Enable Featured proposals"
  task enable_featured_proposals: :environment do
    Setting['feature.featured_proposals'] = true
    Setting['featured_proposals_number'] = 3
  end

  desc "Create new period to calculate hot_score"
  task create_hot_score_period_setting: :environment do
    Setting['hot_score_period_in_days'] = 31
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
