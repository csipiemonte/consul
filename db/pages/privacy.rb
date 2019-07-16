if SiteCustomization::Page.find_by_slug("privacy").nil?
  page = SiteCustomization::Page.new(slug: "privacy", status: "published")
  page.print_content_flag = true
  page.title = I18n.t("pages.privacy.title")
  page.subtitle = I18n.t("pages.privacy.subtitle")
  content = ""
  content << "<p>La consultazione di DecidiTorino, il portale della Citt&agrave; di Torino dedicata alla partecipazione, &egrave; libera e non necessita di registrazione. &Egrave; invece richiesta la registrazione qualora si intenda partecipare attivamente, scrivendo, commentando ovvero appoggiando, le proposte o i dibattiti ivi presenti.</p>
    <p>I dati forniti dagli utenti durante la registrazione sono trattati in modo lecito, corretto e trasparente lecit&agrave; non saranno forniti a terzi, e sono funzionali all'accesso a tutte le sezioni del sito soggette a identificazione, fatte salve le eventuali richieste dell'Autorit&agrave; Giudiziaria.</p>

    <p>L'utente, registrandosi, acconsente esplicitamente al trattamento dei dati personali (art. 6 par 1, a) revocabile in ogni momento con le modalit&agrave; sottospecificate.</p>

    <p>La verifica di residenza in Torino (si/no), qualora richiesta per il passaggio a utente certificato, avviene interrogando la banca dati anagrafica gestita dalla Citt&agrave; di Torino stessa.</p>

    <p>Per gli utenti che si accreditano attraverso l'identit&agrave; nazionale SPID, durante la fase di ingresso nel portale vengono evidenziate le informazioni trasmesse dal fornitore di identit&agrave;.</p>

    <p>Nel corso della navigazione, alcuni dati personali o che potrebbero ricondurre all'identit&agrave; del richiedente (tra cui l'indirizzo internet di provenienza), la cui trasmissione &egrave; implicita nell'uso dei protocolli di comunicazione di Internet, vengono memorizzati nei log di sistema per un massimo di 6 mesi e vengono trattati esclusivamente, dalla Citt&agrave;, in forma anonima, per attivit&agrave; di analisi statistica, nel rispetto della normativa vigente. Essi vengono forniti esclusivamente all'Autorit&agrave; Giudiziaria qualora richiesti a fini di indagine e accertamenti.</p>

    <p>La Citt&agrave; si riserva il diritto all'utilizzo dei dati di registrazione per informare l'utente a riguardo di eventuali iniziative connesse con il portale DecidiTorino.</p>

    <p>Gli utenti registrati possono avvalersi, ove applicabili, dei diritti di accesso (art. 15), di rettifica (art. 16), di cancellazione (art. 17), di limitazione (art. 18), di notifica (art. 19), di portabilit&agrave; (art. 20), di opposizione (art. 21). La Citt&agrave; non utilizza modalit&agrave; di trattamento basate su processi decisionali automatici (art. 22).</p>

    <p>I dati sono trattati sino a revoca dell'utente stesso ovvero nel caso di chiusura del portale.</p>

    <p>L'hosting del portale &egrave; presso il CSI-Piemonte, che si qualifica pertanto come Responsabile esterno del trattamento dati.<br>Tutti i diritti sono esercitabili in qualsiasi momento ricorrendo a<br>Citt&agrave; di Torino, portale DecidiTorino, via Meucci 4, 10122 Torino</p>

    <p>Ulteriori informazioni sull'informativa, come da art. 13 del Regolamento UE 679/2016, inclusi i riferimenti relativi al Titolare e al Responsabile Protezione Dati, sono disponibili nella <a href='http://www.comune.torino.it/amm_com/675.htm'>pagina dedicata sul sito della Citt&agrave; di Torino</a></p>

    <p>Essendo utilizzati solo cookie anonimi tecnici o di sessione che non profilano gli utenti - non &egrave; richiesto un consenso preventivo, maggiori dettagli <a href='http://www.comune.torino.it/condizioni.shtml#cookie'>sull'utilizzo dei cookie sono pubblicati sul sito della Citt&agrave; di Torino</a></p>"

  page.content = content
  page.save!
end
