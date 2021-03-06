#!/bin/bash

function id () {
    if [[ "$1" != "" ]]
    then
        echo $1
    else
        hash < $tmpfile.ml
    fi
}

tmpfile=$(date +tmp%Y%m%d%H%M%S%N)$RANDOM

cat > $tmpfile.ml

function hash() {
    cat | (md5 || md5sum) | sed -e 's| ./*||g'
}

if which -s ocamltohtml
then
    ocamltohtml < $tmpfile.ml > $tmpfile.html
else
    ./ocamltohtml < $tmpfile.ml > $tmpfile.html
fi
e="$(./htmlescape < $tmpfile.ml)"
echo -n "<a href=\"javascript:octry('$e');\">[try]</a>" >> $tmpfile.html

cat $tmpfile.html

rm -f $tmpfile*

