#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

data=$base/data
#shared_models=$base/shared_models


paste -d'|' $data/train.en-de.de $data/train.en-de.en | cat -n | shuf -n 100000 | sort -n | cut -f2 > $data/temptrain.en-de
cut -d'|' -f1 $data/temptrain.en-de > $data/subsampled.en-de.de
cut -d'|' -f2 $data/temptrain.en-de > $data/subsampled.en-de.en


echo "subsampled training data"
