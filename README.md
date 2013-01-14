# Racket mode for GNU Emacs

This is a major mode for editing Racket source files, as well as an
inferior mode for running Racket.

## Goals

- Focus on Racket (not various current and historical Schemes).

- Fontify all Racket keywords, builtins, self-evals, and so on.

- Fontify variations of `define` for functions and variables.

- Use DrRacket concepts where applicable.

- Compatible with Emacs 23.4 and 24.2+.

- Compatible with whichever one you prefer:

  - [Geiser](http://www.nongnu.org/geiser/).

  - Racket's [XREPL](http://docs.racket-lang.org/xrepl/index.html)
    (e.g. to use XREPL commands like `,log`).

## Caveats

This is version 0.1. My total experience writing Emacs modes consists
of writing this mode. Pull requests from smarter/wiser people are
welcome!

Please report issues to the [GitHub project page](https://www.github.com/greghendershott/racket-mode).

## Motivation

I started this project accidentally, while trying to figure out a
font-lock issue with Quack under Emacs 24.2.

Knowing nothing about how to make a mode in Emacs, I tried to isolate
the problem by making a simple major mode, then adding things until it
broke. Intead I ended up with this.

I took various `.emacs.d` hacks that I'd previously made to use with
Quack, and rolled them into this mode.

Also, I'd recently spent time adding Racket fontification to the
Pygments project.

Finally, I remembered that when I was new to Racket and Emacs, I got
confused by the _Scheme_ menu. It has options that work with various
Schemes over the years, but which are N/A for Racket. I figured a
fresh focus on Racket might be helpful.

Note: I think DrRacket is a _wonderful_ environment for developing
Racket. I started using Emacs when projects needed me to edit various
other file formats (like JavaScript, HTML, CSS, Markdown) in addition
to Racket.

## Acknowledgements

- Obviously the existing Emacs Scheme mode and Inferior Scheme mode.

- The source code for Neil Van Dyke's Quack provided a model for
  many of the scheme-indent-function settings, and smart paren closing.
