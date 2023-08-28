      subroutine ts_sto(t1,s1,icase)
!
!
!
      implicit none
      integer i, n, icase
      real    t(400), s(400), t1, s1
!
      open(1,file='tssto.dat')
      do i=1, 1000
        read(1,*,end=100) t(i), s(i)
      enddo
 100  n = i - 1
      close(1)
      if (n > 400) stop 'increase dimension of t & s'
!
      if (icase .eq. 1) then
         call myspline(t, s, n, t1, s1)
      else
         call myspline(s, t, n, s1, t1)
      endif
!
      return
      end
