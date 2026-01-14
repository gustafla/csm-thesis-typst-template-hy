# Typst Template for a Computer Science Master's Thesis

This template has University of Helsinki branding hard-coded into it.
If you are writing a Computer Science bachelor's or master's thesis at
University of Helsinki, it's usable as is! Otherwise you should try to find
some other template for your thesis.

[An example PDF is available here](https://gustafla.github.io/csm-thesis-typst-template-hy/example.pdf)
([typst source](https://github.com/gustafla/csm-thesis-typst-template-hy/blob/main/main.typ)).

## Usage

Import the template (clone as a git submodule or just download the `template.typ` file and the `hy-logo-ml.svg` file):
```
import "template.typ": thesis
```

Set a show rule:
```
#show: thesis.with(
  title: [My Title],
  author: "Firstname Lastname",
  ...
)
```

For comprehensive list of parameters, see the example typ file linked above.
