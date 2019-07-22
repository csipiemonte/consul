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
                             description: "<p>Qui hai a disposizione un manuale che ti può aiutare nel diffondere la tua "\
                             "proposta e nel far sì che abbia il maggior successo possibile. È fondamentale "\
                             "seguire la proposta per sostenerla. Questo documento aiuta a "\
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
                             description: "<p>L'inserire una fotografia o un video alla tu proposta "\
                             "porta un numero di appoggi fino a 6 volte superiore rispetto alle proposte che ne sono "\
                             "sprovvisti! È fondamentale scegliere la miglior immagine possibile e, "\
                             "ancor meglio, se l'immagine ritrae le persone coinvolte nella proposta! "\
                             "Inoltre, qui ti riportiamo alcuni consigli più tecnici da applicare "\
                             "nella scelta della foto per la tua proposta. "\
                             "Segui i consigli e vedrai il risultato:<br />\r\n- Le foto di animali e di "\
                             "persone funzionano di più.<br />\r\n- Le foto grandi "\
                             "hanno una resa migliore, però - attezione - l'immagine può avere una dimensione massima di 1Mb! "\
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
                             "Qui di seguito trovi alcuni esempi che puoi seguire nella scelta del titolo per la tua "\
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
                             short_description: "Sii conciso e diretto affinché la tua proposta "\
                             "si comprenda immediatamente",
                             published_proposal: false)
    Dashboard::Action.create(title: "Esprimi sempre il tuo ringraziamento",
                             description: "<p>Sia che ti venga offerto l'appoggio sia che ti venga negato, "\
                             "ringrazia sempre. Inoltre, il mostrare la tua gratitudine servirà per "\
                             "creare una comunicazione nuova che potrebbe attrarre altre persone "\
                             "verso la tua proposta e, per conseguenza, aumentarne gli appoggi.</p>\r\n",
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
    Dashboard::Action.create(title: "Crea un sondaggio personalizato",
                             description: "<p>I sondaggi servono per risolvere i dubbi, chiedere "\
                             "l'opinione, migliorare la proposta ed anche per creare una comunità "\
                             "intorno alla quale fare crescere la proposta in termini di appoggi, dopo averla "\
                             "conclusa, affinata e "\
                             "pubblicata.<br />\r\n<br />\r\nQuesta idea è facilmente abbinabile "\
                             "all'organizzazione di un incontro o di un evento che serve per illustrare a "\
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
                             "le attività commerciali del quartiere e possa in qualche maniera contribuire la migliorarne la situazione, "\
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
                             "aiuto per sapere quali usare e quali sono inerenti alla tua proposta. "\
                             "Qui di seguito riportiamo alcuni esempi o idee di "\
                             "hashtags centrati su diversi ambiti sociali che potrebbero "\
                             "andare bene per la tua proposta. Però l'ideale è quello di usarne di altri più "\
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
                             "miglioramento della qualità della vita delle persone che vivono le tuo quartiere "\
                             "o località, comprese quelle con meno risorse finanziarie ed i gruppi di persone "\
                             "più svantaggiati o a rischio di esclusione sociale, mettiti in contatto con "\
                             "le ONG ed i Centri Sociali vicini sul territorio e racconta loro "\
                             "la tua proposta perché ti aiutino ad ottenere voti. Saranno felicissimi "\
                             "di collaborare!</p>\r\n",
                             request_to_administrators: false,
                             day_offset: 7,
                             required_supports: 0,
                             order: 11,
                             active: true,
                             action_type: 0,
                             short_description: "Racconta la tua proposta a tutti coloro a cui potrebbe "\
                             "interessare",
                             published_proposal: false)
    Dashboard::Action.create(title: "Conosci qualche influencer?",
                             description: "<p>Un 'influencer' è un individuo che ha "\
                             "numerose persone che lo seguono sui canali social. Per questo motivo, se ne "\
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
                             "meglio che chiedere l'appoggio di persona. È 34 volte più efficace rispetto "\
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
    Dashboard::Action.create(title: "Segnala i tuoi piani prima della pubblicazione",
                             description: "<p>Non è necessario disporre della proposta completamente creata "\
                             "o già pubblicata per iniziare a parlarne. Di fatto, "\
                             "ti consigliamo di creare alcuni post nei tuoi social network e "\
                             "di iniziare a discuterne con i tuoi amici e con i tuoi familiari prima che veda la "\
                             "luce. È quella che viene definita una campagna 'teaser' e serve per creare "\
                             "aspettativa su di un qualcosa che arriverà molto presto.<br />\r\n "\
                             "<br />\r\nPer questo ti consigliamo di includere messaggi di questo "\
                             "tipo nei post che pubblicherai sui social ntworks. In pratica, puoi "\
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
                             "meta.<br />\r\n<br />\r\nPara ello, busca y selecciona bien "\
                             "aquellas comunidades y grupos ya creados en Facebook que son más "\
                             "afines a la naturaleza de tu propuesta. Por ejemplo si tu "\
                             "propuesta versa sobre 'mejorar un parque público', seguramente "\
                             "encuentres el apoyo que necesitas en ciclistas, grupos de "\
                             "running, colectivos y personas cercanas al parque, etc. "\
                             "Solicita unirte a ellos, y una vez estés dentro, publica allí tu "\
                             "propuesta informándoles de ella y pidiéndoles respetuosamente, "\
                             "su apoyo en la mejora de vuestra ciudad. Ten en cuenta siempre "\
                             "cómo enfocar tu mensaje para que sea lo más acorde al grupo en el "\
                             "que publicas y a también a sus intereses. Piensa que al final se "\
                             "trata de obtener apoyos de personas que no conoces, y ella, "\
                             "también debe entender cuál es el beneficio que obtiene por "\
                             "ayudarte. Y desde luego, en ningún caso, debe percibir tu "\
                             "petición como 'spam' o intrusiva, así que ten tacto al pedir "\
                             "tus apoyos.</p>\r\n",
                             request_to_administrators: false,
                             day_offset: 9,
                             required_supports: 0,
                             order: 13,
                             active: true,
                             action_type: 0,
                             short_description: "¿Sabes a cuántas personas podrías llegar "\
                             "con estos grupos?",
                             published_proposal: false)
    Dashboard::Action.create(title: "Analiza con detenimiento otras propuestas",
                             description: "<p>Parece una obviedad pero asegúrate de hacerlo. "\
                             "Antes de que tu propuesta vea la luz, fíjate en cómo lo han hecho "\
                             "otros ciudadanos y ciudadanas a la hora de crear la suya: "\
                             "fotografía, mensajes, título... Habrá algunas que te gusten más "\
                             "y menos, mejor o peor expuestas; tú debes analizarlas y quedarte "\
                             "con lo mejor de cada una para implantarlo a la tuya propia.<br /> "\
                             "\r\n<br />\r\nAquí te dejamos estos ejemplos de las más destacadas "\
                             "hasta el momento para que veas cómo lo han hecho. ¡Si ellos han "\
                             "conseguido los apoyos necesarios o están a punto, tú también puedes!",
                             request_to_administrators: false,
                             day_offset: 10,
                             required_supports: 0,
                             order: 14,
                             active: true,
                             action_type: 0,
                             short_description: "Antes de publicar tu propuesta, mira cómo "\
                             "lo han hecho otros",
                             published_proposal: false)
    Dashboard::Action.create(title: "Utiliza whatsapp para difundir ",
                             description: "<p>¡Tus amigos, familiares, tu entorno cercano te "\
                             "apoyarán para que tu propuesta se lleve a cabo. ¡No olvides copiar "\
                             "el enlace de tu propuesta e incluirlo en tu mensaje para que "\
                             "puedan ir directamente a apoyarte! Compártelo en todos tus grupos "\
                             ", pégalo a todos tus contactos de manera personal y "\
                             "¡obtendrás resultados más rápidamente!</p>\r\n",
                             request_to_administrators: false,
                             day_offset: 0,
                             required_supports: 0,
                             order: 17,
                             active: true,
                             action_type: 0,
                             short_description: "Whatsapp o Telegram sono grandi "\
                             "strumenti per ottenere appoggi immediati.",
                             published_proposal: true)
    Dashboard::Action.create(title: "Utiliza tus redes sociales",
                             description: "<p>En la fase de precampaña ya te invitamos a "\
                             "utilizar tus redes sociales, ¡son el mejor medio para llegar al "\
                             "máximo de personas! Además, también te hemos dado un KIT de "\
                             "imágenes para que puedas comunicar tu propuesta. Ahora además, "\
                             "te aconsejamos que, directamente, copies y pegues el enlace de tu "\
                             "propuesta en tus perfiles sociales para que la gente pueda "\
                             "acceder y apoyarte.</p>\r\n",
                             request_to_administrators: false,
                             day_offset: 0,
                             required_supports: 0,
                             order: 16,
                             active: true,
                             action_type: 0,
                             short_description: "Copia y pega el enlace de tu propuesta en "\
                             "tus perfiles sociales.",
                             published_proposal: true)
    Dashboard::Action.create(title: "Continúa pidiendo apoyo a nuevos embajadores de tu propuesta",
                             description: "<p>Tu propuesta para mejorar la ciudad puede mejorar "\
                             "también la vida de muchas personas incluidas aquellas que "\
                             "regentan bares, fruterías, peluquerías, o que ayudan a otros "\
                             "como ONG's, Centros Sociales, Asociaciones de Vecinos... Piensa a "\
                             "quién podría interesarle apoyar tu propuesta, cuéntale todo con "\
                             "detalle y ¡verás cómo logras muchos más apoyos de los que "\
                             "esperabas!</p>\r\n",
                             request_to_administrators: false,
                             day_offset: 1,
                             required_supports: 0,
                             order: 18,
                             active: true,
                             action_type: 0,
                             short_description: "Comercios, negocios locales, Centros Sociales, "\
                             "Colectivos...",
                             published_proposal: true)
    Dashboard::Action.create(title: "Pide que te dejen colocar carteles",
                             description: "<p>Seguro que te llevas genial con esos dueños de "\
                             "negocios, comercios, tiendas, centros sociales y cívicos, "\
                             "asociaciones... de tu barrio. ¡Pídeles que te permitan colocar en "\
                             "sus instalaciones y locales algún cartel informando de tu propuesta "\
                             "para que todo el que pase por allí pueda apoyarte y contárselo a "\
                             "otras personas!<br />\r\n<br />\r\nPara ello, puedes decírselo "\
                             "personalmente o recurrir a los nuevos recursos. Cuando logres los "\
                             "apoyos necesarios (si no los tienes ya), verás que a tu "\
                             "disposición hemos puesto un recurso 'Póster' para que puedas "\
                             "descargarlo e imprimirlo o imprimirlo directamente desde esta "\
                             "herramienta. Una vez lo tengas, pide permiso, y pégalo en "\
                             "distintos lugares para que todo el que pase por allí puedan saber "\
                             "de tu propuesta y entrar en la plataforma para apoyarte.</p>\r\n",
                             request_to_administrators: false,
                             day_offset: 1,
                             required_supports: 0,
                             order: 19,
                             active: true,
                             action_type: 0,
                             short_description: "¿Imaginas tu propuesta visible por todas partes?",
                             published_proposal: true)
    Dashboard::Action.create(title: "Aplica las acciones que tienes pendientes",
                             description: "<p>Es hora de llevar un paso más allá las acciones "\
                             "que te aconsejamos mientras tu propuesta estaba en borrador. Si no "\
                             "las conoces es el momento de que las repases con atención. El "\
                             "primer día de campaña es muy importante. Tu propuesta, por estar "\
                             "entre las nuevas publicadas, tiene más atención hoy ¡Aprovecha "\
                             "y difunde! </p>\r\n",
                             request_to_administrators: false,
                             day_offset: 0,
                             required_supports: 0,
                             order: 15,
                             active: true,
                             action_type: 0,
                             short_description: "Encontrarás todas las acciones en la página "\
                             "de \"Acciones recomendadas\" en tu Panel de Propuesta. Recuerda "\
                             "utilizarlas habitualmente para lograr nuevos apoyos.",
                             published_proposal: true)
    Dashboard::Action.create(title: "Pide a tu gente que comparta tu propuesta",
                             description: "<p>¡Cuanta más gente conozca tu propuesta mejor! No "\
                             "te cortes en pedir a tus amigos, familiares y contactos que "\
                             "compartan ellos también tu iniciativa en sus redes sociales. ¡La "\
                             "unión hace la fuerza!<br />\r\n<br />\r\nEn la fase de precampaña "\
                             "ya te invitamos a utilizar tus redes sociales, ¡son el mejor medio "\
                             "para llegar al máximo de personas! Además, también te hemos dado "\
                             "un KIT de imágenes para que puedas comunicar tu propuesta. Y si "\
                             "quieres, también puedes pasarles a ellos este KIT para que "\
                             "publiquen las imágenes y capten apoyos para ti a través de sus "\
                             "perfiles personales.<br />\r\n </p>\r\n",
                             request_to_administrators: false,
                             day_offset: 3,
                             required_supports: 0,
                             order: 21,
                             active: true,
                             action_type: 0,
                             short_description: "Pídeles que la muevan en sus redes sociales",
                             published_proposal: true)
    Dashboard::Action.create(title: "Tus vecinos son una gran comunidad para pedir apoyo",
                             description: "<p>El lugar en el que vives es el sitio idóneo para "\
                             "pedir apoyo ya que conoces a tus vecinos y de manera personal "\
                             "puedes pedirles que te ayuden, es sencillo y efectivo.<br />\r\n "\
                             "<br />\r\nPara ello, puedes decírselo personalmente, pegar un "\
                             "cartel en tu portal o convocar una reunión en tu casa para los "\
                             "interesados. Verás que dispones del recurso  'Cartel ' para que "\
                             "puedas descargarlo e imprimirlo. Si es necesario ayúdales para "\
                             "que se hagan un usuario en la plataforma Decide. Si has convocado "\
                             "una reunión, y vienen a  tu casa o llevas contigo un ordenador, "\
                             "tableta o móvil con Internet, les puede echar una mano para que se "\
                             "registren como nuevo usuario y te apoyen.</p>\r\n\r\n<p> </p>\r\n",
                             request_to_administrators: false,
                             day_offset: 4,
                             required_supports: 0,
                             order: 22,
                             active: true,
                             action_type: 0,
                             short_description: "Deja un cartel en tu portal o convoca una reunión",
                             published_proposal: true)
    Dashboard::Action.create(title: "Imprime tu propuesta y repártela",
                             description: "<p>Estás pidiéndoles su apoyo y es normal que ellos "\
                             "te pidan más información. Lo mejor es que no les reclames demasiado "\
                             "en primera instancia. Haz unas copias del resumen de tu propuesta, "\
                             "y entrégaselas a quien consideres oportuno. Las personas solemos "\
                             "interesarnos y apoyar aquello cuyo carácter parece serio y "\
                             "meditado. Por ello, te aconsejamos que redactes tu propuesta "\
                             "brevemente e imprimas varias copias para que todos aquellos que "\
                             "deseen saber más, puedan leer en sus casas y entender con "\
                             "tranquilidad, de qué trata realmente.</p>\r\n",
                             request_to_administrators: false,
                             day_offset: 2,
                             required_supports: 0,
                             order: 20,
                             active: true,
                             action_type: 0,
                             short_description: "La gente confía más cuando tiene información "\
                             "suficiente",
                             published_proposal: true)
    Dashboard::Action.create(title: "Crea tarjetas de visita adaptándolas para "\
                             "difundir tu propuesta",
                             description: "<p>¿Sabes cuánto cuesta hacer 500 tarjetas para "\
                             "presentar tu propuesta y captar nuevos apoyos de manera inmediata? "\
                             "Esta cantidad de tarjetas puede costar a partir de 7,25€. Busca "\
                             "la página web que más confianza te dé o imprimelas en una "\
                             "copistería, y pide a todo el mundo que te ayude a distribuirlas: "\
                             "amigos y familiares, vecinos, compañeros de trabajo, gente del "\
                             "barrio... ¡a quien tú quieras! No importa que no conozcas a la "\
                             "gente a la cual solicitas el apoyo para tu propuesta, ¡quien menos "\
                             "lo esperes te puede ayudar! Pero debes ponérselo fácil, por eso: "\
                             "añade el título y el identificador de tu propuesta en la tarjeta, "\
                             "el enlace a la web decide.madrid.es y tu nombre ¡y no te olvides de "\
                             "pedirles a todos/as que te apoyen, no sólo que visiten "\
                             "el link!</p>\r\n",
                             request_to_administrators: false,
                             day_offset: 5,
                             required_supports: 0,
                             order: 23,
                             active: true,
                             action_type: 0,
                             short_description: "Es una manera directa y diferente de llegar a "\
                             "más gente",
                             published_proposal: true)
    Dashboard::Action.create(title: "Pide que te apoyen en tu trabajo",
                             description: "<p>No dudes en hacerles saber de la creación de "\
                             "tu propuesta y de la necesidad de su apoyo por su parte para "\
                             "lograr hacerla realidad. En ellos y ellas, encontrarás una fuente "\
                             "de apoyo enorme que puede extenderse más allá si logras que hablen "\
                             "de la propuesta en sus entornos personales, por eso vale la pena "\
                             "hacer el esfuerzo durante un sólo día y no resultar demasiado "\
                             "insistente. <br />\r\n<br />\r\nPara ello, puedes contarles "\
                             "personalmente la motivación que te llevó a publicar la propuesta "\
                             "o explicarlo en grupo en los momentos de descanso. También pedir "\
                             "permiso a tu jefe/a para enviar un email a todos solicitando el "\
                             "apoyo. Puedes utilizar las tarjetas de visita o el cártel que ya "\
                             "conoces. Una vez lo tengas, pide permiso, y pégalo en distintos "\
                             "lugares como la entrada del baño, la zona de descanso... </p>\r\n",
                             request_to_administrators: false,
                             day_offset: 6,
                             required_supports: 0,
                             order: 24,
                             active: true,
                             action_type: 0,
                             short_description: "Apóyate en tus compañeros y compañeras de "\
                             "trabajo, ¡son cruciales!",
                             published_proposal: true)
    Dashboard::Action.create(title: "Manual Diez claves",
                             description: "<p>En estos momentos tu propuesta aún esta en modo "\
                             "borrador, es un momento perfecto para leerte este resumen que "\
                             "trata cómo publicar una propuesta ciudadana y empezar ya a reunir "\
                             "apoyos. Aunque ya habrás superado alguno de los pasos que repasa "\
                             "este artículo, como por ejemplo hacerte usuario/a, hay muchos "\
                             "otros que te pueden muy útiles, ya que incorporan recomendaciones. "\
                             "Es el caso de los consejos para conseguir una mejor redacción o "\
                             "con qué archivos podrías complementar la información que estás "\
                             "introduciendo en el formulario. ¡Échale un vistazo!</p>\r\n",
                             request_to_administrators: true,
                             day_offset: 0,
                             required_supports: 0,
                             order: 0,
                             active: true,
                             action_type: 1,
                             short_description: "Recomendaciones antes de publicar",
                             published_proposal: false)
    Dashboard::Action.create(title: "Mailing masivo",
                             description: "",
                             request_to_administrators: true,
                             day_offset: 0,
                             required_supports: 8000,
                             order: 7,
                             active: true,
                             action_type: 1,
                             short_description: "",
                             published_proposal: true)
    Dashboard::Action.create(title: "Píldora de vídeo",
                             description: "",
                             request_to_administrators: false,
                             day_offset: 0,
                             required_supports: 15000,
                             order: 8,
                             active: true,
                             action_type: 1,
                             short_description: "",
                             published_proposal: true)
    Dashboard::Action.create(title: "Imágenes para tus perfiles",
                             description: "<p>Algunos ejemplos para inspirarte o incluir en los "\
                             "perfiles que tengas activos en redes sociales. Se trata de cambiar "\
                             "temporalmente la imágen típica de tu usuario o el banner general "\
                             "en tu espacio de perfil, por otra que anuncie que tienes una "\
                             "propuesta en decide y que buscas apoyo. Puedes utilizar alguno de "\
                             "ellos,  crear tu mismo/a el slogan que mejor te vaya e ir "\
                             "cambiandolos regularmente. Es un espacio muy agradecido ya que "\
                             "cualquier persona que te conozca lo verá sin tener que hacer "\
                             "tanto esfuerzo por tu parte.</p>\r\n",
                             request_to_administrators: false,
                             day_offset: 1,
                             required_supports: 0,
                             order: 2,
                             active: true,
                             action_type: 1,
                             short_description: "Ejemplos para incluir en tus Redes Sociales",
                             published_proposal: true)
    Dashboard::Action.create(title: "Mención en RRSS del Ayuntamiento",
                             description: "",
                             request_to_administrators: true,
                             day_offset: 0,
                             required_supports: 1000,
                             order: 3,
                             active: true,
                             action_type: 1,
                             short_description: "Una difusión específica en las redes "\
                                                "del Ayuntamiento",
                             published_proposal: true)
    Dashboard::Action.create(title: "Decide Corner",
                             description: "",
                             request_to_administrators: true,
                             day_offset: 0,
                             required_supports: 1500,
                             order: 4,
                             active: true,
                             action_type: 1,
                             short_description: "",
                             published_proposal: true)
    Dashboard::Action.create(title: "1 día en portada",
                             description: "",
                             request_to_administrators: true,
                             day_offset: 0,
                             required_supports: 2500,
                             order: 5,
                             active: true,
                             action_type: 1,
                             short_description: "",
                             published_proposal: true)
    Dashboard::Action.create(title: "Anuncio en Facebook",
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
