require 'database_cleaner'

DatabaseCleaner.clean_with :truncation

print "Creating Settings"

# Names for the moderation console, as a hint for moderators
# to know better how to assign users with official positions
Setting.create(key: 'official_level_1_name', value: 'Impiegati pubblici')
Setting.create(key: 'official_level_2_name', value: 'Organizzazione Municipale')
Setting.create(key: 'official_level_3_name', value: 'Direttori generali')
Setting.create(key: 'official_level_4_name', value: 'Assessori')
Setting.create(key: 'official_level_5_name', value: 'Sindaco')

# Max percentage of allowed anonymous votes on a debate
Setting.create(key: 'max_ratio_anon_votes_on_debates', value: '50')

# Max votes where a debate is still editable
Setting.create(key: 'max_votes_for_debate_edit', value: '1000')

# Max votes where a proposal is still editable
Setting.create(key: 'max_votes_for_proposal_edit', value: '1000')

# Max length for comments
Setting.create(key: 'comments_body_max_length', value: '1000')

# Prefix for the Proposal codes
Setting.create(key: 'proposal_code_prefix', value: 'TOR')

# Number of votes needed for proposal success
Setting.create(key: 'votes_for_proposal_success', value: '53726')

# Months to archive proposals
Setting.create(key: 'months_to_archive_proposals', value: '12')

# Users with this email domain will automatically be marked as level 1 officials
# Emails under the domain's subdomains will also be included
Setting.create(key: 'email_domain_for_officials', value: '')

# Code to be included at the top (inside <head>) of every page (useful for tracking)
Setting.create(key: 'per_page_code_head', value: '')

# Code to be included at the top (inside <body>) of every page
Setting.create(key: 'per_page_code_body', value: '')

# Social settings
Setting.create(key: 'twitter_handle', value: '@deciditorino')
Setting.create(key: 'twitter_hashtag', value: '#deciditorino')
Setting.create(key: 'facebook_handle', value: 'deciditorino')
Setting.create(key: 'youtube_handle', value: 'deciditorino')
Setting.create(key: 'telegram_handle', value: 'deciditorino')
Setting.create(key: 'instagram_handle', value: 'deciditorino')
Setting.create(key: 'blog_url', value: '')
Setting.create(key: 'transparency_url', value: nil)
Setting.create(key: 'opendata_url', value: '/opendata')

# Public-facing URL of the app.
Setting.create(key: 'url', value: 'http://localhost:3000')

# Consul installation's organization name
Setting.create(key: 'org_name', value: 'DecidiTorino')

# Consul installation place name (City, Country...)
Setting.create(key: 'place_name', value: 'Torino')

# Meta tags for SEO
Setting.create(key: 'meta_description', value: 'Citizen Participation and Open Government Application')
Setting.create(key: 'meta_keywords', value: 'citizen participation, open government')

# Feature flags
Setting.create(key: 'feature.debates', value: 'true')
Setting.create(key: 'feature.spending_proposals', value: nil)
Setting.create(key: 'feature.polls', value: 'true')
Setting.create(key: 'feature.twitter_login', value: 'true')
Setting.create(key: 'feature.facebook_login', value: 'true')
Setting.create(key: 'feature.google_login', value: 'true')
Setting.create(key: 'feature.shibboleth_login', value: 'true')
Setting.create(key: 'feature.public_stats', value: 'true')
Setting.create(key: 'feature.budgets', value: 'true')
Setting.create(key: 'feature.signature_sheets', value: 'true')
Setting.create(key: 'feature.legislation', value: 'true')

# Spending proposals feature flags
Setting.create(key: 'feature.spending_proposal_features.voting_allowed', value: nil)

# Banner styles
Setting.create(key: 'banner-style.banner-style-one', value: 'Banner style 1')
Setting.create(key: 'banner-style.banner-style-two', value: 'Banner style 2')
Setting.create(key: 'banner-style.banner-style-three', value: 'Banner style 3')

# Banner images
Setting.create(key: 'banner-img.banner-img-one', value: 'Banner image 1')
Setting.create(key: 'banner-img.banner-img-two', value: 'Banner image 2')
Setting.create(key: 'banner-img.banner-img-three', value: 'Banner image 3')

# Proposal notifications
Setting.create(key: 'proposal_notification_minimum_interval_in_days', value: '3')
Setting.create(key: 'direct_message_max_per_day', value: '3')

# Email settings
Setting.create(key: 'mailer_from_name', value: 'DecidiTorino')
Setting.create(key: 'mailer_from_address', value: 'noreply@deciditorino.it')

# Verification settings
Setting.create(key: 'verification_offices_url', value: 'http://oficinas-atencion-ciudadano.url/')
Setting.create(key: 'min_age_to_participate', value: '18')

# Proposal improvement url path ('/more-information/proposal-improvement')
Setting.create(key: 'proposal_improvement_path', value: nil)

puts " ✅"
print "Creating Geozones (Circoscrizioni)"

Geozone.create(name: "Centro - Crocetta", census_code: "1")
Geozone.create(name: "Santa Rita - Mirafiori Nord - Mirafiori Sud", census_code: "2")
Geozone.create(name: "San Paolo - Cenisia - Pozzo Strada - Cit Turin - Borgata Lesna", census_code: "3")
Geozone.create(name: "San Donato - Campidoglio - Parella", census_code: "4")
Geozone.create(name: "Borgo Vittoria - Madonna di Campagna - Lucento - Vallette", census_code: "5")
Geozone.create(name: "Barriera di Milano - Regio Parco - Barca - Bertolla - Falchera - Rebaudengo - Villaretto", census_code: "6")
Geozone.create(name: "Aurora - Vanchiglia - Sassi - Madonna del Pilone", census_code: "7")
Geozone.create(name: "San Salvario - Cavoretto - Borgo Po - Nizza Millefonti - Lingotto - Filadelfia", census_code: "8")



puts " ✅"
print "Creating Users"

# Default admin user (change password after first deploy to a server!)
if Administrator.count == 0
  admin = User.create!(username: 'admin', email: 'admin@deciditorino.it', password: '12345678', password_confirmation: '12345678', confirmed_at: Time.current, terms_of_service: "1")
  admin.create_administrator
end

def create_user(email, username = Faker::Name.name)
  pwd = '12345678'
  User.create!(
    username:               username,
    email:                  email,
    password:               pwd,
    password_confirmation:  pwd,
    confirmed_at:           Time.current,
    terms_of_service:       "1",
    gender:                 ['Male', 'Female'].sample,
    date_of_birth:          rand((Time.current - 80.years) .. (Time.current - 16.years)),
    public_activity:        (rand(1..100) > 30)
  )
end

moderator = create_user('mod@deciditorino.it', 'mod')
moderator.create_moderator

manager = create_user('manager@deciditorino.it', 'manager')
manager.create_manager

valuator = create_user('valuator@deciditorino.it', 'valuator')
valuator.create_valuator

verified = create_user('verified@deciditorino.it', 'verified')
verified.update(residence_verified_at: Time.current, confirmed_phone: Faker::PhoneNumber.phone_number, document_type: "1", verified_at: Time.current, document_number: "3333333333")

puts " ✅"
print "Creating Tags Categories"

ActsAsTaggableOn::Tag.category.create!(name:  "Associazioni")
ActsAsTaggableOn::Tag.category.create!(name:  "Cultura")
ActsAsTaggableOn::Tag.category.create!(name:  "Sport")
ActsAsTaggableOn::Tag.category.create!(name:  "Diritti Sociali")
ActsAsTaggableOn::Tag.category.create!(name:  "Economia")
ActsAsTaggableOn::Tag.category.create!(name:  "Lavoro")
ActsAsTaggableOn::Tag.category.create!(name:  "Equità")
ActsAsTaggableOn::Tag.category.create!(name:  "Sostenibilità")
ActsAsTaggableOn::Tag.category.create!(name:  "Partecipazione")
ActsAsTaggableOn::Tag.category.create!(name:  "Mobilità")
ActsAsTaggableOn::Tag.category.create!(name:  "Salute")
ActsAsTaggableOn::Tag.category.create!(name:  "Trasparenza")
ActsAsTaggableOn::Tag.category.create!(name:  "Sicurezza e Emergenze")
ActsAsTaggableOn::Tag.category.create!(name:  "Ambiente")

puts " ✅"
puts "All CSI seeds created successfuly 👍"
