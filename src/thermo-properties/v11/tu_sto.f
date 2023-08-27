      subroutine tu_sto(t1,u1,icase)
!
!     Returns u(T) if icase=1 and T(u) if icase<>1
!
      implicit none
      integer i, n, icase
      real    t(400), u(400), t1, u1!, err
!------------------------------------------------------------------
      open(1,file='tusto.dat')
      do i=1, 400
        read(1,*,end=100) t(i), u(i)
      enddo
 100  n = i - 1
      close(1)
      if (n > 400) stop 'increase dimension of u & s'
!
      if (icase .eq. 1) then
         call myspline(t, u, n, t1, u1)
      else
         call myspline(u, t, n, u1, t1)
      endif
!------------------------------------------------------------------
      return
      end
