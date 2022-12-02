#Fit a neutral model using the entire alignment of the IFN region
phyloFit --out-root ifn_neutral --tree data/IFN.newick --subst-mod REV --msa-format MAF steps-output/ifn.maf
# Conduct a likelihood ratio test for conservation across the alignment
phyloP --method LRT --mode CONACC --wig-scores ifn_neutral.mod steps-output/ifn.maf
