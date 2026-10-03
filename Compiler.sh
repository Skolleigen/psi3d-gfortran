#!/bin/bash
#
# Compiler.sh - Build script for pSi3D
#
# Usage:
#   ./Compiler.sh              # default: gfortran (no GOTM)
#   FORTRAN_COMPILER=IFORT ./Compiler.sh   # use Intel ifort with GOTM
#
# Prerequisites (gfortran path):
#   macOS:   brew install gcc libomp   -> gfortran available as 'gfortran'
#   Linux:   apt install gfortran
#   Windows: Strawberry Perl or mingw-w64 (use gmake instead of make)

export FORTRAN_COMPILER=${FORTRAN_COMPILER:-GFORTRAN}
export SI3DDIR=${SI3DDIR:-$(dirname "$0")}

# Detect make command (gmake on Windows/Strawberry, make on Mac/Linux)
MAKE=$(command -v gmake || command -v make)
export MAKE

# GOTM settings (only used when FORTRAN_COMPILER=IFORT and IFGOTM=true)
export GOTMDIR=${GOTMDIR:-../gotm}
export MODDIR=$GOTMDIR/modules
export INCDIR=$GOTMDIR/include
export BINDIR=$GOTMDIR/bin
export LIBDIR=$GOTMDIR/lib

# IF IFGOTM=false --> turbulence/kpp stubs are used instead of GOTM libs
export IFGOTM=${IFGOTM:-false}
# IF IFSI3D=true  --> compile SI3D (always true here)
export IFSI3D=true

if $IFGOTM && [ "$FORTRAN_COMPILER" = "IFORT" ]; then
	cd $GOTMDIR/src/util
	$MAKE clean
	$MAKE
	cd $GOTMDIR/src/turbulence
	$MAKE clean
	$MAKE
fi

cd $SI3DDIR

if [ "$FORTRAN_COMPILER" = "GFORTRAN" ]; then
	$MAKE gfortran
	rm -f *.o *.mod
elif [ "$FORTRAN_COMPILER" = "IFORT" ]; then
	if $IFSI3D; then
		$MAKE omp
	else
		$MAKE si3d
	fi
	rm -f *.o
else
	echo "ERROR: Unknown FORTRAN_COMPILER=$FORTRAN_COMPILER (use GFORTRAN or IFORT)"
	exit 1
fi
