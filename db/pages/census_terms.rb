# Termini di accesso usati nella procedura di certifcazione dell'account
if SiteCustomization::Page.find_by_slug("census_terms").nil?
  page = SiteCustomization::Page.new(slug: "census_terms", status: "published")
  page.print_content_flag = false
  page.title = "Termini d'uso aggiuntivi per utenti certificati"
  page.content = "<p>#{I18n.t("pages.census_terms")}</p>"
  page.save!
end
