#import "./style.typ": style, todo, gls, gls-short

#show: style

= Introduction

#todo()[Contexte général du stage dans l'écosystème HPC (High Performance Computing),
présentation du sujet et des enjeux liés à la virtualisation et la gestion
mémoire dans ce domaine.]

#pagebreak()

= Contexte

#figure(image("./figs/ma.svg"), caption: [Historique des acquisitions]) <fig_ma>

== Présentation d'Atos

La société Atos, maison mère d'Eviden, représente près de 78 112
collaborateurs, et un chiffre d'affaire d'environ 9,5 mialliards d'euros fin
2024 @online_annual_report. La société est présente dans 71 pays. Son patronyme
Atos (Axime to Slygos) vient de la réunion en 2000 de deux @esn, Axime et
Sligos, spécialisées entre autre dans les services bancaire, l'infogérance et
l'intégration de systèmes. Sligos est notamment connu pour ses compétences
dans le domain des solutions de paiement, elle a développé dans les années 80
la "carte bleue".

Après son acquisition d'Origin durant l'année 2000, elle est rebaptisée Atos
Origin. Puis dans en 2011, elle achète à Siemens sa division "Siemens IT
Solutions & Services", le nouveau groupe s'appelle alors à nouveau Atos (Atos
Origin to Siemens) et devient un acteur de poids dans un grand nombre de
rachats d'entreprise dont : Bull, Xerox ITO, Ideal GRP, et bien d'autre (voir
@fig_ma pour un aperçu).

Cette frénésie d'achats de société externes, entre 2014 et 2016, est menée par
le président du directoire d'Atos, Thierry Breton, nommé en 2008. Les diverses
péripéties et contre perfomances de certains des domaines d'activité entraine
l'entreprise dans une descente aux enfers @online_enfer. Les journaux économiques
n'hésite pas à pointer du doigt Thierry Breton comme responsable de la chute et
de la stratégie hasardeuse du groupe @online_breton.

En 2023, Atos opére une scission interne de ses activités dans le but de
séparer les activités en déclins des autres activités rentable. La première
entité regroupe les activités historiques d'infogérances et d'infrastructure,
nommées Tech Foundations, conserve le nom Atos. La seconde entité regroupe les
activités de cloud, développement d'applications, cybersécurité et
super-caculateurs, nommées @bds, et se nomme Eviden @online_split.

== Présentation d'Eviden

Eviden qui nous concerne plus particulièrement, est une entreprise du groupe
Atos, et plus précisément de sa filiale Bull, elle se concentre sur les
activités @bds du groupe. Eviden est une entreprise important à
l'international, ainsi qu'un fort impact au niveau national. Elle travaille par
exemple avec l'état sur des question cybersécurit é et de gestion des données
dans les activités nucléaires. Le groupe se définit lui-même comme "leader
mondial dans le calcul avancé, la sécurité, l’IA, le cloud et les plateformes
numériques" @online_eviden.

Les activités @bds restent à l'écart de la chute du groupe Atos. Eviden est
directement liée au rachat de BULL en 2014, qui est alors dans le peloton de
tête des constructeurs mondiaux de supercalculateurs. Cette branche
d'activités est à la fois permformante et rentable, contrairement à la branche
infogérance d'Atos en perte de vitesse.

Ainsi, en juin 2023 Eviden a remporté un marché de 100 millions de dollars en
Inde pour la fourniture de deux supercalculateurs à l’Institut Indien de
Météorologie Tropicale @online_inde. En Janvier 2024, Eviden obtient aussi la
fourniture du datacenter modulaire pour le supercalculateur Jupiter qui sera
installé au centre de recherche de Jülich en Allemagne @online_allemagne. Il s’agira
du premier supercalculateur exascale en Europe.

Pour ces raisons, l’entité attise la convoitise d'entreprises importantes.
Pour preuve, plusieurs proposition de rachat s'enchaineront: la société Airbus
a proposé le rachat d’Eviden en 2014 (ajouter source), le milliardaire Daniel
Kretinsky a proposé le rachat de Tech Foundation en 2014 (ajouter source).
Pourtant aucune de ces négociations n'ont aboutis.

Face à cette situation, l’État français, par la voix du Ministre de
l’Économie Bruno Le Maire, a exprimé sa volonté d’acquérir 100 % des
activités stratégiques d’Atos, en particulier celles liées à la défense, à
l’énergie nucléaire et à la cybersécurité. Le Ministre a souligné qu’Atos
détient notamment des supercalculateurs utilisés dans le cadre de la
dissuasion nucléaire, ainsi que des contrats sensibles avec l’armée française
et le ministère des Armées @online_bruno.

Le 2 juin 2025, lors de l'écriture de ce rapport, une offre ferme vient d'être
négociée entre l'État et Atos. Elle concerne le rachat des activités de @hpc &
Quantique ainsi que les divisions Business Computing & Intelligence pour une
valeur d'entreprise d'environ 500 millions @online_rachat.

== Présentation de la #gls-short("nic") #gls-short("bxi")

Le #gls("hpc", long: true) est une branche de l’informatique qui se concentre
sur le développement de systèmes et d’architectures capables de fournir des
performances de calcul très élevées pour des applications qui, souvent, ne
peuvent pas être exécutées sur des machines classiques ou qui demandent un
temps de calcul trop long pour être utilisables en pratique. Des exemples
typiques sont les simulations de mécanique des fluides, les prévisions
météorologiques et climatiques, la modélisation moléculaire ou encore la
recherche en astrophysique @online_cea.

Pour arriver à cet objectif, un calcul massivement parralléle éxecute un
grands nombres de tâches en simultanés sur un ensembles de machines (appelés
#emph[noeuds]) formant ainsi un #emph[cluster]. Ce cluster, pouvant être
composé d'une dizaine jusqu'à une centaine de milliers de noeuds ou plus,
utilise un planificateur centralisé gérant la répartition et l'organisation
des tâches. La communication entre les noeuds est assurée par un réseau
d’interconnexion, les performances dans ce réseau (latence, débit) sont
cruciales pour garantir que la vitesse de calcul ne soit pas limitée. En
effet, une latence élevée ou un débit insuffisant peuvent créer des goulots
d’étranglement qui limitent les performances globales du système
@book_intro_hpc. Le passage à l’échelle est très dépendant des performances du
réseau, les contraintes sur l’interconnexion sont d’autant plus fortes lorsque
la puissance de calcul augmente.

L’arrivée à l’exascale (au delà de 1018 opérations flottantes par seconde 1) en
2022 avec la machine Frontier (#smallcaps[hpe]) @online_hpe, a été une étape
importante pour le @hpc. Eviden fait bien entendu partie de cette course et
développe dans ce cadre la version 3 de son réseau d’interconnexion appelé
@bxi. L’objectif d’Eviden avec la carte réseau @bxi est de proposer une
solution concurrente à InfiniBand @online_ib et OmniPath pour les futures
machines exascale @online_bxi.

#todo()[evoquer top 500/green 500]

L’équipe Low-Level de @bxi, au sein de laquelle s’est déroulé ce projet de fin
d'études, regroupe une dizaine d’ingénieurs. Son activité porte sur le
développement de drivers pour la nouvelle génération de cartes @bxi. Elle
travaille également sur le développement d’une implémentation de l’@api de
programmation réseau Portals @online_portals. Il s’agit d’une @api bas niveau
conçue par Sandia National Laboratories et qui est tournée vers le réseau
haute performance. Elle contient notamment les éléments de base nécessaires à
l’implémentation du standard @mpi. En parallèle, l’équipe contribue aussi au
projet Lustre (système de fichiers distribué conçu pour le passage à
l’échelle) @online_lustre.

== Présentation de #gls-short("qemu")

@qemu est un logiciel libre et Open-Source très largement utilisé pour
l’émulation ou la virtualisation en collaboration avec des outils tels que
#smallcaps[kvm]. Associé à Libvirt, @qemu permet de facilement créer,
configurer et lancer des machines virtuelles. Le fait qu’il s’agisse d’un
projet Open-Source est également un avantage, puisque n’importe quelle
entreprise ou développeur peut travailler sur une copie et implémenter de
nouveaux périphériques émulés pour les @vm:pl. Cela en fait un outil très intéressant,
notamment dans le cadre du
développement de drivers ou autres pour des composants matériels non encore
disponibles comme la carte @bxi de 3#super[e] génération.

En effet, la mise en place et le développement d'un tel projet pour une carte
de ce type s’inscrit dans des échelles de temps très longues. Par conséquent,
il n’est généralement pas possible ou pas souhaitable d’attendre la
disponibilité de prototypes matériels pour commencer le développement logiciel
associé. De plus, l’émulation permet de fournir à chaque développeur une
plateforme capable d'effectuer des tests sans avoir accès au matériel. Ainsi
que d'intégrés les tests dans des pipelines d’intégration continue reposant
sur des environnements virtuelles.

== Objectif du stage

Actuellement, l’équipe @bxi Low-Level dispose d’une copie de @qemu 8 dotée
d’une carte @bxi:pl émulée. Toutefois, cette carte est conçue pour utiliser la
fonctionnalité @svm qui exploite un composant nommé @iommu (décrit dans
@section_iommu). L'année précédente des modifications ont réalisés à l'@iommu
émulée d'Intel pour permettre justement l'utilisation de @svm. Ses
modifications ont réalisés par Clément MATHIEU-DRIF, et permette déjà de
valider l'architecture de la carte.

L’objectif du stage est de réaliser un travail similaire à celui effectuer avec
Intel mais pour la version émulée de l’@iommu d’@amd décrite par la
spécification #smallcaps[AMD-V]i @manual_amd. À terme, le fait de disposer de
fonctionnalité dans @qemu avec plusieurs @iommu permettra de valider son
architecture sur davantage de plateformes.

= Background technique

== Accès mémoire

=== Mémoires virtuelles

#figure(image("./figs/virtual_memory.svg"), caption: [Exemple d'espace d'addressage
de deux processus]) <fig_vm>

#todo()[Principe, segmentation, pagination, avantages dans les systèmes modernes.]

=== #gls-short("mmu")

#todo()[Fonctionnement général, traduction des adresses virtuelles vers physiques,
rôle
dans la gestion de la mémoire.]

=== Accès mémoire via #gls-short("pcie")
#todo()[ - PIO (Programmed I/O) - MMIO (Memory-Mapped I/O) - DMA (Direct Memory Access)

Comparaison des méthodes, cas d’usage, interaction avec le CPU et le système
mémoire.]

=== #gls-short("iommu") <section_iommu>
#todo()[
  Définition, rôle dans la protection mémoire et la virtualisation, analogie avec
  la MMU mais pour les périphériques.
]

== API #gls-short("iommu") dans le noyau Linux

#todo()[
  Présentation de l’interface IOMMU dans le kernel Linux, abstraction pour les
  drivers, fonctions principales exposées.

  - dma coherent/streaming
  - nouvelle api communication direct avec iommu
]

== Limitations actuelles

#todo()[
  Discussion sur les limites fonctionnelles et de Performance du DMA
  "classique" pour le HPC.
]

== Détail du support AMD-Vi

#todo()[
  Traductions possibles
  - *Pass-through* : GVA = GPA = SPA (non-pertinent)
  - *v1 (legacy)* : GPA → SPA (non-pertinent)
  - *v2 (avec PASID)* : GVA → GPA = SPA (cas intéressant pour ce stage)
  - *nested v2->v1* : GVA → SPA (hors périmètre)
]

== SVM (Shared Virtual Memory)

=== Principe général

#todo()[
  Partage de mémoire virtuelle entre le CPU et les périphériques
  (GPU/accélérateurs), bénéfices dans les contextes HPC/accélérés.
]

=== ATS (Address Translation Service)

#todo()[
  Permet au périphérique de demander la traduction d’une adresse virtuelle au CPU.
]

=== PRI (Page Request Interface)

#todo()[
  Permet à un périphérique de signaler des erreurs de traduction mémoire au CPU
  (e.g. page fault)
]

== SVM sur IOMMU Intel

#todo()[
  Travaux réalisés précédemment :
  - Implémentation de PASID, ATS, et PRI
  - Ajout du support ATS/PRI dans QEMU
  - Tests validés avec des projets internes
]

== État de l'IOMMU AMD

#todo()[
  Situation actuelle :
  - Pas de support v2 complet
  - Code existant mais expérimental (issu d’un GSoC il y a 9 ans, non maintenu)
  - Limitations importantes pour le support de SVM avancé
]

= Tests et vérification

#todo()[
  Utilisation de l’IOMMU Intel comme référence de comportement ("oracle").

  - Liste des tests réalisés (fonctionnels, performances, cohérence mémoire,
  erreurs)
]

= Mon travail

== Découverte du développement kernel et QEMU

#todo()[
  Apprentissage du développement dans le kernel Linux et QEMU :
  - Compilation, insertion de modules (simple char driver)
  - Débogage et instrumentation (GDB imbriqué)
  - Simulation de périphériques dans QEMU (création device de test)
]

== Implémentation et tests

=== Implémentation des premiers tests

#todo()[
  Création de tests de base sur l’IOMMU Intel pour valider le framework.
]

=== Découverte et résolution de bugs Intel

#todo()[
  Identification d’un bug dans l’implémentation Intel → Investigation, diagnostic,
  et proposition de correction.
]

=== Tests sur AMD

#todo()[
  - Événements (page faults, erreurs HW) non remontés correctement - Traduction v1
  fonctionnelle - Absence de support PASID/ATS/PRI
]

== Investigation et correction du reporting d’événements

#todo()[
  Analyse du pipeline de remontée d’événements dans AMD-Vi → Corrections pour
  assurer le fonctionnement de base des erreurs mémoire.
]

== Implémentation du support IOMMU v2

#todo()[
  Ajout de la logique de traduction v2 (GVA → GPA = SPA) : - Gestion des PASID -
  Connexion au système de mapping mémoire du kernel
]

== Implémentation du cache v2

=== Implémentation du mécanisme de cache

#todo()[
  Ajout d’un cache cohérent des traductions mémoire.
]

=== Vérification de la cohérence

#todo()[
  Gestion de l’invalidation, suivi des modifications des mappings.
]

=== Résultats obtenus

#todo()[
  Mesures de performances et validation avec des graphiques illustrant le gain ou
  la correction obtenue.
]

== Implémentation ATS

#todo()[
  Ajout du support ATS dans le code IOMMU AMD + QEMU.
]

== Implémentation PRI

#todo()[
  Ajout de la gestion PRI pour permettre les page faults remontés par les
  périphériques.

  → Tests complets SVM à travers IOMMU AMD.
]

= Validation

#todo()[
  À compléter selon l’état des tests finaux, performances, intégration, etc.
]
