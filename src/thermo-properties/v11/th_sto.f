      subroutine th_sto(t1,h1,icase)
      implicit none
      integer i, n, icase
      real    t(400), h(400), t1, h1!, err
!------------------------------------------------------------------
      open(1,file='thsto.dat')
      do i=1, 400
        read(1,*,end=100) t(i), h(i)
      enddo
 100  n = i - 1
      close(1)
      if (icase .eq. 1) then
         call myspline(t, h, n, t1, h1)
      else
         call myspline(h, t, n, h1, t1)
      endif
!------------------------------------------------------------------
      return
      end
