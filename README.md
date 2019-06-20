# pretext-slides

This is the (hopefully) temporary home of slide-related 
XML transforms:

1. `pretext-revealjs.xsl` transpiles a `pretext/slideshow`
(using our new syntax)
into Reveal.js slides
2. `pretext-beamer.xsl` similarly transpiles a `pretext/slideshow`
into a Beamer source file
3. `pretext-book-to-slides.xsl` transpiles a `pretext/book`
that has been sweetened with `slide` attributes into
a `pretext/slideshow`

## pretext/slideshow

Look at `examples/hello-world.pxt` for an example of a
PreTeXt slideshow.

Run this to produce a Reveal.js slideshow:

```
TODO
```

## pretext-book-to-slides

Without any additional configuration, 
`pretext-book-to-slides.xsl` automatically creates
slides based on the following elements of a PreTeXt book.

```
pretext
  book
    frontmatter
    chapter
      title
      section
        title
```

It is up to the author to decide the subset of additional
content within the book (e.g. theorems, paragraphs) should
appear as slides. This is done by way of adding the following
attributes.

- `slide="single"` designates an element that appears by itself
  as a single slide
- TODO:
  `slide="begin"`, `slide="continue"`, and `slide="end"` designate
  a group of elements that appear together on the same slide
- `slide-step="true"` designates that this element within a slide
  should not appear immediately when the slide is displayed,
  but will appear once all previous `slide-step="true"` elements
  are displayed and the user progresses through the slides once
  more. (That is, it is preceeded by `\pause` in Beamer, and
  is a Reveal.js `fragment`.)

Numbered elements (e.g. theorems, activities) have their
numbering preserved in the corresponding slides.

Importantly, the source of the PreTeXt book is still valid
PreTeXt and will continue to be transpiled by e.g. 
`mathbook-html` without issue.

See `examples/hello-world-book.pxt` for the PreTeXt book
that was transpiled into `hello-world-slides.pxt` using the
following command.

```
xsltproc -o hello-world-slides.xml --xinclude ../pretext-book-to-slideshow.xsl hello-world-book.xml
```

## Viewing the slideshow in your browser.

If you have Python 3 installed, this simple command will
spin up a local server that will allow you to view
your Reveal.js slideshow (or anything really) in your
browser at <http://localhost:3000>.

```
python3 -m http.server 3000
```

## Credits

These tools were developed by Steven Clontz and
Andrew Rechnitzer during the 2019 June AIM
Workshop on PreTeXt enhancements and annual editions.
