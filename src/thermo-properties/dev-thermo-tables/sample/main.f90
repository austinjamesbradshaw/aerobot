program hsp
!
!     Sample FORTRAN code that uses the h-s table
!
!     Usage: ta your_input_file your_output_file
!
!     Author: Paul Cizmas
!             02.21.07
!
!     Updates: 
!      
  implicit none
  real x
  integer icase, n
!-----------------------------------------------------------------
  call strtup(icase, x)
  call readtable(n)
  call control(n, icase, x)
!
end program hsp
