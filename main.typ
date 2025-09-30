#import "template.typ": thesis

#let abstract = [
  #lorem(256)
]

// Use the thesis template
#show: thesis.with(
  // Set the basic information fields:
  title: [Typesetting a Master's Thesis with Typst],
  author: "Firstname Lastname",
  supervisor: ("Prof. D.U. Mind", "Dr. O. Why"),
  abstract: abstract,
  ccs: [
    General and reference $->$~Document types $->$~Surveys and overviews\
    Applied computing $->$~Document management and text processing $->$~Document management $->$~Text editing
  ],
  keywords: ("algorithms", "data structures"),
  info: [Software study track],

  // You can disable the detailed information page completely:
  //infopage: false,

  // You can override the study programme:
  //programme: [Bachelor's Programme in Computer Science],

  // You can override the thesis level:
  //level: [Bachelor's thesis],
  //level: [Seminar report],

  // You can make chapters always start from the right side:
  //breakto: "odd",

  // You can use the old LaTeX template's shorter page size (otherwise it's A4):
  //oldpagesize: true,
)

// --- Main content ---

= Introduction

#lorem(1024)

= Methods

#lorem(1024)

= Results

#lorem(1024)

= Discussion

#lorem(1024)

= Conclusions

#lorem(1024)
