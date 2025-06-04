drawio=$(wildcard figs/*.drawio)
svg=$(patsubst %.drawio,%.svg,$(drawio))

report.pdf: *.typ *.bib $(svg) figs/*

%.pdf: %.typ
	typst compile $<

%.svg: %.pdf
	pdf2svg $< $@

%.pdf: %.drawio
	drawio --export --format=pdf --svg-theme light --crop $<

show: report.pdf
	firefox report.pdf &

clean: 
	rm -rf *.pdf
