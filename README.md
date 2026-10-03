# pSi3D


pSi3D is a semi-implicit 3D hydrodynamic model written in Fortran 90 and parallelized for computation across CPU threads using the OpenMP directive framework. For more technical details regarding governing equations and numerical schemes, see [this paper](https://pubs.usgs.gov/of/2006/1004/pdf/ofr2006-1004.pdf).

## Installation

### macOS / Linux (gfortran — recommended)

Install `gfortran` and run:

```bash
# macOS
brew install gcc libomp

# Ubuntu/Debian
sudo apt install gfortran

# Clone and build
git clone https://github.com/SI3DL/psi3d.git
cd psi3d
bash ./Compiler.sh        # uses gfortran by default
```

This creates a `psi3d` binary in the working directory. You may need `chmod +x psi3d` to make it executable.

### Windows (gfortran via Strawberry Perl)

1. Install [Strawberry Perl](https://strawberryperl.com/) — includes `gfortran` and `gmake`
2. Open a Git Bash terminal and run:

```bash
git clone https://github.com/SI3DL/psi3d.git
cd psi3d
gmake gfortran
```

This creates `psi3d.exe` in the working directory.

### Intel Fortran (ifort) — advanced

Requires the [Intel oneAPI HPC Toolkit](https://www.intel.com/content/www/us/en/developer/tools/oneapi/hpc-toolkit-download.html). To use it:

```bash
FORTRAN_COMPILER=IFORT bash ./Compiler.sh
```

## Quickstart

The pSi3D repository comes with template input files for setting up a model (`./SampleFiles/`) as well as an sample model run (`./sampleRuns/windDrivenFlow`). Details for this sample model are included as a `readme.txt` file in its subdirectory.

To run the sample model, simply copy the `psi3d` binary to the sample run directory and execute it:

```
cp ./psi3d ./sampleRuns/windDrivenFlow/
cd ./sampleRuns/windDrivenFlow/
./psi3d
```

The terminal will stream information as the program runs and model logs/outputs will be stored in the working directory.

## Documentation

For more details regarding how to setup models, prepare input files, and analyze outputs, see the [Si3D user manual](./docs/SI3D_UserManual_final_2011.pdf).

## Troubleshooting

Users are welcome to report any issues/bugs on the GitHub [Issues page](https://github.com/SI3DL/psi3d/issues).

## Contributing

Contributions to pSi3D are welcome. Please reach out to the current developers for contribution guidelines.
