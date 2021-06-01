#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

data=$base/data

tools=$base/tools

vocabularybpe=$base/vocabularybpe
mkdir -p $vocabularybpe

models_bpe=$base/models_bpe
mkdir -p $models_bpe

# Learn BPE model, vocabulary size of 2000
subword-nmt learn-joint-bpe-and-vocab \
-i $data/subsampled.tokenized.en-de.en $data/subsampled.tokenized.en-de.de \
--write-vocabulary $vocabulary/bpe_en_vocabulary $vocabulary/bpe_de_vocabulary\
-s 2000 --total-symbols -o $models_bpe/bpe_saved

# Apply BPE model to en, training
subword-nmt apply-bpe -c $models_bpe/bpe_saved \
--vocabulary $vocabulary/bpe_en_vocabulary \
--vocabulary-threshold 10 \
< $data/subsampled.tokenized.en-de.en > $data/st.bpe.en-de.en

# Apply BPE model to de, training
subword-nmt apply-bpe -c $models_bpe/bpe_saved \
--vocabulary $vocabulary/bpe_de_vocabulary \
--vocabulary-threshold 10 \
< $data/subsampled.tokenized.en-de.de > $data/st.bpe.en-de.de

# Apply BPE model to en, dev
subword-nmt apply-bpe -c $models_bpe/bpe_saved \
--vocabulary $vocabulary/bpe_en_vocabulary \
--vocabulary-threshold 10 \
< $data/dev.tokenized.en-de.en > $data/dev.bpe.en-de.en

# Apply BPE model to de, dev
subword-nmt apply-bpe -c $models_bpe/bpe_saved \
--vocabulary $vocabulary/bpe_de_vocabulary \
--vocabulary-threshold 10 \
< $data/dev.tokenized.en-de.de > $data/dev.bpe.en-de.de

# Apply BPE model to en, test
subword-nmt apply-bpe -c $models_bpe/bpe_saved \
--vocabulary $vocabulary/bpe_en_vocabulary \
--vocabulary-threshold 10 \
< $data/test.tokenized.en-de.en > $data/dev.bpe.en-de.en

# Apply BPE model to de, test
subword-nmt apply-bpe -c $models_bpe/bpe_saved \
--vocabulary $vocabulary/bpe_de_vocabulary \
--vocabulary-threshold 10 \
< $data/test.tokenized.en-de.de > $data/dev.bpe.en-de.de

# Build a single vocab file before training
python $tools/joeynmt/scripts/build_vocab.py \
$data/st.bpe.en-de.en $data/st.bpe.en-de.de \
--output_path $vocabulary/vocabulary_en_de_for_training
