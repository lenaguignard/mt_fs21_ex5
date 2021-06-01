#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

data=$base/data

src=en
trg=de
#mkdir -p $data

# Tokenize german training data
cat data/subsampled.en-de.de | tools/moses-scripts/scripts/tokenizer/tokenizer.perl -l de > data/subsampled.tokenized.en-de.de

# Tokenize english training data
cat data/subsampled.en-de.en | tools/moses-scripts/scripts/tokenizer/tokenizer.perl -l en > data/subsampled.tokenized.en-de.en

# Tokenize german dev data
cat data/dev.en-de.de | tools/moses-scripts/scripts/tokenizer/tokenizer.perl -l de > data/dev.tokenized.en-de.de

# Tokenize english dev data
cat data/dev.en-de.en| tools/moses-scripts/scripts/tokenizer/tokenizer.perl -l en > data/dev.tokenized.en-de.en

# Tokenize german test data
cat data/test.en-de.de | tools/moses-scripts/scripts/tokenizer/tokenizer.perl -l de > data/test.tokenized.en-de.de

# Tokenize english test data
cat data/test.en-de.en | tools/moses-scripts/scripts/tokenizer/tokenizer.perl -l en > data/test.tokenized.en-de.en


echo "tokenized data"
