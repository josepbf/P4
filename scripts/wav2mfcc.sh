#!/bin/bash

## \file

# Base name for temporary files
base=/tmp/$(basename $0).$$ 

# Ensure cleanup of temporary files on exit
trap cleanup EXIT
cleanup() {
   \rm -f $base.*
}

if [[ $# != 3 ]]; then
   echo "$0 mfcc_order input.wav output.mfcc"
   exit 1
fi
#El profesor ha dicho que en mfcc_orden haría falta el orden de analisis y el número de coeficientes
#Para hacerlo bien debería de poner dos coeficientes el número del banco del filtro y el número de coefi castrales
#lpc_order=$1
mfcc_order=$1
inputfile=$2
outputfile=$3

UBUNTU_SPTK=1
if [[ $UBUNTU_SPTK == 1 ]]; then
   # In case you install SPTK using debian package (apt-get)
   X2X="sptk x2x"
   FRAME="sptk frame"
   WINDOW="sptk window"
   MFCC="sptk mfcc"
else
   # or install SPTK building it from its source
   X2X="x2x"
   FRAME="frame"
   WINDOW="window"
   MFCC="mfcc"
fi

# Main command for feature extration
sox $inputfile -t raw -e signed -b 16 - | $X2X +sf | $FRAME -l 240 -p 80 | $WINDOW -l 240 -L 240 |
   $MFCC -l 240 -m $mfcc_order -s 8 -n 40 -w 1 > $base.mfcc 
# Pasar -n como paramtero

# Our array files need a header with the number of cols and rows:
ncol=$((mfcc_order)) # REVISAR es con +1 o sin el +1 ?????
nrow=$($X2X +fa < $base.mfcc | wc -l | perl -ne 'print $_/'$ncol', "\n";')

# Build fmatrix file by placing nrow and ncol in front, and the data after them
echo $nrow $ncol | $X2X +aI > $outputfile
cat $base.mfcc >> $outputfile

exit
