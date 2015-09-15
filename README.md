README
======

Build
-----

```
$ stack build
$ stack exec -- homepage rebuild
$ cp -r _site/* ../ranjitjhala.github.io/
$ cd ../ranjitjhala.github.io/
$ git push origin master
```

Update
------

+ **Content** `pages/*.markdown`

+ **Code**    `src/Main.hs`
