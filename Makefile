TARGET=/cse/htdocs/classes/sp15/cse130-a/
RSYNC=$(shell pwd)/sync.sh
USER=rjhala
HOST=login.eng.ucsd.edu
HAKYLL=website
BIBLIO=./biblio.hs
BIB=templates/bib.json
BIBT=templates/bib.template
PUBMD=pubs.markdown
RESBMD=research-base.markdown
RESMD=research.markdown

all: bib $(HAKYLL)
	./$(HAKYLL) rebuild

$(HAKYLL): $(HAKYLL).hs
	ghc --make $(HAKYLL)

bib: $(BIBLIO) $(RESBMD) $(BIB)
	$(BIBLIO) $(BIBT) $(BIB) $(PUBMD)
	cat $(RESBMD) $(PUBMD) > $(RESMD)

rsync:
	$(RSYNC) _site/ $(USER) $(HOST) $(TARGET)

clean:
	rm -rf *.hi *.o .*.swp .*.swo site _site/ _cache/

update: local
	scp -r -p _site/* rjhala@login.eng.ucsd.edu:$(TARGET)

static:
	ssh rjhala@login.eng.ucsd.edu "chmod -R g+w $(TARGET) && chmod -R ugo+r $(TARGET)"
