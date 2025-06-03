#!/bin/bash
# Crear directori d'output / create output directories
output_dir="./preprocessar"
output_nanoplots="./preprocessar/nanoplots"
output_fastqc="./preprocessar/fastqc"

mkdir -p "$output_dir"
mkdir -p "$output_nanoplots"
mkdir -p "$output_fastqc"


echo "començant el chopper" 
# Selecció de seqüències per qualitat de base i llargada / Selection of sequences based on base quality and length
for file in *.fastq; do
    nom_arxiu=$(basename "$file" .fastq)
    # Comprovació que agafa l'arxiu correscte
    if [[ -z "$nom_arxiu" ]]; then
        echo "Error: No s'ha obtingut el nom base del fitxer." >&2
        return 1
    fi

    # Treiem seqüències de menys de 500bp i qualitat de 10 | Filter out sequences with length under 500bp quality scores under 10
    # Per diferents especificacions visita https://github.com/wdecoster/chopper
    chopper -i "$file" -l 500 -q 10 > "$output_dir/${nom_arxiu}_chop.fastq" -t 8
done

echo "començant els Nanoplots" 
# Es fa nanoplot com a control de qualitat / Nanoplots are used as quality control
for file in ./preprocessar/*.fastq; do
    nom_arxiu_np=$(basename "$file" .fastq)
    if [[ -z "$nom_arxiu_np" ]]; then
        echo "Error: No s'ha obtingut el nom base del fitxer." >&2
        return 1
    fi   
    # Es fan els NanoPlot / Run NanoPlot
    # Per diferents especificacions visita: https://github.com/wdecoster/NanoPlot
    NanoPlot --fastq "$file" \
        -o "$output_nanoplots/${nom_arxiu_np}" \
        -t 8 \
        --colormap summer \
        --plot kde dot \
        --N50 \
        --title "Nanoplot $nom_arxiu_np"

done

echo "començant els FastQC" 
# Finalment fem el FastQC / Run fastQC
for file in ./preprocessar/*.fastq; do
    nom_arxiu_fq=$(basename "$file" .fastq)
    if [[ -z "$nom_arxiu_fq" ]]; then
        echo "Error: No s'ha obtingut el nom base del fitxer." >&2
        return 1
    fi
    #Fem el fastqc / Run fastQC
    # Per altres especificacions visita: https://www.bioinformatics.babraham.ac.uk/projects/fastqc/
    fastqc "$file" -o "$output_fastqc" -t 20
done