# Importar | import
from Bio import SeqIO
import os
import numpy as np
import sys

# Crear la funció  | function is created
def calcular_estadistiques (fastq_file):
    # Obrir llista buides i numeració a 0  | open empty list and integers set to 0
    total_seq = 0
    total_bases = 0
    llarg = []
    gc_count = 0
    # Iterar | Iterate
    with open(fastq_file, "r") as handle:
        for record in SeqIO.parse(handle, "fastq"):
            seq = record.seq
            llargada_seq = len(seq)
            llarg.append(llargada_seq)
            total_bases += llargada_seq
            gc_count += sum(1 for base in seq if base in "GC")    
            total_seq += 1
        # Check per comprobar que hi ha seqüències al arxiu  | Check to make sure file is not empty
        if total_seq == 0:
            return  "No hi ha seqüències al arxiu"
            
        llarg = np.array(llarg)
        # Els càlculs a realitzar  | Calculations to perform
        contingut_GC = (gc_count/total_bases)*100
        seq_curta = np.min(llarg).item()
        seq_llarga = np.max(llarg).item()
        seq_mitjana = np.mean(llarg).item()
        seq_mediana = np.median(llarg).item()
        return{
            "Nombre total de reads": total_seq,
            "Nombre total de bases": total_bases,
            "Contingut de GC": contingut_GC,
            "Seqüència més curta":  seq_curta,
            "Seqüència més llarga": seq_llarga,
            "Llargada mitjana de les seqüències": seq_mitjana,
            "Llargada de seqüència més comú": seq_mediana
            }


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python executable.py path/to/file")
        sys.exit(1)

    # Especifiquem que l'arxiu estarà al path des d'on executem la comanda
    file_path = sys.argv[1] 
    stats = calcular_estadistiques(file_path)
    print(stats)
