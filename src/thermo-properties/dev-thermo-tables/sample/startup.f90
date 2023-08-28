subroutine strtup(icase, x)
!
!**********************************************************************
!
!     this routine performs a number of machine specific functions
!     including: setting error traps, opening files, reading in input
!     data.
!     
!***********************************************************************
  implicit none
  integer :: icase
  real    :: x
  logical :: interactive
  character infile*80, outfile*80
  namelist /input_data/ icase, x, interactive
!---------------------------------------------------------------------- 
!
! set various constants
!
! get name of input and output files
  call getarg(1,infile)
  call getarg(2,outfile)
  if (len(infile) == 0 .or. len(outfile) == 0) then
     stop 'proper usage is: ''exefile infile outfile'' '
  end if
!
! open files
  open(unit=1,file=infile, err=981,status='old',     access='sequential', &
       form='formatted')
  open(unit=2,file=outfile,err=982,status='unknown', access='sequential', &
       form='formatted')
!
! read in input data from input file
  read(1,nml=input_data, err=990)
!
! write input data to screen
  if (interactive) write(*,nml=input_data,err=992)
  write(2,nml=input_data, err=995) 
!
  return
!
! fatal error messages
981 stop 'error opening input file in subroutine strtup'
982 stop 'error opening output file in subroutine strtup'
990 stop 'error reading namelist input_data in subroutine strtup'
992 stop 'error writing namelist input_data in subroutine strtup'
995 stop 'error writing fi namelist input_data in subroutine strtup'
!
end subroutine strtup
