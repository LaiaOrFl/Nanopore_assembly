# ASSEMBLATGE DE GENOMES DE NOVO AMB NANOPORE: Estratègies per a genomes de baixa cobertura / ASSEMBLY OF DE NOVO GENOMES WITH NANOPORE: Strategies for low coverage genomes

## Sobre el treball
Benvingut/da, 
Aquest repositori conté el codi desenvolupat durant la realització del TFM sobre a l'anàlisi de seqüències llargues procedents de seqüenciació amb Oxford Nanopore, això inclou:
- Markdown que conté tots els passos de la pipeline desenvolupada
- Arxius executables .sh i .py

Sobre la pipeline:
Aquesta pipeline s'especialitza en l'assemblatge de novo de genomes amb seqüències procedents de Nanopore. El procès s'inicia amb un control d'estadístiques bàsiques de les dades, seguidament el preprocessat de les dades, mitjançant Chopper i els controls de qualitat amb FastQC i Nanoplot. L'assemblatge del genoma i el pas de bastida de l'assemblatge es realitzen amb Flye, es poleix l'assemblatge amb Medaka consensus i s'avalua el resultat amb BUSCO. Finalment s'utilitza Braker per a fer anotació de gens conjuntament amb dades de proteines d'artròpodes. 

El codi conté especificacions per a Drosophila melanogaster, modificar segons l'espècie i les dades utilitzades.

## About
Welcome,
This repository contains the code developed during the completion of my master thesis about the analysis of long reads from sequencing with Oxford Nanopore, this includes:
- Markdown containing all steps of the developed pipeline
- Executable files .sh and .py

About the pipeline:
This pipeline specializes in the de novo assembly of genomes using ONT long reads. The process begins with a control of basic data statistics, next, the pre-processing of data, through Chopper and quality controls with FastQC and Nanoplot. Genome assembly and scaffolding are performed with Flye, then polished with Medaka consensus and the result is evaluated with BUSCO. Finally, Braker is used to annotate genes using a database of Arthoropod proteins.

The code contains specifications for Drosophila melanogaster, to be changed according with the species and the data used.

## Eines externes utilitzades per ordre d'aparició / External tools used in order of occurrence
Chopper - https://github.com/wdecoster/chopper
Nanoplot - https://github.com/wdecoster/NanoPlot
FastQC - https://www.bioinformatics.babraham.ac.uk/projects/fastqc/
MultiQC - https://github.com/MultiQC/MultiQC
Flye - https://github.com/mikolmogorov/Flye
Medaka - https://github.com/nanoporetech/medaka
BUSCO - https://busco.ezlab.org/
Braker - https://github.com/Gaius-Augustus/BRAKER
