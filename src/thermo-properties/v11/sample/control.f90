subroutine control(n, icase, x)
!
!     Returns either T(h) or h(T) depending on icase
!
!     Author: Paul Cizmas
!             02.21.07
!
!     Updates: 
!      
  use th                       ! h-t table
  implicit none
  integer, intent(in) :: n     ! number of points in h-t table
  real,    intent(in) :: x     ! either T or h, depending on icase
  integer, intent(in) :: icase ! =1 T(h), /= h(T)
  real :: err, t1, h1          ! local variables
!-----------------------------------------------------------------
  write(*,*) n, x
  if (icase == 1) then
     t1 = x
     call ratint(t, h, n, t1, h1, err)
     write(*,'(a4,f5.1,a2,f5.1)') 'h(T=',t1,')=', h1
  else
     h1 = x
     call ratint(h, t, n, h1, t1, err)
     write(*,*) 'T(h=',h1,')=', t1
  endif
  write(*,*) 'Accuracy estimate=', err
!
  return
end subroutine control
