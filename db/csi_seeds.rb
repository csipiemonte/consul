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
Setting.create(key: 'max_votes_for_debate_edit', value: '1')

# Max votes where a proposal is still editable
Setting.create(key: 'max_votes_for_proposal_edit', value: '1')

# Max length for comments
Setting.create(key: 'comments_body_max_length', value: '1000')

# Prefix for the Proposal codes
Setting.create(key: 'proposal_code_prefix', value: 'TOR')

# Number of votes needed for proposal success
Setting.create(key: 'votes_for_proposal_success', value: '5000')

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
Setting.create(key: 'twitter_handle', value: '@twitorino')
Setting.create(key: 'twitter_hashtag', value: '#deciditorino')
Setting.create(key: 'facebook_handle', value: 'cittaditorino')
Setting.create(key: 'youtube_handle', value: 'youtorino')
Setting.create(key: 'telegram_handle', value: 'comunetorino')
Setting.create(key: 'instagram_handle', value: 'cittaditorino')
Setting.create(key: 'blog_url', value: nil)
Setting.create(key: 'transparency_url', value: 'http://www.comune.torino.it/amministrazionetrasparente/')
Setting.create(key: 'opendata_url', value: nil)

# Public-facing URL of the app.
Setting.create(key: 'url', value: 'http://localhost:3000')

# Consul installation's organization name
Setting.create(key: 'org_name', value: 'DecidiTorino')

# Consul installation place name (City, Country...)
Setting.create(key: 'place_name', value: 'Torino')

# Meta tags for SEO
Setting.create(key: 'meta_title', value: 'DecidiTorino')
Setting.create(key: 'meta_description', value: 'Citizen Participation and Open Government Application')
Setting.create(key: 'meta_keywords', value: 'citizen participation, open government')

# Feature flags
Setting.create(key: 'feature.debates', value: 'true')
Setting.create(key: 'feature.proposals', value: 'true')
Setting.create(key: 'feature.spending_proposals', value: nil)
Setting.create(key: 'feature.polls', value: nil)
Setting.create(key: 'feature.twitter_login', value: 'true')
Setting.create(key: 'feature.facebook_login', value: 'true')
Setting.create(key: 'feature.google_login', value: 'true')
Setting.create(key: 'feature.shibboleth_login', value: nil)
Setting.create(key: 'feature.public_stats', value: 'true')
Setting.create(key: 'feature.budgets', value: 'true')
Setting.create(key: 'feature.signature_sheets', value: 'true')
Setting.create(key: 'feature.legislation', value: 'true')
Setting.create(key: 'feature.user.recommendations', value: 'true')
Setting.create(key: 'feature.community', value: 'false')
Setting.create(key: 'feature.map', value: 'true')

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
Setting.create(key: 'min_age_to_participate', value: '16')

# Proposal improvement url path ('/more-information/proposal-improvement')
Setting.create(key: 'proposal_improvement_path', value: nil)

# City map feature default configuration (Greenwich)
Setting.create(key: 'map_latitude', value: 45.073179654563646)
Setting.create(key: 'map_longitude', value: 7.680763006210328)
Setting.create(key: 'map_zoom', value: 12)

puts " ✅"
print "Creating Geozones (Circoscrizioni)"

Geozone.create(name: "Centro - Crocetta", census_code: "1", html_map_coordinates: "159, 132, 134, 183, 136, 190, 134, 195, 151, 206, 172, 169, 188, 178, 199, 165, 188, 148, 177, 146, 159, 132")
Geozone.create(name: "Santa Rita - Mirafiori Nord - Mirafiori Sud", census_code: "2", html_map_coordinates: "89, 180, 117, 188, 127, 187, 134, 189, 131, 196, 143, 203, 101, 254, 122, 266, 126, 256, 138, 262, 138, 266, 132, 284, 126, 282, 115, 285, 107, 281, 105, 280, 94, 276, 91, 283, 86, 282, 74, 276, 65, 277, 58, 271, 39, 266, 40, 258, 52, 261, 63, 235, 53, 238, 23, 219, 19, 211, 21, 209, 27, 213, 31, 207, 70, 232, 73, 218, 77, 219, 80, 208, 84, 202, 79, 200, 80, 198, 87, 190, 89, 181")
Geozone.create(name: "San Paolo - Cenisia - Pozzo Strada - Cit Turin - Borgata Lesna", census_code: "3", html_map_coordinates: "62, 144, 152, 142, 137, 187, 125, 185, 115, 187, 90, 179, 89, 173, 76, 175, 70, 173, 65, 171, 66, 164, 74, 162, 73, 158, 67, 156, 66, 150, 59, 149, 61, 144")
Geozone.create(name: "San Donato - Campidoglio - Parella", census_code: "4", html_map_coordinates: "82, 99, 80, 110, 75, 115, 72, 116, 69, 123, 62, 143, 154, 139, 167, 112, 133, 109, 131, 119, 75, 90, 82, 99")
Geozone.create(name: "Borgo Vittoria - Madonna di Campagna - Lucento - Vallette", census_code: "5", html_map_coordinates: "92, 62, 76, 89, 126, 115, 136, 105, 168, 111, 200, 61, 144, 52, 130, 68, 123, 67")
Geozone.create(name: "Barriera di Milano - Regio Parco - Barca - Bertolla - Falchera - Rebaudengo - Villaretto", census_code: "6", html_map_coordinates: "136, 38, 145, 48, 165, 41, 172, 55, 183, 52, 192, 61, 198, 61, 200, 70, 172, 111, 187, 113, 203, 132, 231, 115, 234, 103, 248, 104, 262, 108, 281, 89, 258, 73, 254, 44, 232, 40, 227, 33, 237, 17, 225, 14, 223, 23, 197, 28, 171, 13, 155, 12, 148, 20, 138, 18, 143, 30")
Geozone.create(name: "Aurora - Vanchiglia - Sassi - Madonna del Pilone", census_code: "7", html_map_coordinates: "242, 106, 268, 114, 282, 131, 310, 141, 251, 221, 242, 219, 236, 210, 236, 187, 217, 158, 200, 163, 187, 144, 159, 130, 171, 112, 188, 116, 203, 136, 233, 115, 240, 107")
Geozone.create(name: "San Salvario - Cavoretto - Borgo Po - Nizza Millefonti - Lingotto - Filadelfia", census_code: "8", html_map_coordinates: "172, 172, 190, 180, 212, 161, 234, 190, 232, 213, 240, 223, 240, 225, 233, 236, 195, 253, 178, 248, 166, 266, 139, 265, 137, 259, 124, 254, 121, 263, 104, 253, 144, 205, 152, 210, 172, 170")


puts " ✅"
print "Creating Users"

# Default admin user (change password after first deploy to a server!)
if Administrator.count == 0
  admin = User.create!(username: 'DecidiTorino', email: 'admin@deciditorino.it', password: '12345678', password_confirmation: '12345678', confirmed_at: Time.current, terms_of_service: "1")
  admin.create_administrator
end


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
