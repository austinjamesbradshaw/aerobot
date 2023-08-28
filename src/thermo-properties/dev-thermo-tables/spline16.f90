subroutine spline01(xa, ya, n, case, x, y, yd)
  !     For ya(xa), where xa & ya are vectors of dimension n, returns 
  !     y=ya(x)                 for case = 1
  !     yd=dy/dx(x)             for case = 2
  !     y=ya(x) and yd=dy/dx(x) for case = 3
  
  !     Input: n, xa(n), ya(n), case, x
  !     Output: y and/or yd

  !     pgc - 4/14/16
  implicit none

  ! input
  integer, intent(in) :: n, case
  real   , intent(in) :: xa(n), ya(n), x

  ! output
  real   , intent(out) :: y, yd
  
  ! local
  integer :: i
  real    :: y2a(n), yp1, ypn
  !------------------------------------------------------------------
  ! 
  !     check that x_i > x_i-1
  !
  do i = 2, n
     if (xa(i-1) >= xa(i)) then
        write(*,*) i-1, i, xa(i-1), xa(i)
        stop
     end if
  end do
  !
  !     calculate end slopes
  !
  yp1 = (ya(2) - ya(1  )) / (xa(2) - xa(1  ))
  ypn = (ya(n) - ya(n-1)) / (xa(n) - xa(n-1))
  !
  call spline(xa, ya, n, yp1, ypn, y2a)
  call spl01(xa, ya, y2a, n, case, x, y, yd)
  !
  return
end subroutine spline01

SUBROUTINE spline(x, y, n, yp1, ypn, y2)

  implicit none

  ! returns the second derivatives y2(n) at the given x(n) locations
  INTEGER n,NMAX
  REAL    :: yp1,ypn,x(n),y(n),y2(n)
  PARAMETER (NMAX=900)
  INTEGER i,k
  REAL    :: p,qn,sig,un,u(NMAX)
  !------------------------------------------------------------------
  if (n > NMAX) then
     write(*,*) 'n=', n, '> NMAX=', NMAX
     stop 'Terminated in spline'
  end if
  if (yp1.gt..99e30) then
     y2(1)=0.
     u(1)=0.
  else
     y2(1)=-0.5
     u(1)=(3./(x(2)-x(1)))*((y(2)-y(1))/(x(2)-x(1))-yp1)
  endif
  do i=2,n-1
     sig   = (x(i)-x(i-1)) / (x(i+1)-x(i-1))
     p     = sig * y2(i-1) + 2.
     y2(i) = (sig-1.) / p
     u(i)  = (6.*((y(i+1)-y(i))/(x(i+1)-x(i))-(y(i)-y(i-1))/(x(i)-x(i-1)))/ &
          (x(i+1)-x(i-1))-sig*u(i-1))/p
  end do
  if (ypn.gt..99e30) then
     qn=0.
     un=0.
  else
     qn=0.5
     un=(3./(x(n)-x(n-1)))*(ypn-(y(n)-y(n-1))/(x(n)-x(n-1)))
  endif
  y2(n)=(un-qn*u(n-1))/(qn*y2(n-1)+1.)
  do k=n-1,1,-1
     y2(k)=y2(k)*y2(k+1)+u(k)
  end do
  return
END SUBROUTINE spline


SUBROUTINE spl01(xa, ya, y2a, n, case, x, y, yd)
  ! returns y and/or yd depending on the case value
  implicit none

  INTEGER, intent(in) :: n, case
  REAL   , intent(in)  :: x, xa(n), y2a(n), ya(n)
  REAL   , intent(out) :: y, yd
  ! local
  INTEGER :: k, khi, klo
  REAL    :: a, b, h, oby6, obyh
  !------------------------------------------------------------------
  ! finds klo & khi such that khi=hlo+1 and x(klo)<x<x(khi)
  klo=1
  khi=n
1 if (khi-klo.gt.1) then
     k=(khi+klo)/2
     if(xa(k).gt.x)then
        khi=k
     else
        klo=k
     endif
     goto 1
  endif

  h = xa(khi) - xa(klo)
  if (h.eq.0.) stop 'bad xa input in splint'

  obyh = 1.0 / h
  a = (xa(khi)-x) * obyh
  b = 1.0 - a  !(x-xa(klo))/h
  oby6 = 0.16666666666666666666666666666666666
  select case (case)
     case (1) ! returns only function
        y=a*ya(klo)+b*ya(khi)+((a**3-a)*y2a(klo)+(b**3-b)*y2a(khi))*(h**2) * oby6
     case (2) ! returns only derivative
        yd = (ya(khi) - ya(klo)) * obyh &
             - (3.*a**2 - 1.) * oby6 * (xa(khi) - xa(klo)) * y2a(klo) &
             + (3.*b**2 - 1.) * oby6 * (xa(khi) - xa(klo)) * y2a(khi)
     case (3) ! returns both function and derivative
        y  = a*ya(klo)+b*ya(khi)+((a**3-a)*y2a(klo)+(b**3-b)*y2a(khi))*(h**2) * oby6
        yd = (ya(khi) - ya(klo)) * obyh &
             - (3.*a**2 - 1.) * oby6 * (xa(khi) - xa(klo)) * y2a(klo) &
             + (3.*b**2 - 1.) * oby6 * (xa(khi) - xa(klo)) * y2a(khi)
     case default
        print *, 'choose a case number between 1 and 3, not', case
        stop 'Terminated in spl01'
  end select
  return
END SUBROUTINE spl01
