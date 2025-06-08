#import "@preview/glossy:0.8.0": *

#let small = sub.with(baseline: 0em)

#let entry-list = (
  cpu: (
    short: "CPU",
    long: "Processeur",
    // description: "de l'anglais Central Processing Unit",
  ),
  dma:
  (
    short: "DMA",
    long: "Accès Directe à la Mémoire",
    // description: "Accès mémoire initié par un périphérique sans intervention du #gls-short("cpu")",
  ),
  esn:
  (
    short: "ESN",
    long: "Entreprises de Services du Numériques",
    // description: [Anciennement connu sous le nom Société de Services en Ingénierie
    // Informatique (SSII)],
  ),
  mmu:
  (
    short: "MMU",
    long: "Memory Management Unit",
    description: "Unité de Gestion Mémoire",
    // description: [Composant physique responsable de la gestion et traduction des
    // accés mémoire du #gls-short("cpu")],
  ),
  iommu:
  (
    short: "IOMMU",
    long: "Input-Output Memory Management Unit",
    // description: "Accès mémoire initié par un périphérique sans intervention du #gls-short("cpu")",
  ),
  pcie:
  (
    short: "PCIe",
    long: "Peripheral Component Interconnect Express",
    // description: [Norme de bus d'extension Standard défini par le consortium #[Peripheral
    // Component Interconnect Special Interest (PCI SIG)]],
  ),
  pci:
  (
    short: "PCI",
    long: "Peripheral Component Interconnect",
    // description: [Norme de bus d'extension Standard défini par le consortium #[Peripheral
    // Component Interconnect Special Interest (PCI SIG)]],
  ),
  bds:
  (
    short: "BDS",
    long: "Big-Data et Sécurité",
  ),
  hpc:
  (
    short: "HPC",
    long: "Calcul Haute Performance",
  ),
  bxi:
  (
    short: "BXI",
    plural: "BXIv3",
    long: "BullSequana eXascale Interconnect",
  ),
  nic:
  (
    short: "NIC",
    long: "Carte d'Interface Réseau",
  ),
  qemu:
  (
    short: "QEMU",
    long: "Quick Emulator",
  ),
  api:
  (
    short: "API",
    long: "Application Programming Interface",
    description: "Interface de Progammation d'Application",
  ),
  mpi:
  (
    short: "MPI",
    long: "Messaging Passing Interface",
  ),
  vm:
  (
    short: "VM",
    plural: "VMs",
    long: "Machine virtuelle",
    longplural: "Machines virtuelles",
  ),
  svm:
  (
    short: "SVM",
    long: "Shared Virtual Memory",
    description: [Mémoire Virtuelle Partagée (aussi connu sous le nom #emph[Shared
    Virtual Address] - SVA)],
  ),
  amd:
  (
    short: "AMD",
    long: "Advanced Micro Devices Inc.",
  ),
  amdvi:
  (
    key: "amdvi",
    short: "AMD-Vi",
    long: "AMD's I/O Virtualization Technology",
  ),
  os:
  (
    short: "OS",
    long: "Operating System",
    description: [Système d'exploitation],
  ),
  tlb:
  (
    short: "TLB",
    long: "Translation Lookaside Buffer",
    description: [Répertoire de Page Active],
  ),
  pio:
  (
    short: "PIO",
    long: "Programmed Input-Output",
  ),
  mmio:
  (
    short: "MMIO",
    long: "Memory Mapped Input-Output",
  ),
  ram:
  (
    short: "RAM",
    long: "Random Access Memory",
    description: [Mémoire vive],
  ),
  iova:
  (
    short: "IOVA",
    long: "Input-Output Virtual Address",
    description: [Addresse Virtuelle d'Entrée-Sortie],
  ),
  spa:
  (
    short: "SPA",
    long: "System Physical Address",
    description: [Adresse Physique de l'Hôte],
  ),
  gva:
  (
    short: "GVA",
    long: "Guest Virtual Address",
    description: [Adresse Virtuelle de l'Invité],
  ),
  gpa:
  (
    short: "GPA",
    long: "Guest Physical Address",
    description: [Addresse Physique de l'Invité],
  ),
  ats:
  (
    short: "ATS",
    long: "Address Translation Service",
    description: [Service de Traduction d'Addresse],
  ),
  pri:
  (
    short: "PRI",
    long: "Page Request Interface",
    description: [Interface de Requête de Page],
  ),
)

#let display-glossary = glossary.with(show-all: true)
#let setup-glossary = init-glossary.with(entry-list)
