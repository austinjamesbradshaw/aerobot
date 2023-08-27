      subroutine ts_air(t1, s1, icase)
!
!     Returns s(T) if icase=1, else returns T(s)
!
      implicit none
      integer i, n, icase
      real    t(400), s(400), t1, s1, err
!------------------------------------------------------------------
      open(1,file='ts.dat') ! reads ts.dat file
      do i=1, 1000
        read(1,*,end=100) t(i), s(i)
      enddo
 100  n = i - 1
      close(1)
      if (n > 400) stop 'increase dimension of t & s'
! 
      if (icase .eq. 1) then
         call ratint(t, s, n, t1, s1, err) ! s(T)
      else
         call ratint(s, t, n, s1, t1, err) ! T(s)
      endif
!------------------------------------------------------------------
      return
      end
