# load the cactus environment
source cactus_env/bin/activate
# Convert hal graph to linear reference in MAF format with human ref genome
hal2maf --noAncestors --refGenome Hsapie ./steps-output/ifn.hal ./steps-output/ifn.maf
# Convert hal graph to 1-1 orthologous reference-based alignment
hal2maf --noAncestors --noDupes --onlyOrthologs --refGenome Hsapie ./steps-output/ifn.hal ./steps-output/ifn_orthologous.maf
# Compute the coverage of each species with regard to human ref genome
halCoverage steps-output/ifn.hal Hsapie > steps-output/ifn.cov.txt
# Compute syntenic blocks between the human genome and the bat Artibeus jamaicensis
halSynteny --queryGenome Ajamai --targetGenome Hsapie steps-output/ifn.hal steps-output/synteny_Hsapie_Ajamai.psl
