# Load cactus environment
source cactus_env/bin/activate
# Generate commands to run cactus in steps using a config file
cactus-prepare cactus_config.txt --outDir steps-output --outSeqFile steps-output/ifn.txt --outHal steps-output/ifn.hal
--jobStore jobstore_ifn > cactus_commands.txt
