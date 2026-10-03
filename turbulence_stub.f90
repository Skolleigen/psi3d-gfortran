! Stub turbulence module - satisfies USE turbulence when iturb /= -1
MODULE turbulence
  IMPLICIT NONE
  INTEGER           :: turb_method = 0
  DOUBLE PRECISION  :: kappa = 0.4d0
  DOUBLE PRECISION  :: const_num = 1.0d-4
  DOUBLE PRECISION  :: const_nuh = 1.0d-4
  DOUBLE PRECISION  :: gamu = 0.0d0, gamv = 0.0d0, gamh = 0.0d0, gams = 0.0d0
  DOUBLE PRECISION, ALLOCATABLE :: num(:), nuh(:), nus(:)
  DOUBLE PRECISION, ALLOCATABLE :: eps(:), L(:), tke(:), tkeo(:)
CONTAINS
  SUBROUTINE init_turbulence(unit, nml, nlev)
    INTEGER, INTENT(in) :: unit, nlev
    CHARACTER(*), INTENT(in) :: nml
  END SUBROUTINE
  SUBROUTINE do_turbulence(nlev, dt, depth, u_taus, u_taub, z0s, z0b, h, NN, SS)
    INTEGER, INTENT(in) :: nlev
    DOUBLE PRECISION, INTENT(in) :: dt, depth, u_taus, u_taub, z0s, z0b
    DOUBLE PRECISION, INTENT(in) :: h(0:nlev), NN(0:nlev), SS(0:nlev)
  END SUBROUTINE
END MODULE turbulence
