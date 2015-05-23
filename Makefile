TARGET=/cse/htdocs/classes/sp15/cse130-a/
RSYNC=$(shell pwd)/sync.sh
USER=rjhala
HOST=login.eng.ucsd.edu

all: site
	./site rebuild

site:
	ghc --make site

rsync:
	$(RSYNC) _site/ $(USER) $(HOST) $(TARGET)


clean:
	rm -rf *.hi *.o .*.swp .*.swo site _site/ _cache/


update: local
	scp -r -p _site/* rjhala@login.eng.ucsd.edu:$(TARGET)

static:
	ssh rjhala@login.eng.ucsd.edu "chmod -R g+w $(TARGET) && chmod -R ugo+r $(TARGET)"
