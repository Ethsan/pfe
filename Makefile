drawio=$(wildcard figs/*.drawio)
svg=$(patsubst %.drawio,%.svg,$(drawio))

all: report.pdf report.html

Makefile: *.typ *.bib $(svg) figs/*
	touch Makefile

report.pdf: Makefile

report.html: Makefile

%.pdf: %.typ
	typst compile $< -f pdf --features html

%.html: %.typ
	typst compile $< -f html --features html

%.svg: %.pdf
	pdf2svg $< $@

%.pdf: %.drawio
	drawio --export --format=pdf --svg-theme light --crop $<

show: report.pdf
	firefox report.pdf &

watch: 
	typst watch report.typ --features html -f pdf &
	typst watch report.typ --features html -f html

clean: 
	rm -rf *.pdf *.html
