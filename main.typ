#import "template.typ": thesis

#let abstract = [
  #lorem(256)
]

// Use the thesis template
#show: thesis.with(
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
