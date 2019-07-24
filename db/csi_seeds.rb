# require "database_cleaner"
# DatabaseCleaner.clean_with :truncation

# coding: utf-8
# Default admin user (change password after first deploy to a server!)
if Administrator.count == 0
  admin = User.create!(username: "DecidiTorino", email: "admin@deciditorino.it", password: "12345678",
  	                   password_confirmation: "12345678", confirmed_at: Time.current,
  	                   terms_of_service: "1")
  admin.create_administrator
end

Setting.reset_defaults

WebSection.create(name: "homepage")
WebSection.create(name: "debates")
WebSection.create(name: "proposals")
WebSection.create(name: "budgets")
WebSection.create(name: "help_page")

# Default custom pages
load Rails.root.join("db", "pages.rb")

puts " ✅"
print "Creating Geozones (Circoscrizioni)"

Geozone.create(name: "Centro - Crocetta",
	           external_code: "001", census_code: "01",
	           html_map_coordinates: "159, 132, 134, 183, 136, 190, 134, 195, 151, 206, 172, 169, 188, 178, 199, 165, 188, 148, 177, 146, 159, 132")
Geozone.create(name: "Santa Rita - Mirafiori Nord - Mirafiori Sud",
	           external_code: "002", census_code: "02",
	           html_map_coordinates: "89, 180, 117, 188, 127, 187, 134, 189, 131, 196, 143, 203, 101, 254, 122, 266, 126, 256, 138, 262, 138, 266, 132, 284, 126, 282, 115, 285, 107, 281, 105, 280, 94, 276, 91, 283, 86, 282, 74, 276, 65, 277, 58, 271, 39, 266, 40, 258, 52, 261, 63, 235, 53, 238, 23, 219, 19, 211, 21, 209, 27, 213, 31, 207, 70, 232, 73, 218, 77, 219, 80, 208, 84, 202, 79, 200, 80, 198, 87, 190, 89, 181")
Geozone.create(name: "San Paolo - Cenisia - Pozzo Strada - Cit Turin - Borgata Lesna",
	           external_code: "003", census_code: "03",
	           html_map_coordinates: "62, 144, 152, 142, 137, 187, 125, 185, 115, 187, 90, 179, 89, 173, 76, 175, 70, 173, 65, 171, 66, 164, 74, 162, 73, 158, 67, 156, 66, 150, 59, 149, 61, 144")
Geozone.create(name: "San Donato - Campidoglio - Parella",
	           external_code: "004", census_code: "04",
	           html_map_coordinates: "82, 99, 80, 110, 75, 115, 72, 116, 69, 123, 62, 143, 154, 139, 167, 112, 133, 109, 131, 119, 75, 90, 82, 99")
Geozone.create(name: "Borgo Vittoria - Madonna di Campagna - Lucento - Vallette",
	           external_code: "005", census_code: "05",
	           html_map_coordinates: "92, 62, 76, 89, 126, 115, 136, 105, 168, 111, 200, 61, 144, 52, 130, 68, 123, 67")
Geozone.create(name: "Barriera di Milano - Regio Parco - Barca - Bertolla - Falchera - Rebaudengo - Villaretto",
	           external_code: "006", census_code: "06",
	           html_map_coordinates: "136, 38, 145, 48, 165, 41, 172, 55, 183, 52, 192, 61, 198, 61, 200, 70, 172, 111, 187, 113, 203, 132, 231, 115, 234, 103, 248, 104, 262, 108, 281, 89, 258, 73, 254, 44, 232, 40, 227, 33, 237, 17, 225, 14, 223, 23, 197, 28, 171, 13, 155, 12, 148, 20, 138, 18, 143, 30")
Geozone.create(name: "Aurora - Vanchiglia - Sassi - Madonna del Pilone",
	           external_code: "007", census_code: "07",
	           html_map_coordinates: "242, 106, 268, 114, 282, 131, 310, 141, 251, 221, 242, 219, 236, 210, 236, 187, 217, 158, 200, 163, 187, 144, 159, 130, 171, 112, 188, 116, 203, 136, 233, 115, 240, 107")
Geozone.create(name: "San Salvario - Cavoretto - Borgo Po - Nizza Millefonti - Lingotto - Filadelfia",
	           external_code: "008", census_code: "08",
	           html_map_coordinates: "172, 172, 190, 180, 212, 161, 234, 190, 232, 213, 240, 223, 240, 225, 233, 236, 195, 253, 178, 248, 166, 266, 139, 265, 137, 259, 124, 254, 121, 263, 104, 253, 144, 205, 152, 210, 172, 170")

puts " ✅"
print "Creating Tags Categories"

ActsAsTaggableOn::Tag.category.create!(name: I18n.t("seeds.categories.associations"))
ActsAsTaggableOn::Tag.category.create!(name: I18n.t("seeds.categories.culture"))
ActsAsTaggableOn::Tag.category.create!(name: I18n.t("seeds.categories.sports"))
ActsAsTaggableOn::Tag.category.create!(name: I18n.t("seeds.categories.social_rights"))
ActsAsTaggableOn::Tag.category.create!(name: I18n.t("seeds.categories.economy"))
ActsAsTaggableOn::Tag.category.create!(name: I18n.t("seeds.categories.employment"))
ActsAsTaggableOn::Tag.category.create!(name: I18n.t("seeds.categories.equity"))
ActsAsTaggableOn::Tag.category.create!(name: I18n.t("seeds.categories.sustainability"))
ActsAsTaggableOn::Tag.category.create!(name: I18n.t("seeds.categories.participation"))
ActsAsTaggableOn::Tag.category.create!(name: I18n.t("seeds.categories.mobility"))
ActsAsTaggableOn::Tag.category.create!(name: I18n.t("seeds.categories.media"))
ActsAsTaggableOn::Tag.category.create!(name: I18n.t("seeds.categories.health"))
ActsAsTaggableOn::Tag.category.create!(name: I18n.t("seeds.categories.transparency"))
ActsAsTaggableOn::Tag.category.create!(name: I18n.t("seeds.categories.security_emergencies"))
ActsAsTaggableOn::Tag.category.create!(name: I18n.t("seeds.categories.environment"))

puts " ✅"
puts "All CSI seeds created successfuly 👍"
