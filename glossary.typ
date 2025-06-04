#import "@preview/glossarium:0.5.6": make-glossary, register-glossary, print-glossary, gls, glspl, gls-short

#let entry-list = (
  (
    key: "cpu",
    short: smallcaps[cpu],
    long: link("https://fr.wikipedia.org/wiki/Processeur")[Processeur],
    description: [de l'anglais Central Processing Unit],
  ),
  (
    key: "dma",
    short: smallcaps[dma],
    long: link("https://fr.wikipedia.org/wiki/Acc%C3%A8s_direct_%C3%A0_la_m%C3%A9moire")[Accès
    Directe à la Mémoire],
    description: [Accès mémoire initié par un périphérique sans intervention du #gls-short("cpu")],
  ),
  (
    key: "esn",
    short: smallcaps[esn],
    long: link("https://fr.wikipedia.org/wiki/Entreprise_de_services_du_num%C3%A9rique")[Entreprises
    de Services du Numériques],
    description: [Anciennement connu sous le nom Société de Services en Ingénierie Informatique (#smallcaps[ssii])],
  ),
  (
    key: "mmu",
    short: smallcaps[mmu],
    long: link("https://fr.wikipedia.org/wiki/Unit%C3%A9_de_gestion_de_m%C3%A9moire")[Memory
    Management Unit],
    description: [Composant physique responsable de la gestion et traduction des
    accés mémoire du #gls-short("cpu")],
  ),
  (
    key: "iommu",
    short: smallcaps[iommu],
    long: link("https://en.wikipedia.org/wiki/Input%E2%80%93output_memory_management_unit")[Input-Output Memory Management Unit],
    description: [Accès mémoire initié par un périphérique sans intervention du #gls-short("cpu")],
  ),
  (
    key: "pcie",
    short: [#smallcaps[pci]#sub(baseline: 0em)[e]#super[#sym.copyright]],
    long: link("https://fr.wikipedia.org/wiki/Acc%C3%A8s_direct_%C3%A0_la_m%C3%A9moire")[Peripheral
    Component Interconnect Express],
    description: [Norme de bus d'extension Standard défini par le consortium #link("https://pcisig.com")[Peripheral
    Component Interconnect Special Interest (#smallcaps("pci sig"))]],
  ),
  (
    key: "bds",
    short: smallcaps[bds],
    long: "Big-Data et Sécurité",
  ),
  (
    key: "hpc",
    short: smallcaps[hpc],
    long: "Calcul Haute Performance",
  ),
  (
    key: "bxi",
    short: smallcaps[bxi],
    plural: [#smallcaps[bxi]#sub(baseline: 0em)[v3]],
    long: "BullSequana eXascale Interconnect",
  ),
  (
    key: "nic",
    short: smallcaps[nic],
    long: "Carte d'interface réseau",
  ),
  (
    key: "qemu",
    short: smallcaps[qemu],
    long: "Quick Emulator",
  ),
  (
    key: "api",
    short: smallcaps[api],
    long: "Interface de Progammation d'Application",
  ),
  (
    key: "mpi",
    short: smallcaps[mpi],
    long: "Messaging Passing Interface",
  ),
  (
    key: "vm",
    short: smallcaps[vm],
    plural: [#smallcaps[vm]s],
    long: "Machine virtuelle",
    longplural: "Machines virtuelles",
  ),
  (
    key: "svm",
    short: smallcaps[svm],
    long: "Shared Virtual Memory",
    description: [aussi connu sous le nom de Shared Virtual Addresses (#smallcaps[sva])],
  ),
  (
    key: "amd",
    short: smallcaps[amd],
    long: "Advanced Micro Devices Inc.",
  ),
)

#let display-glossary() = {
  let __get_attribute(entry, attrname) = entry.at(attrname)
  let __has_attribute(entry, attrname) = {
    let attr = __get_attribute(entry, attrname)
    return attr != none and attr != "" and attr != []
  }
  let has-short(entry) = __has_attribute(entry, "short")
  let has-long(entry) = __has_attribute(entry, "long")
  let print-title(entry) = {
    let caption = []
    let txt = strong.with(delta: 200)

    if has-long(entry) and has-short(entry) {
      caption += txt(entry.short + [ -- ] + entry.long)
    } else if has-long(entry) {
      caption += txt(entry.long)
    } else {
      caption += txt(entry.short)
    }
    return caption
  }
  print-glossary(entry-list, show-all: true, user-print-title: print-title)
}

#let setup-glossary(body) = context {
  show: make-glossary
  register-glossary(entry-list)

  body
}
