GHPAGE=../ranjitjhala.github.io/

all: site
	cp -r _site/* $(GHPAGE)
	cd $(GHPAGE)
	git commit -a -m "update page"
	git push origin master

site:
	stack build
	stack exec -- homepage rebuild

clean:
	rm -rf *.hi *.o .*.swp .*.swo site _site/ _cache/ _build/*

