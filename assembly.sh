#!/bin/bash
# Mirem si s'ha donat l'imput / Check if input is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 path/to/data"
    exit 1
fi
# Input basecalls file (FASTQ/FASTA)
basecalls="$1"

# Crear directori d'output / create output directories
output_flye="./assembly"
output_polishing="./polishing"
output_busco="./assembly_quality_control"

mkdir -p "$output_flye"
mkdir -p "$output_polishing"
mkdir -p "$output_busco"

# Utilitzem Flye assembly / Run Flye assembly
# Per altres especificacions visita: https://github.com/mikolmogorov/Flye 
echo "Iniciant l'assembly amb Flye"
flye --nano-corr "$basecalls" -o "$output_flye" --genome-size 180m --scaffold
if [ $? -ne 0 ]; then
    echo "Flye assembly ha fallat."
    exit 1
fi
# s'agafa l'assembly / get the assembly file
assembly="${output_flye}/assembly.fasta"

# Medaka consensus polishing
# Per altres especificacions visita: https://github.com/nanoporetech/medaka 
echo "Iniciant Medaka polishing..."
medaka_consensus -i "$basecalls" -d "$assembly" -o "$output_polishing" -t 8
if [ $? -ne 0 ]; then
    echo "Medaka polishing ha fallat."
    exit 1
fi
echo "S'ha completat l'assemblatge del genoma"

# S'agafa el arxiu dels consensus / get the consensus file
consensus="${output_polishing}/consensus.fasta"

# S'utilitza BUSCO per fer un anàlisi de la qualitat del genoma assemblat / run an analysis with BUSCO
# Per altres especificacions visita: https://busco.ezlab.org/
busco -i "$consensus" -m genome -c 8 -o "$output_busco" -f -l drosophila_odb12 