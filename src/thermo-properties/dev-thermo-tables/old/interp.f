      SUBROUTINE interp(xa, ya, n, x, y, dy)
      IMPLICIT NONE
      INTEGER n
      REAL dy ! not used; kept for compatibility with ratint 
      REAL x, y, xa(n), ya(n), y2(n)
      REAL yp1, ypn
!
!     Hardwired slopes at the beginning and end of interval
!
      yp1 = 0.0
      ypn = 0.0
      call spline (xa, ya, n, yp1, ypn, y2)
!
      call splint (xa, ya, y2, n, x, y)
      return
      END

