// --- Certificate page adapted from 5_6287213409830184474.docx ---
// Populated from the current project metadata in meta.typ.
// Standalone front-matter page. Not included in report.typ yet.
#import "../meta.typ": *
#[
  #set page(
    paper: "a4",
    margin: (top: 72pt, bottom: 58.5pt, left: 54pt, right: 54pt),
    header: none,
    footer: none,
  )
  #set text(font: "Times New Roman", size: 12pt, hyphenate: false)
  #set par(leading: 0pt, spacing: 0pt)

  #let cl(size, body, weight: "regular", fill: black) = align(center, text(size: size, weight: weight, fill: fill)[#body])
  #let purple = rgb("#7030a0")
  #let cert_authors = authors.map(a => a.prefix + "\u{00A0}" + a.name).join(", ")

  // -- college header --
  #cl(14pt, weight: "bold", fill: rgb("#c00000"))[#college_upper]
  #v(9.66pt)
  #cl(10pt)[#college_unit]
  #v(6.05pt)
  #cl(9pt, fill: rgb("#0000ff"))[#affiliation]
  #v(5.79pt)
  #cl(12pt)[Nehru Nagar, Puttur #text(fill: rgb("#ff0000"))[-] 574203, DK, Karnataka, India]

  // -- department, logo, certificate --
  #v(23.09pt)
  #cl(13pt, weight: "bold", fill: rgb("#0070c0"))[DEPARTMENT OF #department_upper]
  #v(9.58pt)
  #align(center, image("../assets/vcet_logo.png", width: 163.34pt, height: 101.06pt))
  #v(11.7pt)
  #cl(18pt, weight: "bold")[CERTIFICATE]
  #v(18.61pt)

  // -- certificate body --
  #block(width: 100%)[
    #set par(justify: true, leading: 12.4pt, spacing: 0pt)
    #set text(size: 12pt, hyphenate: false)
    This is to certify that #text(weight: "bold")[“#text(fill: rgb("#ff0000"))[#project_title]”] submitted~by #text(weight: "bold", fill: purple)[#cert_authors] bearing USNs #text(weight: "bold", fill: purple)[#usns.at(0), #usn_rest and #usn_last] to the #university_name, #university_city, in partial fulfillment for the award of the degree of #text(weight: "bold", fill: purple)[#degree] in #text(weight: "bold", fill: rgb("#002060"))[#department] is a #emph[bonafide] record of project work carried out by them under my supervision. The contents of this report, in full or in parts, have not been submitted to any other Institution or University for the award of any degree.
  ]

  // -- guide signature --
  #v(71.3pt)
  #grid(
    columns: (342pt, 1fr),
    column-gutter: 0pt,
    [],
    [
      #("_" * 22)
      #v(33.38pt)
      #pad(left: 5.4pt)[
        #set par(leading: 0pt, spacing: 0pt)
        #text(size: 12pt, weight: "bold")[Signature of the Guide]
        #v(12.57pt)
        #text(size: 12pt, weight: "bold")[#guide]
        #v(12.57pt)
        #text(size: 12pt, weight: "bold")[Department of AI & ML]
        #v(12.57pt)
        #text(size: 12pt, weight: "bold")[#college_short #college_place]
      ]
    ],
  )
]

#pagebreak()
