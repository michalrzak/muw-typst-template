#import "template.typ": *

// README
// ---------------------------------------------
// Before writting the thesis definetly check out the guide at
// https://ub.meduniwien.ac.at/fileadmin/content/OE/ub/dokumente/Leitfaden_Studierende_Hochschulschriften_MedUni_Wien.pdf
// 
// You are for example required to have a list of abbreviations in your document, if any are used.
// For this simply fill out the appropriate field in the initialization.
// 
// This template should automatically take care of any requirements, if you fins something missing, contributions are
// welcome.
//  
// NOTE: You might need to disable the printing of List of Figures / List of Tables / List of Formulas depending on
// if you are using them in your thesis. You can do this with the appropriate parameters.
// ---------------------------------------------

// Customize the following fields with your data!
#show: project.with(
  type: "Masterarbeit",
  title_en: "A title in English",
  title_de: "Ein Titel auf Deutsch",
  targeted_acadmic_degree: "Diplomingenieur (Dipl. Ing.)",
  study_program: "Medizininformatik",
  conducted_at: "Your institute",
  supervisors: ("Supervisor","Co-supervisor"),
  your_name: "My name",
  your_orcid: "sample",
  date: "March 7, 2024",
  place: "Wien",
  // Insert your abstract after the colon, wrapped in brackets.
  // Example: `abstract: [This is my abstract...]`
  abstract_en: lorem(59),
  abstract_de: lorem(59),
  // The acknowledgements and motivation are both optional fields.
  // If you do not need them in your thesis simply leave out the field.
  // Formatting same as abstract
  acknowledgements: lorem(59),
  motivation: lorem(59), 
  // The abbreviations field is also optional.
  // If you need to use extend the dictionary with values as indicated
  // bellow.
  abbreviations: (
    A: "A stands for alphabet",
    B: "B stands for bannana"
  ), 
  bibfile: "bibliography.bib",
  // This is needed as there is no way (I know of) to dynamically find if tables/figures/equations
  //  were used and only print the lists then.
  // Simply disable the ones you do not need.
  skip_figure_list: false,
  skip_table_list: false,
  skip_formula_list: false,
)

= Introduction
#lorem(60)

= Methods
#lorem(120)
#figure(image("logo.svg"), caption: [Some image])

== Subsection
#lorem(500)

$ a + 10 = 10 $

= Results
#lorem(60)

#figure(table(
  columns: (auto, auto),
  inset: 10pt,
  align: horizon,
  [*Area*], [*Parameters*],
  $ pi h (D^2 - d^2) / 4 $,
  [
    $h$: height \
    $D$: outer radius \
    $d$: inner radius
  ],
), caption: [Some result table])

= Discussion
#lorem(20)
