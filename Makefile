all: matinale.pdf nistws.pdf

spa.pdf: spa.gpi
	@gnuplot $<

animated_cat: graphics/keyboard_cat.gif
	@mkdir -p animated_cat
	@convert $< animated_cat/keyboard_cat-%d.png

nistws.pdf: nistws.tex spa.pdf animated_cat
	@pdflatex $<; if [ $$? -ne 0 ]; then rm -rf $@; fi
	@pdflatex $<; if [ $$? -ne 0 ]; then rm -rf $@; fi

matinale.pdf: matinale.tex spa.pdf animated_cat
	@pdflatex $<; if [ $$? -ne 0 ]; then rm -rf $@; fi
	@pdflatex $<; if [ $$? -ne 0 ]; then rm -rf $@; fi

clean:
	@rm -rf matinale.pdf nistws.pdf
	@rm -rf *.aux *.log *.nav *.out *.snm *.toc

distclean: clean
	@rm -rf spa.pdf animated_cat

.PHONY: clean distclean
