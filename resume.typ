// ============================================================
// Developer / Computer Science Resume Template (Typst)
// ============================================================
// Usage: edit the values in the `data.typ` file,
// then compile with:  typst compile resume.typ
// ============================================================
#import "data_fr.typ": name, role, email, phone, city, website, github, linkedin, skills, experiences, projects, education_entries, certifications

#let accent = rgb("#1f4e8c")
#let muted = rgb("#5a5a5a")

#set page(
  margin: (top: 1.6cm, bottom: 1.6cm, left: 1.8cm, right: 1.8cm),
)
#set text(font: "Liberation Sans", size: 10pt, fill: rgb("#1a1a1a"))
#set par(justify: false, leading: 0.55em)

// ---------- helper components ----------

#let heading-bar(title) = {
  v(6pt)
  text(size: 11.5pt, weight: "bold", fill: accent, tracking: 0.5pt)[#upper(title)]
  v(-4pt)
  line(length: 100%, stroke: 0.6pt + accent)
  v(4pt)
}

#let entry(title, subtitle, dates, location, bullets: (), tags: none) = {
  grid(
    columns: (1fr, auto),
    align: (left, right),
    [ *#title* #if subtitle != none [ #h(4pt) #text(fill: muted)[— #subtitle, #location] ] ],
    [ #text(size: 9pt, fill: muted)[#dates] ],
  )
  if tags != none {
    v(2pt)
    text(size: 9pt, fill: muted)[#tags]
    v(2pt)
  }
  if bullets.len() > 0 {
    v(2pt)
    for b in bullets {
      grid(
        columns: (10pt, 1fr),
        [•], [#text(size: 9.6pt)[#b]],
      )
    }
  }
  v(8pt)
}

#let skill-row(category, items) = {
  grid(
    columns: (auto, 1fr),
    column-gutter: 8pt,
    [ *#category:* ], [ #items ],
  )
  v(3pt)
}

// ---------- header ----------
// Two columns: left = personal info, right = photo.
// `photo` should be a path string defined in data.typ, e.g. photo: "photo.jpg"
// If you don't want a photo, set `photo: none` in data.typ and this will
// leave the space empty instead of erroring.

#grid(
  columns: (1fr, auto),
  column-gutter: 24pt,
  align: (left + horizon, right + horizon),

  // ---- left column: info ----
  [
    #text(size: 22pt, weight: "bold")[#name]
    #v(2pt)
    #text(size: 12.5pt, fill: muted)[#role]
    #v(8pt)
    #text(size: 10pt)[
      #email \
      #phone #h(4pt) | #h(4pt) #city \
      #link(website)[#website.replace("https://", "")] \
      #link(github)[#github.replace("https://", "")] \
      #link(linkedin)[#linkedin.replace("https://", "")]
    ]
  ],

  // ---- right column: photo ----
  [
    #box(
      clip: true,
      radius: 4pt,
      stroke: 0.6pt + muted,
    )[
      #image("img/portrait.jpg", width: 6cm, height: 7cm, fit: "cover")
    ]
  ]
)

// ---------- skills ----------
#heading-bar("Compétences techniques")
#for skill in skills {
  skill-row(skill.category, skill.items)
}

// ---------- education ----------
#heading-bar("Formation")

#for edu in education_entries {
  entry(
    edu.title, edu.subtitle,
    edu.dates, edu.location,
    bullets: edu.bullets
  )
}

// ---------- experience ----------
#heading-bar("Expériences professionnelles")

#for exp in experiences {
  entry(
    exp.title, exp.subtitle,
    exp.dates, exp.location,
    bullets: exp.bullets
  )
}

// ---------- projects ----------
#if projects != () {
  heading-bar("Projets")

  for p in projects {
    entry(
      p.title, p.subtitle,
      p.dates, p.location,
      bullets: p.bullets,
      tags: p.tags
    )
  }
}

// ---------- optional: certifications ----------
#if certifications !=  [] {
  heading-bar("Certifications")
  text(size: 9.6pt)[#certifications]
}
