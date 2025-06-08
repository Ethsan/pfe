#import "@preview/codelst:2.0.2": sourcecode
#import "@preview/wrap-it:0.1.1": wrap-content as _wrap-content
#import "./glossary.typ": *

#let wrap-content(
  fixed,
  to-wrap,
  align: top + left,
  size: auto,
  ..grid-kwargs,
) = {
  context if (target() == "html") {
    fixed
    to-wrap
  } else {
    _wrap-content(fixed, to-wrap, align: align, size: size, ..grid-kwargs)
  }
}

#let todo(body, fill-color: yellow.lighten(50%)) = {
  set text(black)
  box(
    baseline: 25%,
    fill: fill-color,
    inset: 3pt,
    [*TODO* #body],
  )
}

#let fakesc(content) = {
  text(size: 0.8em, upper(content))
}

#let style(body) = {
  show: setup-glossary
  set document(author: "Ethan Milon", title: "Rapport de projet de fin d'études")
  set text(lang: "fr")

  set heading(supplement: "Section")
  show heading.where(level: 1): set heading(supplement: "Chapitre")

  context if target() == "html" {
    set heading(numbering: none, outlined: false)
    show image: it => html.elem("img", attrs: (src: it.source))
    show smallcaps: it => upper(it.body)

    show outline.entry: it => {
      it.indented(it.prefix(), it.body())
    }
    outline(title: "Table des matières")
    outline(title: "Table des figures", target: figure.where(kind: image))

    set heading(numbering: "I.1.1 -", outlined: true)
    set par(justify: true, first-line-indent: (amount: 1em, all: true))
    show bibliography: bib => { }
    body
    bibliography("bibliography.bib", full: true, style: "ieee")
    [= Glossaire]
    display-glossary()
    return
  } else {
    show regex("([A-Z][A-Z0-9\-/.]*)?[A-HJ-UWYZ][A-Z0-9\-/.]+"): set text(features: ("smcp", "c2sc"))

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

    set page(margin: (inside: 2.5cm, outside: 2cm, y: 2.1cm), paper: "a4")
    set text(font: body-font, lang: "fr")

    let code-theme = "bluloco-light"
    // let selected-theme = "template/themes/" + code-theme + ".tmTheme"
    // set raw(theme: selected-theme)
    show raw: set text(font: raw-font)

    set cite(style: auto, form: "normal")

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

    show link: it => {
      if type(it.dest) == str {
        text(ligatures: true, fill: blue, it)
      } else {
        it
      }
    }

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

    pagebreak(weak: true)
    counter(page).update(1)
    set page(
      numbering: "i",
      header: { text(0.75em, {
        emph("Ethan MILON"); h(1fr); emph("Télécom Physique Strasbourg - Eviden")
      }) },
      footer: context {
        move(dy: 5pt, line(length: 100%, stroke: 0.5pt))
        emph[Implémentation du support #fakesc[svm] pour l'#fakesc[iommu] #fakesc[amd]
        virtuelle de #fakesc[qemu]]
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
      if it.numbering != none and it.outlined {
        let i = counter(heading).get().first()
        set par(first-line-indent: 0em)
        heading(
          outlined: false,
          numbering: none,
        )[Chapitre #numbering("I", i) \
        #it.body
        #place(horizon, dy: -2pt, line(length: 100%))
        #place(horizon, dy: 0pt, line(length: 20%, stroke: 4pt)) ]
      } else {
        pagebreak(weak: true)
        set text(size: 1.5em)
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
        emph[Implémentation du support #fakesc[SVM] pour l'#fakesc[IOMMU] #fakesc[AMD]
        virtuelle de #fakesc[QEMU]]
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

    bibliography("bibliography.bib", full: true, style: "ieee")

    // The appendix page
    align(center + horizon, [
      #set text(size: 18pt)

      = Annexes
    ])
  }
}
