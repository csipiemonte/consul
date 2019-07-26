namespace :dashboards do

  desc "Send to user notifications from new actions availability on dashboard"
  task send_notifications: :environment do
    Proposal.not_archived.each do |proposal|
      new_actions_ids = Dashboard::Action.detect_new_actions_since(Date.yesterday, proposal)

      if new_actions_ids.present?
        if proposal.published?
          Dashboard::Mailer.delay.new_actions_notification_rake_published(proposal,
                                                                    new_actions_ids)
        else
          Dashboard::Mailer.delay.new_actions_notification_rake_created(proposal,
                                                                  new_actions_ids)
        end
      end
    end
  end

  desc "Basic templates with Dashboard::Actions recommended"
  task create_basic_dashboard_actions_template: :environment do
    Dashboard::Action.create(title: "Kit di diffusione",
                             description: "<p>Hai qui a disposizione un manuale che ti può aiutare nel diffondere la tua "\
                             "proposta e nel far sì che abbia il maggior successo possibile. È fondamentale "\
                             "seguire la proposta per sostenerla. Questo documento ti aiuta a "\
                             "tenere una strategia corretta nella comunicazione. È possibile scaricarlo in formato "\
                             "pdf, oppure lo si può leggere online.</p>\r\n",
                             request_to_administrators: false,
                             day_offset: 1,
                             required_supports: 0,
                             order: 1,
                             active: true,
                             action_type: 1,
                             short_description: "Manuale per progettare la strategia di comunicazione",
                             published_proposal: false)
    Dashboard::Action.create(title: "Parla prima con familiari e amici",
                             description: "<p>Racconta loro la tua proposta, chiedi consiglio e, una volta "\
                             "pubblicata la proposta, invitali a condividerla sui social networks. "\
                             "Saranno loro i primi propulsori della tua campagna.</p>\r\n",
                             request_to_administrators: false,
                             day_offset: 0,
                             required_supports: 0,
                             order: 2,
                             active: true,
                             action_type: 0,
                             short_description: "Saranno loro il tuo primo e più importante appoggio",
                             published_proposal: false)
    Dashboard::Action.create(title: "Fai sì che la tua campagna abbia la migliore immagine",
                             description: "<p>L'abbinare una fotografia o un video alla tua proposta "\
                             "porta un numero di appoggi fino a 6 volte superiore rispetto alle proposte che ne sono "\
                             "sprovvisti! È fondamentale scegliere la miglior immagine possibile e, "\
                             "ancor meglio, se l'immagine ritrae le persone coinvolte dalla proposta! "\
                             "Inoltre, qui ti riportiamo alcuni consigli più tecnici da applicare "\
                             "nella scelta della foto. "\
                             "Segui i consigli e vedrai il risultato:<br />\r\n- Le foto di animali e di "\
                             "persone funzionano di più.<br />\r\n- Le foto grandi "\
                             "hanno una resa migliore, però - attenzione - l'immagine può avere una dimensione massima di 1Mb! "\
                             "<br />\r\n- La foto deve essere generica "\
                             "e non deve avere contenuto specifico.</p>\r\n",
                             request_to_administrators: false,
                             day_offset: 0,
                             required_supports: 0,
                             order: 0,
                             active: true,
                             action_type: 0,
                             short_description: "",
                             published_proposal: false)
    Dashboard::Action.create(title: "Scegli un titolo corto, forte e che richiami l'attenzione",
                             description: "<p>È importante andare al sodo. Fai partecipi tutti "\
                             "della tua proposta. Concentrati sulla soluzione, sul beneficio o su "\
                             "quello che si deve risolvere. Assegna un'indicazione geografica alla tua proposta cittadina. "\
                             "Qui di seguito trovi alcuni esempi per la scelta del titolo della tua "\
                             "proposta:<br />\r\n- 'Vogliamo San Salvario pulito e "\
                             "vivibile'<br />\r\n- 'No alla chiusura dei  "\
                             "Murazzi'<br />\r\n- 'Stop all'immondizia in Borgo Filadelfia' "\
                             "<br />\r\n- 'Più contenitori per il vetro in Barriera di Milano' "\
                             "<br />\r\n- 'Sistemazione della postazione del bike sharing di Via Montevideo "\
                             "'</p>\r\n",
                             request_to_administrators: false,
                             day_offset: 0,
                             required_supports: 0,
                             order: 1,
                             active: true,
                             action_type: 0,
                             short_description: "Sii conciso e diretto per far sì che la tua proposta "\
                             "sia compresa immediatamente",
                             published_proposal: false)
    Dashboard::Action.create(title: "Esprimi sempre il tuo ringraziamento",
                             description: "<p>Sia che ti venga offerto l'appoggio sia che ti venga negato, "\
                             "ringrazia sempre. Inoltre, il mostrare la tua gratitudine servirà per "\
                             "creare una comunicazione nuova che potrebbe attrarre altre persone "\
                             "verso la tua proposta e, di conseguenza, aumentarne gli appoggi.</p>\r\n",
                             request_to_administrators: false,
                             day_offset: 3,
                             required_supports: 0,
                             order: 5,
                             active: true,
                             action_type: 0,
                             short_description: "È un buon modo di ottenere appoggi in futuro",
                             published_proposal: false)
    Dashboard::Action.create(title: "Raccontalo di persona ai tuoi amici",
                             description: "<p>Prima della pubblicazione, organizza un evento con i tuoi "\
                             "amici, familiari, colleghi di lavoro... Riunisci "\
                             "tutti attorno ad un tavolo, "\
                             "descrivi loro la tua proposta e invitali a partecipare e a migliorarla. "\
                             "Questo consiglio è facilmente abbinabile alla creazione dei sondaggi "\
                             "precedenti la pubblicazione della proposta. Puoi "\
                             "sviluppare i sondaggi per questi incontri e poi dibattere delle "\
                             "conclusioni, oppure far rispondere alle domande durante le riunioni stesse, "\
                             "fai come meglio credi.</p>\r\n",
                             request_to_administrators: false,
                             day_offset: 4,
                             required_supports: 0,
                             order: 6,
                             active: true,
                             action_type: 0,
                             short_description: "Crea un incontro per condividere la tua proposta.",
                             published_proposal: false)
    Dashboard::Action.create(title: "Crea un sondaggio personalizzato",
                             description: "<p>I sondaggi servono per risolvere i dubbi, domandare "\
                             "l'opinione, migliorare la proposta ed anche per creare una comunità "\
                             "intorno alla quale fare crescere la proposta in termini di appoggi, dopo averla "\
                             "conclusa, affinata e "\
                             "pubblicata.<br />\r\n<br />\r\nQuesta idea è facilmente abbinabile "\
                             "all'organizzazione di un incontro o di un evento che serva ad illustrare a "\
                             "tutti i tuoi contatti, amici e familiari la proposta e "\
                             "l'importanza che riveste l'appoggiarla per poter raggiungere "\
                             "gli obbiettivi prefissati.</p>\r\n",
                             request_to_administrators: false,
                             day_offset: 5,
                             required_supports: 0,
                             order: 7,
                             active: true,
                             action_type: 0,
                             short_description: "Domanda ciò che vuoi a proposito della proposta",
                             published_proposal: false)
    Dashboard::Action.create(title: "Coinvolgi nel tuo proposito le attività commerciali del tuo quartiere",
                             description: "<p>Se pensi che la tua proposta possa influenzare direttamente "\
                             "le attività commerciali del quartiere e possa, in qualche maniera, contribuire a migliorarne la situazione, "\
                             "mettiti in contatto con i proprietari o con i gestori delle attività "\
                             "e racconta loro la tua proposta affinché "\
                             "ti aiutino ad ottenere voti. Insieme a te, anche loro vinceranno!</p>\r\n",
                             request_to_administrators: false,
                             day_offset: 7,
                             required_supports: 0,
                             order: 10,
                             active: true,
                             action_type: 0,
                             short_description: "Hai pensato di parlarne ai bar o "\
                             "alle attività commerciali che frequenti di più?",
                             published_proposal: false)
    Dashboard::Action.create(title: "Includi gli hashtags nei tuoi post",
                             description: "<p>L'hashtag è uno strumento indispensabile per "\
                             "aumentare la partecipazione e gli appoggi. Lo si usa principalmente "\
                             "su Twitter, però anche Facebook, Instagram, Pinterest o Google+ "\
                             "dispongono di questa opzione. Ti consigliamo di usare, nei tuoi post, "\
                             "gli stessi hashtags per poter creare, "\
                             "su di essi, il tuo contenuto. Fai una ricerca o chiedi "\
                             "aiuto per sapere quali usare e quali sono inerenti la tua proposta. "\
                             "Qui di seguito riportiamo alcuni esempi o idee di "\
                             "hashtags centrati su diversi ambiti sociali che potrebbero "\
                             "andare bene. Però l'ideale è quello di usarne di altri più "\
                             "pertinenti al tema della tua proposta.<br /></p>\r\n",
                             request_to_administrators: false,
                             day_offset: 6,
                             required_supports: 0,
                             order: 9,
                             active: true,
                             action_type: 0,
                             short_description: "L'impiego degli hashtags ti consentirà di arrivare a più gente",
                             published_proposal: false)
    Dashboard::Action.create(title: "Coinvolgi nel tuo proposito le ONG o i centri sociali del tuo quartiere",
                             description: "<p>Se pensi che la tua proposta possa influenzare direttamente il "\
                             "miglioramento della qualità della vita delle persone che vivono nel tuo quartiere "\
                             "o località, comprese quelle con meno risorse finanziarie, ed i gruppi di persone "\
                             "più svantaggiate o a rischio di esclusione sociale, mettiti in contatto con "\
                             "le ONG ed i Centri Sociali presenti sul territorio e racconta loro "\
                             "la tua proposta perché ti aiutino ad ottenere voti. Saranno felicissimi "\
                             "di collaborare!</p>\r\n",
                             request_to_administrators: false,
                             day_offset: 7,
                             required_supports: 0,
                             order: 11,
                             active: true,
                             action_type: 0,
                             short_description: "Racconta la tua proposta a tutti i potenziali "\
                             "interessati",
                             published_proposal: false)
    Dashboard::Action.create(title: "Conosci qualche influencer?",
                             description: "<p>Un 'influencer' è un individuo seguito da "\
                             "numerose persone sui suoi canali social. Per questo motivo, se ne "\
                             "conosci uno o sei amico di qualcuno che utilizza attivamente i suoi "\
                             "profili social per ricavarne un certo tornaconto, "\
                             "hai la grande opportunità di descrivergli la tua proposta e "\
                             "di chiedergli di aiutarti a diffonderla condividendola sui suoi social "\
                             "networks.</p>\r\n",
                             request_to_administrators: false,
                             day_offset: 8,
                             required_supports: 0,
                             order: 12,
                             active: true,
                             action_type: 0,
                             short_description: "Raccontagli la tua proposta e ottieni l'appoggio suo e dei suoi "\
                             "follower",
                             published_proposal: false)
    Dashboard::Action.create(title: "Chiedi gli appoggi di persona",
                             description: "<p>Anche se abbiamo a portata di mano mezzi capaci di "\
                             "giungere in un istante a centinaia e a migliaia di persone, nulla funziona "\
                             "meglio di chiedere l'appoggio di persona. È 34 volte più efficace rispetto "\
                             "alla richiesta via email!</p>\r\n",
                             request_to_administrators: false,
                             day_offset: 1,
                             required_supports: 0,
                             order: 3,
                             active: true,
                             action_type: 0,
                             short_description: "È 34 volte più efficace rispetto alla richiesta via email!",
                             published_proposal: false)
    Dashboard::Action.create(title: "Prepara i tuoi messaggi per i social networks",
                             description: "<p>Crea un piccolo calendario di post "\
                             "settimanali in Facebook e/o Twitter (è sufficiente tre alla settimana "\
                             "per i primi mesi). Usa immagini nelle quali compari "\
                             "tu mentre chiedi l'appoggio o immagini che riconducono al "\
                             "progetto. E soprattutto: utilizza un linguaggio semplice, diretto quando "\
                             "chiedi l'appoggio e sempre con messaggi personalizzati "\
                             "se sono indirizzati - privatamente - ai tuoi contatti. È "\
                             "importante che si sentano partecipi e non un numero in più nella tua "\
                             "raccolta degli appoggi.</p>\r\n",
                             request_to_administrators: false,
                             day_offset: 2,
                             required_supports: 0,
                             order: 4,
                             active: true,
                             action_type: 0,
                             short_description: "È molto importante sapere cosa dirai e come",
                             published_proposal: false)
    Dashboard::Action.create(title: "Fai conoscere i tuoi piani prima della pubblicazione",
                             description: "<p>Non è necessario disporre della proposta completamente creata "\
                             "o già pubblicata per iniziare a parlarne. Di fatto, "\
                             "ti consigliamo di creare alcuni post nei tuoi social network e "\
                             "di iniziare a discuterne con i tuoi amici e con i tuoi familiari prima che veda la "\
                             "luce. È quella che viene definita una campagna 'teaser' e serve per creare "\
                             "aspettativa su di un qualcosa che arriverà molto presto.<br />\r\n "\
                             "<br />\r\nTi consigliamo di includere messaggi di questo "\
                             "tipo nei post che pubblicherai sui social networks. In pratica, puoi "\
                             "copiare questi testi e usarli come desideri:<br />\r\n- 'Molto "\
                             "presto creerò una proposta per migliorare la "\
                             "città di Torino, e più che mai avrò bisogno del vostro appoggio. "\
                             "Continuerò ad informarvi da qui. Molte grazie a tutti'<br />\r\n- "\
                             "Questo è un messaggio per tutti coloro a cui importano "\
                             "la propria città, il proprio quartiere e il nostro futuro. Voglio migliorare Torino con "\
                             "una proposta che molto presto vi farò arrivare perché, "\
                             "uniti, la si possa realizzare. Grazie a tutti!</p>\r\n",
                             request_to_administrators: false,
                             day_offset: 6,
                             required_supports: 0,
                             order: 8,
                             active: true,
                             action_type: 0,
                             short_description: "Tutti sui social networks devono sapere che "\
                             "presto darai alla luce la tua proposta.",
                             published_proposal: false)
    Dashboard::Action.create(title: "Condivi la tua proposta sui gruppi Facebook",
                             description: "<p>È fondamentale ricercare dovunque l'appoggio "\
                             "di cui hai bisogno. Anche le comunità ed i gruppi (privati "\
                             "o aperti) di Facebook a Torino sono un buon luogo dove "\
                             "cercare nuovi appoggi e alleati nel cammino verso la "\
                             "meta.<br />\r\n<br />\r\nPer questo, cerca e seleziona bene "\
                             "quelle comunità e gruppi presenti su Facebook che sono più "\
                             "affini alla natura della tua proposta. Per esempio, se la tua "\
                             "proposta verte su 'migliorare un parco pubblico', sicuramente "\
                             "potrai trovare supporto in ciclisti, gruppi di "\
                             "runners, collettivi e persone adiacenti al parco, etc. "\
                             "Chiedi di unirti a loro, e una volta dentro, pubblica lì la tua "\
                             "proposta corredandola di informazioni e chiedendo - educatamente - ai membri del gruppo "\
                             "l'appoggio nel miglioramento della città. Tieni presente sempre "\
                             "come focalizzare il tuo messaggio per renderlo appropriato al gruppo - "\
                             "e ai relativi interessi - nel quale pubblichi i post. Pensa che alla fine si "\
                             "tratta di ottenere appoggi da persone sconosciute che, da par loro, "\
                             "devono comprendere quale è il beneficio che si ottiene aiutandoti. "\
                             "E per certo, in nessun caso, la tua richiesta deve essere intrusiva o "\
                             "percepita come 'spam', ragion per cui devi avere tatto nel chiedere "\
                             "gli appoggi.</p>\r\n",
                             request_to_administrators: false,
                             day_offset: 9,
                             required_supports: 0,
                             order: 13,
                             active: true,
                             action_type: 0,
                             short_description: "Sai a quante persone potresti arrivare "\
                             "con questi gruppi?",
                             published_proposal: false)
    Dashboard::Action.create(title: "Dai un'occhiata più da vicino ad altre proposte",
                             description: "<p>Può sembrare ovvio ma assicurati di farlo. "\
                             "Prima che la tua proposta veda la luce, guarda come l'hanno fatto "\
                             "gli altri cittadini e cittadine quando hanno creato la loro: "\
                             "fotografia, messaggi, titolo... Ce ne saranno alcune che ti piacciono di più e altre "\
                             "e di meno, alcune esposte meglio e altre peggio; devi analizzarle e ricavare "\
                             "il meglio di ognuna per poi impiantarlo nella tua.<br /> "\
                             "\r\n<br />\r\nQui di seguito trovi alcuni esempi di quelle ora in evidenza "\
                             "perché tu possa vedere come hanno fatto. Se loro sono riusciti "\
                             "ad ottenere gli appoggi necessari o sono sul punto di raggiungerli, anche tu puoi!",
                             request_to_administrators: false,
                             day_offset: 10,
                             required_supports: 0,
                             order: 14,
                             active: true,
                             action_type: 0,
                             short_description: "Prima di pubblicare la tua proposta, guarda come "\
                             "l'hanno fatto gli altri",
                             published_proposal: false)
    Dashboard::Action.create(title: "Usa Whatsapp per la diffusione",
                             description: "<p>I tuoi amici, la tua famiglia, i tuoi vicini "\
                             "daranno il loro appoggio affinché la tua proposta sia compiuta. Non dimenticare di copiare "\
                             "il link della tua proposta e di includerlo nel testo del messaggio, servirà ai destinatari per "\
                             "giungere velocemente alla proposta e poterla così appoggiare! Condividilo su tutti i tuoi gruppi, "\
                             "mandalo con messaggi personali a tutti i tuoi contatti e "\
                             "otterrai risultati più rapidamente!</p>\r\n",
                             request_to_administrators: false,
                             day_offset: 0,
                             required_supports: 0,
                             order: 17,
                             active: true,
                             action_type: 0,
                             short_description: "Whatsapp o Telegram sono grandi "\
                             "strumenti per ottenere appoggi immediati.",
                             published_proposal: true)
    Dashboard::Action.create(title: "Usa i social networks",
                             description: "<p>Già nella fase precedente la campagna ti invitiamo a "\
                             "impiegare i social networks, sono il mezzo migliore per arrivare al numero "\
                             "massimo di persone! Inoltre, ti abbiamo anche fornito un KIT di "\
                             "immagini da usare nella diffusione della tua proposta. Di più adesso "\
                             "ti suggeriamo di copiare ed incollare il link della tua "\
                             "proposta sui tuoi profili social per consentire alla gente di "\
                             "accedere e di appoggiarti.</p>\r\n",
                             request_to_administrators: false,
                             day_offset: 0,
                             required_supports: 0,
                             order: 16,
                             active: true,
                             action_type: 0,
                             short_description: "Copia e incolla il link della tua proposta sui "\
                             "tuoi profili social.",
                             published_proposal: true)
    Dashboard::Action.create(title: "Continua a chiedere supporto a nuovi ambasciatori della tua proposta",
                             description: "<p>La tua proposta di miglioramento della città potrebbe anche migliorare "\
                             "la vita di molte persone incluso quelle che "\
                             "gestiscono bar e attività commerciali, o quelle che aiutano gli altri "\
                             "come le ONG, i Centri Sociali, le Associazioni di Vicinato... Pensa a "\
                             "chi potrebbe interessare appoggiare la tua proposta, descrivigli tutto nel "\
                             "dettaglio e vedrai che otterrai più appoggi di quelli che "\
                             "speravi!</p>\r\n",
                             request_to_administrators: false,
                             day_offset: 1,
                             required_supports: 0,
                             order: 18,
                             active: true,
                             action_type: 0,
                             short_description: "Negozi, imprese locali, Centri Sociali, "\
                             "collettivi...",
                             published_proposal: true)
    Dashboard::Action.create(title: "Chiedi che ti lascino appendere manifesti",
                             description: "<p>Sicuramente sei in buoni rapporti con i proprietari/responsabili di "\
                             "imprese, attività commerciali, negozi, centri sociali e civili, "\
                             "associazioni... del tuo quartiere. Chiedi loro il permesso di affiggere, nei "\
                             "loro locali e nelle loro strutture, il manifesto della tua proposta "\
                             "per permettere a tutti coloro che passano di lì di sostenerla e di diffonderla presso "\
                             "altre persone!<br />\r\n<br />\r\nA tal fine, puoi dirlo "\
                             "di persone o ricorrere alla nuove risorse. Una volta ottenuti gli "\
                             "appoggi necessari (se non li hai già), vedrai che abbiamo messo a tua "\
                             "disposizione una risorsa 'Manifesto' che puoi "\
                             "scaricare e stampare, o stampare direttamente da questo "\
                             "strumento. Una volta nelle tue mani, chiedi permesso e appendilo in "\
                             "luoghi differenti perché quelli che transitano di lì possano venire a conoscenza "\
                             "della tua proposta ed entrare nel portale per appoggiarti.</p>\r\n",
                             request_to_administrators: false,
                             day_offset: 1,
                             required_supports: 0,
                             order: 19,
                             active: true,
                             action_type: 0,
                             short_description: "Immagini la tua proposta visibile ovunque?",
                             published_proposal: true)
    Dashboard::Action.create(title: "Applica le azioni che hai in sospeso",
                             description: "<p>È il momento di fare un passo avanti nella sequenza delle azioni "\
                             "che ti abbiamo suggerito quando la tua proposta era in bozza. Se non "\
                             "le ricordi è il momento di rivederle con attenzione. Il "\
                             "primo giorno della campagna è molto importante. La tua proposta si trova "\
                             "fra quelle di nuova pubblicazione, e per questo oggi ha maggior risalto: approfittane "\
                             "e diffondi! </p>\r\n",
                             request_to_administrators: false,
                             day_offset: 0,
                             required_supports: 0,
                             order: 15,
                             active: true,
                             action_type: 0,
                             short_description: "Troverai tutte le azioni nella pagina "\
                             "\"Azioni consigliate\" nel Pannello della Proposta. Ricorda "\
                             "di usarle frequentemente per raccogliere nuovi appoggi.",
                             published_proposal: true)
    Dashboard::Action.create(title: "Chiedi alla gente che ti sta vicino di condividere la tua proposta",
                             description: "<p>Quanta più gente conosce la tua proposta, meglio è! Non "\
                             "vergognarti di chiedere ai tuoi amici, familiari e contatti di "\
                             "condividere essi stessi la tua iniziativa sui loro social networks. "\
                             "L'unione fa la forza!<br />\r\n<br />\r\nTi abbiamo già invitato "\
                             "ad usare i social networks nella fase precedente la campagna, sono il mezzo migliore "\
                             "per arrivare al numero massimo di persone! Inoltre, ti abbiamo anche fornito "\
                             "un KIT di immagini per la diffusione della tua proposta. E, se "\
                             "lo desideri, puoi dare il KIT ai tuoi amici, familiari e contatti "\
                             "perché pubblichino le immagini e catturino appoggi per te attraverso i loro "\
                             "profili personali.<br />\r\n </p>\r\n",
                             request_to_administrators: false,
                             day_offset: 3,
                             required_supports: 0,
                             order: 21,
                             active: true,
                             action_type: 0,
                             short_description: "Chiedi loro che la diffondano sui loro social networks",
                             published_proposal: true)
    Dashboard::Action.create(title: "I tuoi vicini sono un'ottima comunità a cui chiedere supporto",
                             description: "<p>Il luogo dove vivi è il posto adatto per "\
                             "ottenere supporto dal momento che conosci i tuoi vicini e puoi chiedere loro "\
                             "di aiutarti.<br />\r\n "\
                             "<br />\r\nA tal fine, lo si può dire di persona, oppure affiggendo un "\
                             "manifesto nell'androne o, ancora, convocando una riunione a casa tua per coloro "\
                             "che sono interessati. Vedrai che hai a disposizione la risorsa 'Manifesto ' da "\
                             "scaricare e stampare. Se è necesario, aiutali a "\
                             "registrarsi sul portale DecidiTorino. Se hai convocato "\
                             "una riunione a casa tua, con un PC, "\
                             "un tablet o uno smartphone connessi ad Internet, puoi dar loro una mano a "\
                             "registrarsi come nuovi utenti, e poi ad appoggiare la proposta.</p>\r\n\r\n<p> </p>\r\n",
                             request_to_administrators: false,
                             day_offset: 4,
                             required_supports: 0,
                             order: 22,
                             active: true,
                             action_type: 0,
                             short_description: "Lascia un manifesto nell'androne o convoca una riunione",
                             published_proposal: true)
    Dashboard::Action.create(title: "Stampa la tua proposta e distribuiscila",
                             description: "<p>Stai chiedendo il loro appoggio ed è normale che vogliano avere "\
                             "più informazioni. Sulle prime è meglio non chiedere "\
                             "troppo. Fai qualche copia del sommario della tua proposta, "\
                             "e consegnala a coloro che ipotizzi possano essere interessati. Le persone sono solite "\
                             "interessarsi ed appoggiare le cose che hanno carattere serio e "\
                             "ponderato. A tal proposito, ti suggeriamo di scrivere un sunto della tua proposta "\
                             "e di stamparlo in diverse copie da dare alle persone maggiormente "\
                             "interessate, che potranno leggerlo a casa con tranquillità e capire "\
                             "di cosa si tratta realmente.</p>\r\n",
                             request_to_administrators: false,
                             day_offset: 2,
                             required_supports: 0,
                             order: 20,
                             active: true,
                             action_type: 0,
                             short_description: "La gente ha maggiore fiducia quando dispone di sufficiente "\
                             "informazione",
                             published_proposal: true)
    Dashboard::Action.create(title: "Crea biglietti da visita adattandoli per "\
                             "diffondere la tua proposta",
                             description: "<p>Sai quanto costa stampare 500 biglietti da visita per "\
                             "presentare la tua proposta e catturare subito nuovi appoggi? "\
                             "Una simile quantità di biglietti da visita ha un prezzo a partire da € 7,25. Stampa "\
                             "i biglietti su un sito Internet o in una "\
                             "copisteria, e chiedi aiuto a tutti per la distribuzione: "\
                             "amici e familiari, vicini di casa, colleghi di lavoro, gente del "\
                             "quartiere... a chi vuoi tu! Non importa che tu non conosca la "\
                             "gente a cui richiedi il supporto per la tua proposta, chi meno "\
                             "te l'aspetti ti può aiutare! Però devi fare le cose facili: "\
                             "sul biglietto da visita precisa il titolo e l'identificativo della tua proposta, "\
                             "il link del sito web www.deciditorino.it ed il tuo nome, e non dimenticare di "\
                             "chiedere a tutti/e che non si limitino a visitare la pagina ma anche a darti "\
                             "il loro appoggio!</p>\r\n",
                             request_to_administrators: false,
                             day_offset: 5,
                             required_supports: 0,
                             order: 23,
                             active: true,
                             action_type: 0,
                             short_description: "È un modo diretto e differente di arrivare a "\
                             "più gente",
                             published_proposal: true)
    Dashboard::Action.create(title: "Chiedi appoggio sul posto di lavoro",
                             description: "<p>Sentiti libero di far loro conoscere la creazione della "\
                             "tua proposta e la necessità, da parte loro, di sostenerla per "\
                             "trasformarla in realtà. Troverai in loro una enorme fonte "\
                             "di supporto che può diventare più ampia se la proposta "\
                             "ha diffusione nei loro ambienti personali, per questo vale la pena "\
                             "concentrare lo sforzo in un solo giorno per non risultare troppo "\
                             "insistente. <br />\r\n<br />\r\nA tal fine, puoi comunicare "\
                             "di persona la motivazione che ti porta a pubblicare la proposta "\
                             "o puoi spiegarlo in gruppo nei momenti di pausa. Fatti anche dare dal tuo/a capo/a "\
                             "il permesso di inviare una email a tutti i colleghi di lavoro per chiedere "\
                             "l'appoggio. Puoi usare i biglietti da visita o il manifesto che conosci già. "\
                             "Se te lo concedono, appendi il manifesto in diversi "\
                             "luoghi come l'entrata del bagno, l'area caffè... </p>\r\n",
                             request_to_administrators: false,
                             day_offset: 6,
                             required_supports: 0,
                             order: 24,
                             active: true,
                             action_type: 0,
                             short_description: "Appoggiati ai tuoi colleghi e colleghe di "\
                             "lavoro, sono decisivi!",
                             published_proposal: true)
    Dashboard::Action.create(title: "Manuale Dieci chiavi",
                             description: "<p>Al momento la tua proposta è ancora in "\
                             "bozza, quindi puoi leggere questo riassunto che "\
                             "illustra come pubblicare una proposta e iniziare la raccolta "\
                             "degli appoggi. Sebbene tu abbia già compiuto alcuni dei passi che elenca "\
                             "questo artico, come per esempio quello per la creazione di un account, ce ne sono "\
                             "molti altri che ti possono tornare utili per i suggerimenti presenti. "\
                             "È il caso dei consigli per migliorare la stesura o "\
                             "con quali file potresti integrare i dati che stai "\
                             "immettendo nel form. Dacci uno sguardo!</p>\r\n",
                             request_to_administrators: true,
                             day_offset: 0,
                             required_supports: 0,
                             order: 0,
                             active: true,
                             action_type: 1,
                             short_description: "Consigli precedenti la pubblicazione",
                             published_proposal: false)
    Dashboard::Action.create(title: "Mailing massivo",
                             description: "",
                             request_to_administrators: true,
                             day_offset: 0,
                             required_supports: 8000,
                             order: 7,
                             active: true,
                             action_type: 1,
                             short_description: "",
                             published_proposal: true)
    Dashboard::Action.create(title: "Pillola video",
                             description: "",
                             request_to_administrators: false,
                             day_offset: 0,
                             required_supports: 15000,
                             order: 8,
                             active: true,
                             action_type: 1,
                             short_description: "",
                             published_proposal: true)
    Dashboard::Action.create(title: "Immagini per i tuoi profili",
                             description: "<p>Alcuni esempi per darti ispirazione o da inserire nei "\
                             "profili dei tuoi social networks. Si tratta di sostituire "\
                             "temporaneamente l'immagine associata al tuo utente o il banner generale "\
                             "proprio dello spazio del profilo, inserendone un'altra nella quale si pubblicizza "\
                             "la proposta presente in www.deciditorino.it e la ricerca di appoggi associata. Puoi impiegare "\
                             "uno di quelli presenti, oppure creare lo slogan che più ti piace e che cambierai "\
                             "di frequente. È una azione semplice, con poco sforzo da parte tua, "\
                             "e sarà vista da tutte le persone "\
                             "che ti conoscono.</p>\r\n",
                             request_to_administrators: false,
                             day_offset: 1,
                             required_supports: 0,
                             order: 2,
                             active: true,
                             action_type: 1,
                             short_description: "Esempio di inserimento sui tuoi Social Networks",
                             published_proposal: true)
    Dashboard::Action.create(title: "Menzione sui Social Networks del Comune",
                             description: "",
                             request_to_administrators: true,
                             day_offset: 0,
                             required_supports: 1000,
                             order: 3,
                             active: true,
                             action_type: 1,
                             short_description: "Una diffusione specifica sui canali "\
                                                "del Comune",
                             published_proposal: true)
    Dashboard::Action.create(title: "Decidi Corner",
                             description: "",
                             request_to_administrators: true,
                             day_offset: 0,
                             required_supports: 1500,
                             order: 4,
                             active: true,
                             action_type: 1,
                             short_description: "",
                             published_proposal: true)
    Dashboard::Action.create(title: "1 giorno sul portale",
                             description: "",
                             request_to_administrators: true,
                             day_offset: 0,
                             required_supports: 2500,
                             order: 5,
                             active: true,
                             action_type: 1,
                             short_description: "",
                             published_proposal: true)
    Dashboard::Action.create(title: "Annuncio su Facebook",
                             description: "",
                             request_to_administrators: true,
                             day_offset: 0,
                             required_supports: 5000,
                             order: 6,
                             active: true,
                             action_type: 1,
                             short_description: "",
                             published_proposal: true)
  end

end
