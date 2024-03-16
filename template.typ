// Template created after the requirements in https://ub.meduniwien.ac.at/fileadmin/content/OE/ub/dokumente/Leitfaden_Studierende_Hochschulschriften_MedUni_Wien.pdf

#let project(
  type: "",
  title_en: "",
  title_de: "",
  targeted_acadmic_degree: "",
  study_program: "",
  conducted_at: "",
  supervisors: (),
  your_name: "",
  your_orcid: "",
  date: "",
  place: "",
  acknowledgements: [],
  motivation: [],
  abstract_en: [],
  abstract_de: [],
  bibfile: "",
  abbreviations: (),
  skip_figure_list: false,
  skip_table_list: false,
  skip_formula_list: false,
  body,
) = {
  // Set the document's basic properties.
  set document(author: your_name, title: title_en)
  set page(
    // set required margins accordign to style document
    margin: (left: 30mm, right: 25mm, top: 25mm, bottom: 25mm), 
    number-align: center,
  )

  // set a sans-serif font with letter size 12
  // note that according to https://github.com/typst/typst/discussions/2919 typst does not directly allow setting header scaling, but their defaults essentially match the MUW requirements of 14 (12 * 1.2) and 16 (12 * 1.4)
  set text(font: "New Computer Modern Sans", lang: "en", size: 12pt)
  show math.equation: set text(weight: 400)
  
  // Set paragraph spacing.
  show par: set block(above: 1.2em, below: 1.3em) 
  set heading(numbering: "1.1")
  
  // the MUW recommends line spacing 1.5
  // unfortunately, "line spacing 1.5" is a vary vague term and is not easy to set in typst
  // the following setting is not entirely 1.5 but comes close enough
  set par(leading: 0.8em) 

  // set the numbering of equations (and automatically tables) to be per chapter

  // reset figure and math equation counters with each heading
  show heading.where(level:1): it => {
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(math.equation).update(0)
    it
  }

  // As per 08.03.24 (version 0.10.0) this does not work 
  //  however acccording to https://github.com/typst/typst/issues/1057
  //  this has been already implemented. Should be fixed with
  //  the next realease of typst.
  set figure(numbering:  it => {
    [#counter(heading.where(level:1)).display()\.#it]
  })
  set math.equation(numbering: it => {
    [(#counter(heading.where(level:1)).display()\.#it)]
  })
  

  

  // ------------------------------------
  // Title page.
  set page(numbering: none)
  let c = navy
  let type_style(content) = {
    set text(c, 2.1em) 
    content
  }
  let title_style(content) = {
    set text(c, 2em, weight: 700)
    content
  }
  let bold_regular_style(content) = {
    set text(c, 1.2em, weight: 600)
    content
  }
  let regular_style(content) = {
    set text(c, 1.2em)
    content
  }
  let small_style(content) = {
    set text(c)
    content
  }
  
  
  align(left, image("logo.svg", width: 26%))
  align(center)[#type_style(type)]

  linebreak()
  
  align(center)[
    #title_style(title_en)
    #linebreak()
    #linebreak()
    #title_style(title_de)
  ]
  
  linebreak()

  align(center)[
    #bold_regular_style("zur Erlangung des akademischen Grades")
    #linebreak()
    #regular_style(targeted_acadmic_degree)
    #linebreak()
    #small_style("an der")
    #linebreak()
    #bold_regular_style("Medizinischen Universität Wien")
    #linebreak()
    #regular_style("Studiendrichtung: ") #bold_regular_style(study_program)
  ]

  linebreak()

  align(center)[
    #bold_regular_style("ausgeführt am:")
    #linebreak()
    #bold_regular_style(conducted_at)
  ]
  
  linebreak()
  

  
  align(center)[
    #bold_regular_style("unter der Anleitung von:")
  ]
  for supervisor in supervisors {
    align(center)[#regular_style(supervisor)]
  }

  linebreak()
  

  align(center)[
    #bold_regular_style("eingereicht von")
    #linebreak()
    #regular_style(your_name)
    #linebreak()
    #linebreak()
    #regular_style("ORCID:")
    #regular_style(your_orcid)
  ]

  linebreak()
  
  
  align(center)[
    #regular_style(place), #regular_style(date)
  ]
  
  pagebreak()

  
  // ------------------------------------
  // Declaration of honesty
  set page(numbering: "i")
  counter(page).update(1)
  heading(numbering: none, "Declaration of honesty")

  text("Ich erkläre ehrenwörtlich, dass ich die vorliegende Abschlussarbeit selbstständig und ohne fremde Hilfe verfasst habe, andere als die angegebenen Quellen nicht verwendet habe und die den benutzten Quellen wörtlich oder inhaltlich entnommenen Stellen als solche kenntlich gemacht habe.")
  linebreak()
  linebreak()
  linebreak()

  line(length: 100%)
  text(place)
  text(", am")
  h(50%)
  text("Unterschrift")
  pagebreak()

  // ------------------------------------
  // Acknowledgements
  if acknowledgements != []{
    heading(outlined: false, numbering: none, text(0.85em)[Acknowledgements])
    acknowledgements
    pagebreak()
  }

  // ------------------------------------
  // Motivation
  if motivation != []{
    heading(outlined: false, numbering: none, text(0.85em)[Motivation])
    motivation
    pagebreak()
  }
  
  
  // ------------------------------------
  // Abstract page English.
  set page(numbering: "1")
  counter(page).update(1)
  heading(outlined: false, numbering: none, text(0.85em)[Abstract])
  abstract_en    
  v(1.618fr)
  pagebreak()

  // ------------------------------------
  // Abstract page German.
  heading(outlined: false, numbering: none, text(0.85em)[Zusammenfassung])
  abstract_de    
  v(1.618fr)
  pagebreak()

  // ------------------------------------
  // Table of contents.
  outline(depth: 3, indent: true)
  pagebreak()

  // ------------------------------------
  // Main body.
  set par(justify: true)
  set text(hyphenate: false)

  body

  // ------------------------------------
  // Bibliography
  pagebreak()
  bibliography(bibfile)
  pagebreak()

  // Lists
  set page(numbering: "i")
  counter(page).update(1)
  
  
  // ------------------------------------
  // List of figures
  if not skip_figure_list {
    heading(numbering: none, [List of Figures])
    outline(
      title: "",
      target: figure.where(kind: image),
    )
    pagebreak()
  }

  // ------------------------------------
  // List of tables
  if not skip_table_list {
    heading(numbering: none, [List of Tables])
    outline(
      title: "",
      target: figure.where(kind: table),
    )
    pagebreak()
  }
  

  // ------------------------------------
  // List of formulas  
  if not skip_formula_list {
    heading(numbering: none, [List of Formulas])
    outline(
      title: "",
      target: math.equation,
    )
    pagebreak()
  }
  
  // ------------------------------------
  // List of abbreviations
  if abbreviations != () {
    heading(numbering: none, "List of Abbreviations")
    linebreak()
    for key in abbreviations.keys().sorted() {
      [/ #key: #abbreviations.at(key)]
    }
    pagebreak()
  }
  

  // ------------------------------------
  // Appendix
  heading(numbering: none, "Appendix")
}