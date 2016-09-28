This repository contains templates for source code and other
file types.

A general maxim is to avoid writing [boilerplate code][1], to abstract
away common functionality into libraries and to use high-level
languages to avoid [repeating oneself][2].

Of course, some repeating elements remain, either because the
language is not as high-level as one might wish or because it is
essential.

For example, a minimal LaTeX document usually uses the same
document class (a minimal one) and likely a common package for
including random text. A cmake build specification, although
being high-level, usually follows a template. Adding licensing
information one probably cannot avoid adding boilerplate.


2016, Georg Sauthoff <mail@georg.so>


[1]: https://en.wikipedia.org/wiki/Boilerplate_code
[2]: https://en.wikipedia.org/wiki/Don't_repeat_yourself
