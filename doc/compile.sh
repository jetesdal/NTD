#!/bin/sh

pdflatex doc.tex
bibtex doc.aux
pdflatex doc.tex
pdflatex doc.tex

rm doc.aux
rm doc.bbl
rm doc.blg
rm doc.log