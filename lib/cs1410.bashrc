##########################
# BASH CONFIG FOR CS1410 #
##########################

# Aliases

## For copying bitstreams
alias xb='cp -v $(find . -type f -name "*bit")'

## For preventing vivado from creating logs in the home dir
alias viv='mkdir -p ~/.vivado && vivado -log ~/.vivado/vivado.log -applog -journal ~/.vivado/vivado.jou -appjournal'

# Environment Variables
export CS1410_TERM=1

# MAC USERS: UNCOMMENT THE NEXT THREE LINES
#export PYTHONPATH=~/cs1410_lab/lib/macOS:$PYTHONPATH
#export DYLD_LIBRARY_PATH=~/cs1410_lab/lib/macOS:$DYLD_LIBRARY_PATH
#install_name_tool -add_rpath ~/cs1410_lab/lib/macOS/ ~/cs1410_lab/lib/macOS/_ok.so
