====================
LaTeX Homework Class
====================

.. contents::
    :backlinks: none

.. sectnum::

What
====

This is a LaTeX document class. That means you use it with
``\documentclass{homework}`` at the top of the document. It provides a
document layout and some helper commands that make working with
questions easy.

Installation
============

To install this class, you can simply do:

::

    make install

This will install it in the path returned by ``kpsewhich
-var-value=TEXMFHOME``.

Usage
=====

See the `homework.tex <homework.tex>`__ file for an exhaustive list of
usage examples. There are also comments explaining features for which
there are no examples given.

The result is the following:

.. figure:: screenshot.png
   :alt: Screenshot

   Screenshot

The class file also has a bunch of helper ``\usepackage``\ s that you
might want to take a look at in `homework.cls <homework.cls>`__.

For your convenience, the file `template.tex <template.tex>`__ is a
nearly-empty LaTeX file that contains the bare essentials to get started
using the homework class.

``\question``
-------------

To start a question, just type ``\question``. It will add the text
“Question #” with a line underneath to the document. If you’d like to
change “Question” to something else, use

.. code:: tex

    \renewcommand{\questiontype}{Whatever You Want}

Similarly, if you ever need to skip numbers, you can do

.. code:: tex

    \setcounter{section}{<target number - 1>}

So, to skip to the 10th question, ``<target number - 1>`` = 9.

See `homework.tex <homework.tex>`__ for more.

.. _question-1:

``\question*``
--------------

Some classes like to give their homework questions fancy names. If this
is the case, you can use ``\question*{The Question's Name}`` to make a
named question.

See `homework.tex <homework.tex>`__ for more.

Question Parts
--------------

Another common thing on homework assignments is to have multi-part
questions. To deal with these, use the form

.. code:: tex

    \begin{alphaparts}
      \questionpart
        This will be part (a).
      \questionpart
        This will be part (b).
    \end{alphaparts}

or

.. code:: tex

    \begin{arabicparts}
      \questionpart
        This will be part x.1.
      \questionpart
        This will be part x.2.
    \end{arabicparts}

See `homework.tex <homework.tex>`__ for more.

Induction Proofs
----------------

In math classes, induction proofs come up a lot, and they almost always
have the same form: base case, induction hypothesis, and induction step.

.. code:: tex

    \begin{induction}
      \basecase
        This is my fancy base case.
      \indhyp
        Assume some claim.
      \indstep
        Finish off the proof
    \end{induction}

Anonymous Submissions
---------------------

Certain classes prefer to disassociate names from questions for a more
fair grade assessment. To have your name placed only on a separate title
page, include the ``anonymous`` option in the ``\documentclass`` line:

.. code:: latex

    \documentclass[11pt,anonymous]{homework}

For truly anonymous submissions, make sure you remove all personally
identifying information from your preamble.

One question per page
---------------------

If you’d like each question to begin on a new page, include the
``newpage`` option:

.. code:: latex

    \documentclass[11pt,newpage]{homework}

Spacious margins
----------------

To enhance the readability of your documents, you can add the
``largemargins`` option to your documents. This fits less content on a
single page, but makes it much more comfortable for your eyes to scan
across the lines.

.. code:: latex

    \documentclass[11pt,largemargins]

This is the default in the template and the example file. Remove this
option to have your text fill more space on the page.

License
=======

MIT License, see `LICENSE <LICENSE>`__.
