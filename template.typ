#let coverpage(
  title,
  author,
  date,
) = [
  #set text(14pt)
  #set align(center)
  #set par(justify: false)
  
  // Logo
  #block(below: 2em)[#image("hy-logo-ml.svg", width: 32%)]

  // Classification
  #par[Master's thesis]

  // Programme
  #par[Master's Programme in Computer Science]

  // Title
  #par(spacing: 68pt, leading: 0.3em)[#text(23pt)[*#title*]]

  // Name
  #par(spacing: 32pt)[#author]

  // Date
  #date.display("[month repr:long] [day], [year]")

  // Faculty
  #place(bottom + center, dy: -10pt)[#text(16pt)[#smallcaps[
  Faculty of Science\
  University of Helsinki
  ]]]

  #pagebreak()
]

#let contactpage = [
  #set par(spacing: 3em)
  #set text(12pt)
  *Contact information*

  #block(inset: (x: 2em))[
    P. O. Box 68 (Pietari Kalmin katu 5)\
    00014 University of Helsinki, Finland
  
    Email address: #link("mailto:info@cs.helsinki.fi")\
    URL: #link("http://www.cs.helsinki.fi/")
  ]
  #pagebreak()
]

#let abstractpage(
  title,
  author,
  supervisor,
  date,
  abstract,
  ccs,
  keywords,
  info,
) = [
  #set text(14.3333pt)
  #smallcaps[helsingin yliopisto -- helsingfors universitet -- university of helsinki]

  #let celldesc(body) = {
    text(8pt)[#body]
    parbreak()
  }
  #set par(spacing: 1em)
  #set text(10pt)
  #block(above: 0.5em)[#table(
    columns: 6 * (1fr, ),
    rows: 20 * (1fr, ),
    stroke: 0.5pt,
    table.cell(colspan: 3)[
      #celldesc[Tiedekunta --- Fakultet --- Faculty]
      Faculty of Science
    ],
    table.cell(colspan: 3)[
      #celldesc[Koulutusohjelma --- Utbildningsprogram --- Study programme]
      Master's Programme in Computer Science
    ],
    table.cell(colspan: 6)[
      #celldesc[Tekijä --- Författare --- Author]
      #author
    ],
    table.cell(colspan: 6)[
      #celldesc[Työn nimi --- Arbetets titel --- Title]
      #title
    ],
    table.cell(colspan: 6)[
      #celldesc[Ohjaajat --- Handledare --- Supervisors]
      #supervisor
    ],
    table.cell(colspan: 2)[
      #celldesc[Työn laji --- Arbetets art --- Level]
      Master's thesis
    ],
    table.cell(colspan: 2)[
      #celldesc[Aika --- Datum --- Month and year]
      #context document.date.display("[month repr:long] [day], [year]")
    ],
    table.cell(colspan: 2)[
      #celldesc[Sivumäärä --- Sidoantal --- Number of pages]
      #context counter(page).final().first() pages
    ],
    table.cell(colspan: 6, rowspan: 12)[
      #celldesc[Tiivistelmä --- Referat --- Abstract]
      #block(above: 2em, inset: (x: 2em))[
        #abstract

        #v(1fr)
        *ACM Computing Classification System (CCS)*\
        #ccs
      ]
    ],
    table.cell(colspan: 6)[
      #celldesc[Avainsanat --- Nyckelord--- Keywords]
      #keywords
    ],
    table.cell(colspan: 6)[
      #celldesc[Säilytyspaikka --- Förvaringsställe --- Where deposited]
      Helsinki University Library
    ],
    table.cell(colspan: 6)[
      #celldesc[Muita tietoja --- Övriga uppgifter --- Additional information]
      #info
    ]
  )]
]

#let thesis(
  title: none,
  author: (),
  supervisor: (),
  date: datetime.today(),
  lang: "en",
  region: "GB",
  abstract: [],
  ccs: [],
  keywords: (),
  info: [],
  doc,
) = [
  #let author = if (type(author) == array) {
    author.join(", ", last: " and ")
  } else {author}
  #let supervisor = if (type(supervisor) == array) {
    supervisor.join(", ")
  } else {supervisor}
  #let keywords = if (type(keywords) == array) {
    keywords.join(", ")
  } else {keywords}

  #set document(
    title: title,
    author: author,
    date: date,
  )

  #set text(
    lang: lang,
    region: region,
    size: 12pt,
  )

  #set par(
    leading: 0.8em,
    justify: true,
  )

  #set heading(numbering: "1.1 ")

  #show heading.where(level: 1): it => {
    // Style section headings with a larger font size and margin
    set text(size: 24pt)
    set block(below: 2em)

    {
      // Hack: insert a dummy header which decrements page counter on blank pages
      set page(
        header: [#counter(page).update(i => i - 1)],
        numbering: none,
        footer: none
      )
      // Always start section headings from a fresh, even-numbered page
      pagebreak(to: "even", weak: true)
    }

    it
  }

  #set page(
    paper: "a4",
  )

  #coverpage(title, author, date)

  #contactpage

  #abstractpage(title, author, supervisor, date, abstract, ccs, keywords, info)

  #outline()

  // Restart page counter and start displaying page numbering
  #counter(page).update(1)
  #set page(
    numbering: "1",
  )

  #doc

  #bibliography("csm_thesis.bib")
]
