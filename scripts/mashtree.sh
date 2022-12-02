# compute a distance-based tree with branch lengths from a set of fasta files
mashtree --mindepth 0 --numcpus 1 data/fasta/*fa  > data/annotation/IFN_mashtree.newick
