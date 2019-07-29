# pretext-slides

This is the (hopefully) temporary home of slide-related 
PreTeXt transforms:

1. `pretext-revealjs.xsl` transpiles a `pretext/article/slideshow`
(using a slight extension of vanilla PreTeXt) into Reveal.js slides
3. `extract-slideshow.xsl` transpiles a `pretext/book`
into a `pretext/article/slideshow`

## pretext/article/slideshow

Look at `examples/hello-world-slides.xml` for an example of a
PreTeXt slideshow. Such slideshows may be authored directly
as these were,
or extracted almost automatically from a PreTeXt-authored
book (see below). 

You must have the following directory structure to transform
a PreTeXt slideshow source into the final product.

```
pretext
  xsl
    mathbook-common.xsl
    mathbook-html.xsl
    mathbook-latex.xsl
pretext-slides
  pretext-revealjs.xsl
  pretext-beamer.xsl
```

In particular, if your `pretext` folder still uses the deprecated
`mathbook` name, you'll need to change

```
<xsl:import href="../pretext/xsl/mathbook-html.xsl" />
```

to

```
<xsl:import href="../mathbook/xsl/mathbook-html.xsl" />
```

in `pretext-revealjs.xsl` to import via the correct path.

Alternatively, you can run the following command in the folder containing
the `mathbook` folder to create a symlink named `pretext`.

```
ln -s mathbook pretext
```

### pretext-revealjs

Run this within the `pretext-slides` folder to produce a Reveal.js slideshow:

```
xsltproc -o examples/hello-world-slides.html --xinclude pretext-revealjs.xsl examples/hello-world-slides.xml
```

Visit <https://stevenclontz.github.io/pretext-slides/hello-world-slides.html>
to see how these look.

### pretext-beamer

Run this within the `pretext-slides` folder to produce a Beamer slideshow:

```
xsltproc -o examples/hello-world-slides.tex --xinclude pretext-beamer.xsl examples/hello-world-slides.xml
```

Then run `cd examples; pdflatex hello-world-slides.tex` to build the PDF presentation.

## extract-slideshow

Without any additional configuration, 
`extract-slideshow.xsl` automatically creates
slides based on the following content of a PreTeXt book.

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
content within the book (e.g. theorems, paragraphs) that should
appear as slides. This is done by way of adding the following
attributes.

- In `<docinfo slide-defaults="foo">`, replace `foo` with a
  pipe-delimited list of default environments to become single
  slides. For example, 
  `<docinfo slide-defaults="definition|theorem">`
  would produce a single slide for each definition and theorem
  within a section.
- For each other element that you wish to include in a slide
  add `slide="single"` as an attribute. These elements must
  be direct children of a section.
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

See `examples/hello-world-book.xml` for a PreTeXt book
that is transpiled into `examples/hello-world-book-slides.xml` 
using the following command.

```
xsltproc -o examples/hello-world-book-slides.xml --xinclude extract-slideshow.xsl examples/hello-world-book.xml
```

Visit <https://stevenclontz.github.io/pretext-slides/html/> or
<https://stevenclontz.github.io/pretext-slides/hello-world-book.pdf> to
see the compiled sample book, and visit
<https://stevenclontz.github.io/pretext-slides/hello-world-book-slides.html>
to view the corresponding slides.

## Previewing the slideshow in your browser.

If you have Python 3 installed, this simple command will
spin up a local server that will allow you to view
your Reveal.js slideshow in your browser at 
<http://localhost:3000/> before you upload it to the internet.
(Honestly this is just a good trick in general; you can also
do this for PreTeXt HTML books if you want to emulate a
"real" static site server.)

```
python3 -m http.server 3000
```

## Credits

These tools were developed by Steven Clontz and
Andrew Rechnitzer during the 2019 June AIM
Workshop on PreTeXt enhancements and annual editions.
