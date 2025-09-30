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
  #par(spacing: 4em, leading: 0.3em)[#text(23pt)[*#title*]]

  // Name
  #par(spacing: 3em)[#author]

  // Date
  #date.display("[month repr:long] [day], [year]")

  // Faculty
  #place(bottom + center, dy: -1em)[#text(16pt)[#smallcaps[
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
      #date.display("[month repr:long] [day], [year]")
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

  #pagebreak()
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
  bibsources: "csm_thesis.bib",
  breakto: none,
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

  #set page(
    // These were matched to the LaTeX template.
    // I don't know why it's not a full-height A4.
    width: 210mm,
    height: 272mm,
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

  #let chapterheading(it) = [
    #set text(size: 24pt)
    #set block(below: 2em)
    #it
  ]

  #show outline: it => [
    // Style table of contents heading with a larger font size and margin
    #show heading: chapterheading
    #it
  ]

  #show outline.entry.where(level: 1): set block(above: 1.5em)

  // --- Set cover pages --- 

  #coverpage(title, author, date)

  #contactpage

  #abstractpage(title, author, supervisor, date, abstract, ccs, keywords, info)
  #pagebreak()

  #outline()
  #pagebreak()
  #pagebreak()

  // --- Customize first-level (chapter) headings ---
  #let chapter = state("chapter")
  #show heading.where(level: 1): it => {
    // Style chapter headings with a larger font size and margin
    show heading: chapterheading

    {
      // Hack: insert a dummy header which decrements the page counter on blank
      // pages, which are generated when breakto == "odd" or "even".
      set page(
        header: [#counter(page).update(i => i - 1)],
        numbering: none,
        footer: none
      )
      // Always start chapter headings from a fresh page
      pagebreak(to: breakto, weak: true)
    }

    // Store heading body for headers
    chapter.update(it.body)

    it
  }

  // Restart page counter
  #counter(page).update(1)

  // Start displaying page headers
  #set page(
    header: [
      // Define helper functions
      #let pagenumbering() = [#numbering("1", counter(page).get().first())]
      #let chapternumbering() = [
        #show: upper
        #show ". ": ".  "
        #set text(style: "italic")
        Chapter
        #numbering("1.", counter(heading.where(level: 1)).get().first())
        #chapter.get()
      ]
      #let nextheading() = query(heading.where(level: 1).after(here())).first()

      // Do not show header if chapter heading is on current page
      #context if (nextheading().location().page() != here().page()) {
        // Headers have different layout depending on page side
        if(calc.even(here().page())) {
          place(left+bottom, pagenumbering())
          place(right+bottom, chapternumbering())
        } else {
          place(right+bottom, pagenumbering())
        }
      }
    ]
  )

  // --- Set main pages --- 

  #doc

  // --- Set bibliography pages --- 

  #bibliography(bibsources)
]
