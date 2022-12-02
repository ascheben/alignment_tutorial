#!/bin/bash
#PBS -V
#PBS -N cactus
#PBS -q batch
#PBS -S /bin/bash
#PBS -l mem=12G
#PBS -e /home/$USER/alignment_tutorial/cactus.err
#PBS -o /home/$USER/alignment_tutorial/cactus.out
#PBS -l nodes=1:ppn=6
#PBS -l walltime=1:00:00

date
source ~/.bash_profile
conda activate cactus
source /nas4/$USER/cactus/cactus-bin-v2.3.0/cactus_env/bin/activate

cd /home/$USER/alignment_tutorial

## Preprocessor
cactus-preprocess jobstore_ifn/0 ifn_config.txt steps-output/ifn.txt --maxCores 6 --inputNames Mmuscu Hsapie Rferru --realTimeLogging --logInfo --retryCount 0
cactus-preprocess jobstore_ifn/1 ifn_config.txt steps-output/ifn.txt --maxCores 6 --inputNames Mmyoti Pdisco Ajamai --realTimeLogging --logInfo --retryCount 0

## Alignment

### Round 0
cactus-blast jobstore_ifn/2 steps-output/ifn.txt steps-output/Anc1.cigar --maxCores 6 --root Anc1 --realTimeLogging --logInfo --retryCount 0
cactus-align jobstore_ifn/3 steps-output/ifn.txt steps-output/Anc1.cigar steps-output/Anc1.hal --maxCores 6 --root Anc1 --realTimeLogging --logInfo --retryCount 0 
hal2fasta steps-output/Anc1.hal Anc1 --hdf5InMemory > steps-output/Anc1.fa

cactus-blast jobstore_ifn/4 steps-output/ifn.txt steps-output/Anc4.cigar  --maxCores 6 --root Anc4 --realTimeLogging --logInfo --retryCount 0
cactus-align jobstore_ifn/5 steps-output/ifn.txt steps-output/Anc4.cigar steps-output/Anc4.hal  --maxCores 6 --root Anc4 --realTimeLogging --logInfo --retryCount 0
hal2fasta steps-output/Anc4.hal Anc4 --hdf5InMemory > steps-output/Anc4.fa

### Round 1
cactus-blast jobstore_ifn/6 steps-output/ifn.txt steps-output/Anc3.cigar  --maxCores 6 --root Anc3 --realTimeLogging --logInfo --retryCount 0
cactus-align jobstore_ifn/7 steps-output/ifn.txt steps-output/Anc3.cigar steps-output/Anc3.hal  --maxCores 6 --root Anc3 --realTimeLogging --logInfo --retryCount 0
hal2fasta steps-output/Anc3.hal Anc3 --hdf5InMemory > steps-output/Anc3.fa

### Round 2
cactus-blast jobstore_ifn/8 steps-output/ifn.txt steps-output/Anc2.cigar  --maxCores 6 --root Anc2 --realTimeLogging --logInfo --retryCount 0
cactus-align jobstore_ifn/9 steps-output/ifn.txt steps-output/Anc2.cigar steps-output/Anc2.hal  --maxCores 6 --root Anc2 --realTimeLogging --logInfo --retryCount 0
hal2fasta steps-output/Anc2.hal Anc2 --hdf5InMemory > steps-output/Anc2.fa

### Round 3
cactus-blast jobstore_ifn/10 steps-output/ifn.txt steps-output/Anc0.cigar  --maxCores 6 --root Anc0 --realTimeLogging --logInfo --retryCount 0
cactus-align jobstore_ifn/11 steps-output/ifn.txt steps-output/Anc0.cigar steps-output/ifn.hal  --maxCores 6 --root Anc0 --realTimeLogging --logInfo --retryCount 0
hal2fasta steps-output/ifn.hal Anc0 --hdf5InMemory > steps-output/Anc0.fa

## HAL merging
halAppendSubtree steps-output/ifn.hal steps-output/Anc2.hal Anc2 Anc2 --merge --hdf5InMemory
halAppendSubtree steps-output/ifn.hal steps-output/Anc3.hal Anc3 Anc3 --merge --hdf5InMemory
halAppendSubtree steps-output/ifn.hal steps-output/Anc1.hal Anc1 Anc1 --merge --hdf5InMemory
halAppendSubtree steps-output/ifn.hal steps-output/Anc4.hal Anc4 Anc4 --merge --hdf5InMemory




#cactus-blast jobstore_all/66 all-steps-output/all.txt all-steps-output/Anc06.cigar --maxCores 60 --root Anc06 --realTimeLogging --logInfo --retryCount 0
#cactus-align jobstore_all/67 all-steps-output/all.txt all-steps-output/Anc06.cigar all-steps-output/Anc06.hal --maxCores 60 --root Anc06 --realTimeLogging --logInfo --retryCount 0
#hal2fasta all-steps-output/Anc06.hal Anc06 --hdf5InMemory > all-steps-output/Anc06.fa

#cactus-blast jobstore_all/68 all-steps-output/all.txt all-steps-output/Anc17.cigar --maxCores 60 --root Anc17 --realTimeLogging --logInfo --retryCount 0
#cactus-align jobstore_all/69 all-steps-output/all.txt all-steps-output/Anc17.cigar all-steps-output/Anc17.hal --maxCores 60 --root Anc17 --realTimeLogging --logInfo --retryCount 0
#hal2fasta all-steps-output/Anc17.hal Anc17 --hdf5InMemory > all-steps-output/Anc17.fa


