all: gfortran

clean:
	rm -f *.o *.mod psi3d psi3d.exe

gfortran:
	gfortran -fopenmp -O2 -fallow-argument-mismatch -fallow-invalid-boz -ffixed-line-length-none -ffree-line-length-none -c turbulence_stub.f90 kpp_stub.f90 mtridiagonal_stub.f90 eqstate_stub.f90
	gfortran -fopenmp -O2 -fallow-argument-mismatch -std=legacy -ffixed-line-length-none -c nspcg.f PlumeModels.f
	gfortran -fopenmp -O2 -fallow-argument-mismatch -fallow-invalid-boz -ffree-line-length-none -c si3d_types.f90 si3d_stwave.f90 si3d_sed.f90 si3d_Hg.f90 si3d_wq.f90 si3d_ecomod.f90 si3d_utils.f90 si3d_boundaryconditions.f90 si3d_mixing.f90
	gfortran -fopenmp -O2 -fallow-argument-mismatch -fallow-invalid-boz -ffree-line-length-none -fdec -c si3d_procedures.f90 si3d.f90
	gfortran -fopenmp -O2 -fallow-argument-mismatch -o psi3d *.o
omp:
	ifort -qopenmp -qopenmp-link=static -module $(MODDIR) -I$(INCDIR) nspcg.f PlumeModels.f si3d_types.f90 si3d_stwave.f90 si3d_sed.f90 si3d_Hg.f90 si3d_wq.f90 si3d_ecomod.f90 si3d_utils.f90 si3d_boundaryconditions.f90 si3d_mixing.f90 si3d_procedures.f90 si3d.f90 -c
	ifort -qopenmp -qopenmp-link=static -o psi3d *.o -module $(MODDIR) -I$(INCDIR) -L$(LIBDIR) -lturbulence_prod -lutil_prod
sec:
	ifort -qopenmp -module $(MODDIR) -I/$(INCDIR) nspcg.f PlumeModels.f si3d_types.f90 si3d_ecomod.f90 si3d_boundaryconditions.f90 si3d_mixing.f90 si3d_procedures.f90 si3d.f90 -c -O2
	ifort -qopenmp -o psi3d *.o -module $(MODDIR) -I/$(INCDIR) -L/$(LIBDIR) -lturbulence_prod -lutil_prod -O2
old:
	ifort -I/opt/mpich2/gnu/include -I/opt/mpich2/gnu/include -L/opt/mpich2/gnu/lib -L/opt/mpich2/gnu/lib -lmpichf90 -Wl,-rpath -Wl,/opt/mpich2/gnu/lib -lmpichf90 -lmpich -lopa -lpthread -lrt -luuid -lrt -o psi3d si3d_types.f90 si3d_utils.f90 si3d_mixing.f90 si3d_boundaryconditions.f90 si3d_procedures.f90 nspcg.f PlumeModels.f si3d.f90 -lm -qopenmp -O2
mpi:
	mpif90 -qopenmp -qopenmp-link=static si3d_types.f90 si3d_utils.f90 si3d_mixing.f90 si3d_boundaryconditions.f90 si3d_procedures.f90 nspcg.f PlumeModels.f si3d.f90 -g -O2
mmm:
	mpif90-vt -c -vt:f90 ifort -auto -qopenmp -qopenmp-link=static si3d_types.f90 si3d_utils.f90 si3d_mixing.f90 si3d_boundaryconditions.f90 si3d_procedures.f90 nspcg.f PlumeModels.f si3d.f90 -g -O2
mpich:
	/opt/mpich2-1.2/bin/mpif90 -qopenmp -qopenmp-link=static si3d_types.f90 si3d_utils.f90 si3d_mixing.f90 si3d_boundaryconditions.f90 si3d_procedures.f90 nspcg.f PlumeModels.f si3d.f90 -g -O2
