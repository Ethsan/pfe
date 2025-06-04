#import "@preview/codelst:2.0.2": sourcecode
#import "./glossary.typ": *

#let todo(body, fill-color: yellow.lighten(50%)) = {
  set text(black)
  box(
    baseline: 25%,
    fill: fill-color,
    inset: 3pt,
    [*TODO* #body],
  )
}

#let style(body) = {
  show: setup-glossary

  //
  // Source code inclusion
  //
  let _luma-background = luma(250)
  show raw.where(block: false): box.with(
    fill: _luma-background,
    inset: (x: 2pt, y: 0pt),
    outset: (y: 2pt),
    radius: 1pt,
  )

  // Replace the original function by ours
  let codelst-sourcecode = sourcecode
  let code = codelst-sourcecode.with(
    frame: block.with(
      fill: _luma-background,
      stroke: 0.5pt + luma(80%),
      radius: 3pt,
      inset: (x: 6pt, y: 7pt),
    ),
    numbering: "1",
    numbers-style: (lno) => text(luma(210), size: 7pt, lno),
    numbers-step: 1,
    numbers-width: -1em,
    gutter: 1.2em,
  )

  // Default body font
  let body-font = ("Source Sans 3", "Libertinus Serif")
  let sans-font = ("Source Sans 3", "Inria Sans")
  let raw-font = "Fira Code"
  let math-font = ("Asana Math", "Fira Math")

  set document(author: "Ethan Milon", title: "Rapport de projet de fin d'études")
  set page(margin: (inside: 2.5cm, outside: 2cm, y: 2.1cm), paper: "a4")
  set text(font: body-font, lang: "fr")

  let code-theme = "bluloco-light"
  // let selected-theme = "template/themes/" + code-theme + ".tmTheme"
  // set raw(theme: selected-theme)
  show raw: set text(font: raw-font)

  set cite(style: auto, form: "normal")
  show link: set text(ligatures: true, fill: blue)

  set figure(numbering: "1")

  show figure.caption: set text(9pt)
  show figure.caption: emph
  set figure.caption(separator: " - ")

  // Make the caption like I like them
  show figure.caption: it => context {
    if it.numbering == none {
      it.body
    } else {
      it.supplement + " " + it.counter.display() + it.separator + it.body
    }
  }
  // Allow page breaks for raw figures
  show figure.where(kind: raw): set block(breakable: true)

  // cover page
  counter(page).update(0)
  set page(numbering: "Cover α", footer: none)

  let logo_height = 30pt
  let tps = box(height: logo_height, image("./figs/tps.svg"))
  let eviden = box(height: logo_height, image("./figs/eviden.svg"))
  align(horizon, { tps; h(1fr); eviden })

  v(10fr, weak: true)

  // Main title
  set par(leading: 0.2em)
  text(font: sans-font, 2em, weight: 700, smallcaps[Rapport de projet de fin d'études])
  set par(leading: 0.65em)

  // Subtitle
  v(1em, weak: true)
  text(
    font: sans-font,
    size: 1.2em,
    [Implémentation du support #smallcaps[svm] pour l'#smallcaps[iommu] #smallcaps[amd]
    virtuelle de #smallcaps[qemu]],
  )
  line(length: 100%)
  [#emph("Tuteur entreprise") : #strong("Clément MATTHIEU--DRIF") #h(1fr) #emph("Tuteur école")
  : #strong("Quentin BRAMAS")]

  v(4em)

  // Author information on the title page
  align(horizon, text(1.1em, {
    strong[Ethan MILON \ ]
    [Diplôme Télécom Physique Strasbourg \ ]
    emph[Spécialitée Réseaux et Internet des Objets \ ]
    [Promotion 2025 \ ]
    datetime.today().display()
  }))

  v(2.4fr)

  let chapter_loc = state("chapter-loc", 0)

  let is_new_chapter(loc) = {
    let page = loc.page()
    return chapter_loc.at(loc) == page
  }

  pagebreak(weak: true)
  counter(page).update(1)
  set page(
    numbering: "i",
    header: context if not is_new_chapter(here()) { text(0.75em, {
      emph("Ethan MILON"); h(1fr); emph("Télécom Physique Strasbourg - Eviden")
    }) },
    footer: context {
      move(dy: 5pt, line(length: 100%, stroke: 0.5pt))
      emph[Implémentation du support #smallcaps[svm] pour l'#smallcaps[iommu] #smallcaps[amd]
      virtuelle de #smallcaps[qemu]]
      h(1fr)
      counter(page).display()
    },
  )
  pagebreak(weak: true, to: "odd")

  show heading: it => {
    text(font: sans-font, it)
    v(0.5em)
  }
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    chapter_loc.update(here().page())
    set text(size: 1.5em)
    if it.numbering != none {
      let i = counter(heading).get().first()
      box(width: 100%, {
        set par(leading: 0pt, first-line-indent: 0pt)
        let chapitre = [Chapitre #numbering("I", i)]

        chapitre
        place(horizon, dy: 0pt, line(length: 100%))
        place(horizon, dy: 2pt, line(length: 20%, stroke: 4pt))
        it.body
      })
      v(0.4fr)
    } else {
      it
    }
  }
  set heading(numbering: none, outlined: false)

  outline(title: "Table des matières")
  outline(title: "Table des figures", target: figure.where(kind: image))

  [= Glossaire]
  display-glossary()

  pagebreak(weak: true, to: "odd")
  counter(page).update(1)
  set page(
    numbering: "1/1",
    footer: context {
      move(dy: 5pt, line(length: 100%, stroke: 0.5pt))
      emph("Implémentation du support SVM pour l'IOMMU AMD virtuelle de QEMU")
      h(1fr)
      counter(page).display(both: true)
    },
  )

  set heading(numbering: "I.1.1 -", outlined: true)
  set par(justify: true, first-line-indent: (amount: 1em, all: true))
  set scale(reflow: true)

  body

  pagebreak(weak: true, to: "odd")

  // Include the appendix in the TOC but without numeration
  set heading(numbering: none, outlined: true)

  bibliography("bibliography.bib", full: false, style: "ieee")

  // The appendix page
  align(center + horizon, [
    #set text(size: 18pt)

    = Annexes
  ])

  // From now on, do not number the sections and remove from general outline
  set heading(numbering: none, outlined: false)

  // Your document body
}
