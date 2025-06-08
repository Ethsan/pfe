#import "./style.typ": style, todo, wrap-content, fakesc

#show: style

= Introduction

#todo()[Contexte général du stage dans l'écosystème HPC (High Performance Computing),
présentation du sujet et des enjeux liés à la virtualisation et la gestion
mémoire dans ce domaine.]

= Contexte

#figure(image("./figs/ma.svg"), caption: [Historique partiel des acquisitions]) <fig_ma>

== Présentation d'Atos

La société Atos, maison mère d'Eviden, représente près de 78 112
collaborateurs, et un chiffre d'affaire d'environ 9,5 mialliards d'euros fin
2024 @online_annual_report. La société est présente dans 71 pays. Son patronyme
Atos (Axime to Slygos) vient de la réunion en 2000 de deux @esn, Axime et
Sligos, spécialisées entre autre dans les services bancaire, l'infogérance et
l'intégration de systèmes. Sligos est notamment connu pour ses compétences dans
le domain des solutions de paiement, elle a développé dans les années 80 la
"carte bleue".

Après son acquisition d'Origin durant l'année 2000, elle est rebaptisée Atos
Origin. Puis dans en 2011, elle achète à Siemens sa division "Siemens IT
Solutions & Services", le nouveau groupe s'appelle alors à nouveau Atos (Atos
Origin to Siemens) et devient un acteur de poids dans un grand nombre de
rachats d'entreprise dont : Bull, Xerox ITO, Ideal GRP, et bien d'autre (voir
@fig_ma pour un aperçu).

Cette frénésie d'achats de société externes, entre 2014 et 2016, est menée par
le président du directoire d'Atos, Thierry Breton, nommé en 2008. Les diverses
péripéties et contre perfomances de certains des domaines d'activité entraine
l'entreprise dans une descente aux enfers @online_enfer. Les journaux
économiques n'hésite pas à pointer du doigt Thierry Breton comme responsable de
la chute et de la stratégie hasardeuse du groupe @online_breton.

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
tête des constructeurs mondiaux de supercalculateurs. Cette branche d'activités
est à la fois permformante et rentable, contrairement à la branche infogérance
d'Atos en perte de vitesse.

Ainsi, en juin 2023 Eviden a remporté un marché de 100 millions de dollars en
Inde pour la fourniture de deux supercalculateurs à l’Institut Indien de
Météorologie Tropicale @online_inde. En Janvier 2024, Eviden obtient aussi la
fourniture du datacenter modulaire pour le supercalculateur Jupiter qui sera
installé au centre de recherche de Jülich en Allemagne @online_allemagne. Il
s’agira du premier supercalculateur exascale en Europe.

Pour ces raisons, l’entité attise la convoitise d'entreprises importantes. Pour
preuve, plusieurs proposition de rachat s'enchaineront: la société Airbus a
proposé le rachat d’Eviden en 2014 (ajouter source), le milliardaire Daniel
Kretinsky a proposé le rachat de Tech Foundation en 2014 (ajouter source).
Pourtant aucune de ces négociations n'ont aboutis.

Face à cette situation, l’État français, par la voix du Ministre de l’Économie
Bruno Le Maire, a exprimé sa volonté d’acquérir 100 % des activités
stratégiques d’Atos, en particulier celles liées à la défense, à l’énergie
nucléaire et à la cybersécurité. Le Ministre a souligné qu’Atos détient
notamment des supercalculateurs utilisés dans le cadre de la dissuasion
nucléaire, ainsi que des contrats sensibles avec l’armée française et le
ministère des Armées @online_bruno.

Le 2 juin 2025, lors de l'écriture de ce rapport, une offre ferme vient d'être
négociée entre l'État et Atos. Elle concerne le rachat des activités de @hpc &
Quantique ainsi que les divisions Business Computing & Intelligence pour une
valeur d'entreprise d'environ 500 millions @online_rachat.

== Présentation de la @nic:noref @bxi:short:noref

Le @hpc[Calcul Haute Perfomance (#emph[@hpc:long], alias @hpc:short)] est une
branche de l’informatique qui se concentre sur le développement de systèmes et
d’architectures capables de fournir des performances de calcul très élevées
pour des applications qui, souvent, ne peuvent pas être exécutées sur des
machines classiques ou qui demandent un temps de calcul trop long pour être
utilisables en pratique. Des exemples typiques sont les simulations de
mécanique des fluides, les prévisions météorologiques et climatiques, la
modélisation moléculaire ou encore la recherche en astrophysique @online_cea.

Pour arriver à cet objectif, un calcul massivement parralléle éxecute un grands
nombres de tâches en simultanés sur un ensembles de machines (appelés
#emph[noeuds]) formant ainsi un #emph[cluster]. Ce cluster, pouvant être
composé d'une dizaine jusqu'à une centaine de milliers de noeuds ou plus,
utilise un planificateur centralisé gérant la répartition et l'organisation des
tâches. La communication entre les noeuds est assurée par un réseau
d’interconnexion, les performances dans ce réseau (latence, débit) sont
cruciales pour garantir que la vitesse de calcul ne soit pas limitée. En effet,
une latence élevée ou un débit insuffisant peuvent créer des goulots
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

== Présentation de @qemu:short:noref

@qemu est un logiciel libre et Open-Source très largement utilisé pour
l’émulation ou la virtualisation en collaboration avec des outils tels que
#smallcaps[kvm]. Associé à Libvirt, @qemu permet de facilement créer,
configurer et lancer des machines virtuelles. Le fait qu’il s’agisse d’un
projet Open-Source est également un avantage, puisque n’importe quelle
entreprise ou développeur peut travailler sur une copie et implémenter de
nouveaux périphériques émulés pour les @vm:pl. Cela en fait un outil très
intéressant, notamment dans le cadre du développement de drivers ou autres pour
des composants matériels non encore disponibles comme la carte @bxi de
3#super[e] génération.

En effet, la mise en place et le développement d'un tel projet pour une carte
de ce type s’inscrit dans des échelles de temps très longues. Par conséquent,
il n’est généralement pas possible ou pas souhaitable d’attendre la
disponibilité de prototypes matériels pour commencer le développement logiciel
associé. De plus, l’émulation permet de fournir à chaque développeur une
plateforme capable d'effectuer des tests sans avoir accès au matériel. Ainsi
que d'intégrés les tests dans des pipelines d’intégration continue reposant sur
des environnements virtuelles.

== Objectif du stage

Actuellement, l’équipe @bxi Low-Level dispose d’une copie de @qemu 8 dotée
d’une carte @bxi:pl émulée. Toutefois, cette carte est conçue pour utiliser la
fonctionnalité @svm qui exploite un composant nommé @iommu (décrit dans
@section_iommu). L'année précédente des modifications ont réalisés à l'@iommu
émulée d'Intel pour permettre justement l'utilisation de @svm. Ses
modifications ont réalisés par Clément Mathieu-Drif, et permette déjà de
valider l'architecture de la carte.

L’objectif du stage est de réaliser un travail similaire à celui effectuer avec
Intel mais pour la version émulée de l’@iommu d’@amd décrite par la
spécification @amdvi @manual_amd. À terme, le fait de disposer de
fonctionnalité dans @qemu avec plusieurs @iommu permettra de valider son
architecture sur davantage de plateformes.

= Background technique

== Accès mémoire

Les sections suivantes sont largement inspirés de
#emph[Operating System Concepts]@book_os_concept et de
#emph[Modern Operating Systems]@book_modern_os.

=== Mémoires virtuelles

La mémoire virtuelle, dans les systèmes modernes, est à la base de la gestion
de la mémoire par les systèmes d'exploitation. Elle permet de masquer la
mémoire physique réelle en fournissant à chaque processus une vue abstraite et
isolée de la mémoire, comme s’il disposait d’un espace contigu, privé et
quasi-infini. Cette foctionnalités permet de garantir à la fois la sécurité, la
portabilité des applications, ainsi que l'efficacité d'utilisation des
ressources.

#figure(image("./figs/paging.svg"), caption: [Illustration du fonctionnement de
la pagination]) <fig_paging>

La traduction des addresses virtuelles en addresses physiques requiert un
support matériel, assuré par un composant dédiée, la @mmu, fonctionnant en
collaboration avec le noyau du système. Cette traduction repose sur un
mécanisme de pagination, où l'espace est divisé en blocs contigu de taille fixe
appelés pages (généralement de 4 Kio#footnote[Kio : kilooctet binaire, soit
1 024 octets (norme CEI).]), qui sont associé dynamiquement grâce à une table
des page à des cadres (#emph[frames]) de mémoire physique (illustré
@fig_paging). La pagination a remplacé les anciennes techniques de
segmentation, aujourd’hui rarement utilisées dans les systèmes modernes.

#figure(image("./figs/virtual_memory.svg"), caption: [Exemple
de partage de mémoire entre deux processus]) <fig_vm>

La traduction à la volée des addresses rend possible d'isoler les processus les
uns des autres. Ainsi deux processus peuvent utiliser la méme addresse
simultanément, et accéder à des données différentes(illustré dans @fig_vm). De
plus, la pagination présente d'autres avantages, en particulier le chargement à
la demande (#emph[demand paging]), qui permet de ne charger en mémoire physique
que les pages réellement utilisées. Cela autorise l’exécution de programmes
dont la taille dépasse la capacité mémoire physique disponible. Enfin, elle
permet également des optimisations importantes, telles que le partage de
bibliothèques dynamiques entre processus, ou encore la duplication différée de
l’espace mémoire lors de la création d’un nouveau processus
(#emph[copy-on-write]).

Finalement, la mémoire virtuelle permet la mise en place de fonctionnalités
plus avancées, comme la virtualisation de @os[Systèmes d'Exploitation (#emph[@os:long],
alias @os:short)],
le fonctionnement des conteneurs, ou encore le partage mémoire entre @cpu et
accélérateurs dans les architextures hétérogènes. Elle constitue la base
technique indispensable des @os modernes.

=== @mmu:short:noref

#figure(image("./figs/mmu.svg"), caption: [Emplacement et fonctionnement d'une @mmu:noref:short]) <fig_mmu>

L'@mmu[Unité de Gestion Mémoire (#emph[@mmu:long], alias @mmu:short)] est une
composante matérielle intégrée dans le processeur (voir @fig_mmu), c'est elle
qui est chargé d'effectuer les traduction des adresses mémoire virtuelles. Son
rôle est central dans le fonctionnement de la mémoire virtuelle, car elle
assure que cette traduction soit transparente et rapide à chaque accès mémoire.

#figure(image("./figs/table.svg"), caption: [Opération interne de la @mmu:noref:short
avec 16
pages de 4K]) <fig_table>

Lorsqu’un programme tente d’accéder à une adresse mémoire, cette adresse est en
réalité une adresse virtuelle. La @mmu intercepte cette requête et consulte une
structure de données appelé la table des pages pour déterminer l’adresse
physique correspondante. Ces tables sont maintenues par le système
d’exploitation, et leur contenu est régulièrement mis à jour pour refléter
l’état de l’allocation mémoire, les permissions d’accès, ou encore la présence
ou non des pages en mémoire physique (illustré @fig_table).

La table des pages est une structure dynamique dans le sens où elle est mise à
jour fréquemment par le système. Par exemple, dans le cas où une traduction
demandée n’est pas disponible dans la table (parce que la page n’est pas en
mémoire physique, mais a été déplacée sur disqtranslationue ou n’existe simplement
pas),
la MMU génère une interruption appelée faute de page (#emph[page fault]). Cette
interruption est ensuite traitée par le système d’exploitation. Celui-ci charge
ou récupère la page demandée, puis met à jour la table des pages avec la
nouvelle traduction.

#figure(image("./figs/hierachie.svg"), caption: [Traduction d'adresses pour une
architecture de pagination à quatres niveaux avec 48 bits]) <fig_hierarchie>

Le fonctionnement de la @mmu repose souvent sur un mécanisme de hiérarchie de
pages, notamment dans les architectures 64 bits modernes, où plusieurs niveaux
de tables de pages sont nécessaires pour adresser efficacement de vastes
espaces mémoire. Sur les processeurs x86, l’adresse de la racine de la table
des pages est stockée dans le registre CR3 et les adresses virtuelles
manipulées sont codées sur 48 bits (table des pages à 4 niveaux). Une extension
existe pour passer à 57 bits et donc 5 niveaux. Cela permet d’agrandir l’espace
d’adressage virtuel. Dans les 2 cas, les bits de poids faible (12 bits pour les
pages de 4 Kio) de l’adresse virtuelle sont utilisés comme déplacement dans la
page afin de trouver la donnée et le reste des bits est découpé en différents
sous-indices permettant de trouver les entrées dans les niveaux supérieurs de
la table. Généralement, les champs sont composés de 9 bits pour indexer les 512
entrées d’un niveau donné de la table (illustré @fig_hierarchie).

Pour accélérer ce processus, les processeurs intègrent un cache spécifique,
appelé @tlb, qui permet de mémoriser les traductions les plus récemment
utilisées. En cas de défaut de @tlb (#emph[#fakesc[@tlb] miss]), une nouvelle
traduction est recherchée dans les tables de pages, ce qui peut introduire une
latence supplémentaire.

Outre la traduction d’adresses, la @mmu est également responsable du contrôle
d’accès à la mémoire. Elle vérifie pour chaque accès si les permissions
associées à la page concernée autorisent l’opération demandée (lecture,
écriture, exécution). En cas de violation, une exception matérielle est levée,
généralement traduite en #emph[segmentation fault] côté logiciel.

=== Accès mémoire via @pcie:noref:both

L’interconnexion @pcie:short joue un rôle central dans l’accès
mémoire entre le processeur principal et les périphériques tels que cartes
graphiques, cartes réseaux ou accélérateurs spécialisés. Trois grands
mécanismes d’accès mémoire coexistent sur un lien @pcie : @pio, @mmio et @dma.

- @pio : Dans ce mode traditionnel, le processeur exécute explicitement des instructions
  d’accès (lecture ou écriture) vers des ports d’E/S associés à un périphérique.
  L’accès se fait généralement via des instructions spécifiques du jeu d’instructions
  du @cpu (par exemple, les instructions `in` et `out` sur x86).
  Il n’est efficace que pour de très petits volumes de données ou des
  accès de configuration.

- @mmio : Le @mmio consiste à associer certaines plages d’adresses de l'espace d'adresses
  mémoire physique à des registres ou tampons d’un périphérique. Pour le @cpu, lire
  ou écrire dans ces plages revient à accéder à de la mémoire ordinaire : ces opérations
  sont transmises sur le bus @pcie et réinterprétées côté périphérique. Ce mode est
  très utilisé pour le contrôle (configuration, déclenchement, gestion d’état) et
  permet des interactions plus performantes que le @pio.

- @dma Pour les transferts de gros volumes de données (par exemple lors d’un envoi
  massif de paquets réseau, ou de l’accès à une mémoire centrale par un accélérateur),
  le mécanisme privilégié est le @dma. Ici, le périphérique devient maître du bus
  et peut accéder directement à la @ram[mémoire vive (#emph[@ram:long], alias @ram:short)]
  sans intervention constante du @cpu : le pilote prépare une requête @dma (en spécifiant
  les adresses sources ou destinations), puis le périphérique pilote le transfert
  de façon autonome (illustré @fig_dma). Le @dma permet de décharger significativement
  le processeur, d’augmenter les débits, et d’optimiser l’utilisation des ressources
  du système.

#figure(image("./figs/dma.svg"), caption: [Transfert @dma:noref:short]) <fig_dma>

Dans la suite du rapport nous concentrerons sur les requêtes @dma. Une
attention particulière doit cependant être portée à la protection mémoire et à
la traduction d’adresses. Par défaut, un périphérique @dma utilise des adresses
physiques du système, or avec l’augmentation de la virtualisation ou le partage
de mémoire entre plusieurs périphériques/@vm, cette approche pose des problèmes
de sécurité et d’isolation. Pour cette raison, l’utilisation d’un composant
matériel spécifique (voir @section_iommu suivante) est devenue incontournable :
il permet d’isoler et de traduire dynamiquement les accès mémoire des
périphériques (mode @dma).

En résumé, le choix entre @pio, @mmio et @dma dépend de la nature du
transfert : @pio et @mmio sont privilégiés pour le pilotage et la
configuration, tandis que le @dma est réservé aux transferts de données à fort
volume et à haute performance, au cœur des usages @hpc et accélérés.

=== @iommu:noref <section_iommu>

#figure(image("./figs/iommu.svg"), caption: [Comparaison de l'@iommu:noref:short
à la @mmu:noref:short]) <fig_iommu>

L'@iommu[Unité de Gestion Mémoire d'Entrée-Sortie (#emph[Input-Ouput Management Unit],
alias @iommu:short)]
est un composant matériel présent dans les systèmes modernes qui intervient
dans la gestion des accès mémoire effectués par les périphériques, notamment
ceux utilisant le @dma. Son fonctionnement et son rôle sont très similaires à
ceux de la @mmu côté processeur, mais appliqués spécifiquement aux
périphériques d'entrée/sortie (illustré @fig_iommu).

Lorsque des dispositifs tels que des cartes réseau, des cartes graphiques ou
d'autres contrôleurs @pcie doivent accéder à la mémoire centrale du système
pour lire ou écrire des données, ces accès se faisaient traditionnellement en
utilisant des adresses physiques "brutes" fournies par le système
d'exploitation. Or, dans un environnement virtualisé ou partagé, cela pose
plusieurs problèmes majeurs:

- Un périphérique pourrait, volontairement ou par erreur, accéder à des régions mémoire
  appartenant à d'autres périphériques, processus, ou @vm:pl.

- Il devient impossible d'isoler proprement les accès mémoire lors de la cohabitation
  de plusieurs @vm:pl ou utilisateurs sur la même machine physique.

- La gestion fine des droits d’accès devient complexe, voire impossible sans support
  matériel dédié.

L'@iommu agit donc comme une "@mmu" dédiée aux périphériques. Avant d'accéder
à la mémoire, toute requête @dma initiée par un périphérique transite par
l'@iommu, qui va alors :

- Traduire l’adresse utilisée par le périphérique (appelée @iova ou @gpa) en @spa.

- Vérifier que ce périphérique est autorisé à accéder à cette zone mémoire, empêchant
  ainsi tout accès hors périmètre attribué (protection contre les @dma illégitimes
  ou malveillants).

- Appliquer éventuellement des politiques de virtualisation mémoire ou de partage,
  permettant de mapper dynamiquement des zones mémoire différentes pour chaque périphérique, @vm
  ou contexte.

En d’autres termes, l’@iommu permet de réaliser, pour les périphériques, le même
type de virtualisation de la mémoire que la @mmu procure au processeur, garantissant
ainsi isolation, sécurité et flexibilité. Ce mécanisme est essentiel dans le contexte
de la virtualisation matérielle (e.g. #emph[@pci passthrough]), du cloud, ou des
architectures fortement partagées (e.g. @hpc, serveurs multi-utilisateurs) @report_iommu.

Enfin, certaines extensions de l'@iommu prennent en charge des
fonctionnalités avancées, telles que la gestion de la mémoire partagée
hétérogène (@svm) ou des services accélérant la traduction d'adresse côté
périphérique (@ats, @pri, etc.), qui seront détaillés dans les sections
ultérieures de ce document.

== API @iommu:noref:short dans le noyau Linux

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

== Détail du support @amdvi:noref:short

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
