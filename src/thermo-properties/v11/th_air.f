      subroutine th_air(t1,h1,icase)
!
!     Returns h(T) if icase=1 and T(h) if icase<>1
! 
      implicit none
      integer i, n, icase
      real    t(400), h(400), t1, h1
!
      open(1,file='th.dat')
      do i=1, 400
        read(1,*,end=100) t(i), h(i)
!        write(*,*) t(i), h(i)
      enddo
 100  n = i - 1
      close(1)
      if (n > 400) stop 'increase dimension of h & s'
!
      if (icase .eq. 1) then
         call myspline(t, h, n, t1, h1)
!         write(*,*) n, t1, h1, err
      else
         call myspline(h, t, n, h1, t1)
!         write(*,*) n, h1, t1, err
      endif
!
      return
      end
