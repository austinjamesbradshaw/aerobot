      subroutine myspline(xa, ya, n, x, y)
!     For ya(xa), where xa & ya are vectors of dimension n, returns y=ya(x)
!     Input: n, xa(n), ya(n), x
!     Output: y
!     pgc - 5/4/15
      implicit none
      integer n, i
      real xa(n), ya(n), y2a(n), yp1, ypn, x, y
!------------------------------------------------------------------
! 
!     check that x_i > x_i-1
!
      do i = 2, n
         if (xa(i-1) >= xa(i)) then
            write(*,*) i-1, i, xa(i-1), xa(i)
            stop 'Terminated: failed check in myspline'
         end if
      end do
!
!     calculate end slopes
!
      yp1 = (ya(2) - ya(1  )) / (xa(2) - xa(1  ))
      ypn = (ya(n) - ya(n-1)) / (xa(n) - xa(n-1))
!
      call spline(xa, ya, n, yp1, ypn, y2a)
      call splint(xa, ya, y2a, n, x, y)
!
      return
      end

