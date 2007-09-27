!=====================================================================
!
!          S p e c f e m 3 D  G l o b e  V e r s i o n  4 . 0
!          --------------------------------------------------
!
!          Main authors: Dimitri Komatitsch and Jeroen Tromp
!    Seismological Laboratory, California Institute of Technology, USA
!                    and University of Pau, France
! (c) California Institute of Technology and University of Pau, October 2007
!
!    A signed non-commercial agreement is required to use this program.
!   Please check http://www.gps.caltech.edu/research/jtromp for details.
!           Free for non-commercial academic research ONLY.
!      This program is distributed WITHOUT ANY WARRANTY whatsoever.
!      Do not redistribute this program without written permission.
!
!=====================================================================

  program extract_all_seismos_large_file

! extract all the seismograms when they are stored in a unique large file

! Dimitri Komatitsch, University of Pau, France, September 2007

  implicit none

! number of seismogram files stored in the unique large file
  integer, parameter :: N_COMPONENTS = 1
  integer, parameter :: NREC = 720 * N_COMPONENTS

! number of time steps in each seismogram file
  integer, parameter :: NSTEP = 41100

  integer :: irec,istep,irepeat
  real :: time,U_value

  character(len=150) :: station_name

! loop on all the seismogram files
  do irec = 1,NREC

    read(*,*) station_name

! suppress leading white spaces, if any
    station_name = adjustl(station_name)

! suppress two leading '\' (ASCII code 92), if any
    do irepeat = 1,2
      if(station_name(1:1) == achar(92)) station_name = station_name(2:len_trim(station_name))
      station_name = adjustl(station_name)
    enddo

    print *,'extracting seismogram file ',irec,': ',station_name(1:len_trim(station_name)),' out of ',NREC

    open(unit=27,file=station_name(1:len_trim(station_name)),status='unknown')

! loop on all the time steps in each seismogram
    do istep = 1,NSTEP
      read(*,*) time, U_value
      write(27,*) time, U_value
    enddo

    close(27)

  enddo

  end program extract_all_seismos_large_file
