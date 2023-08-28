      subroutine th_air(t1,h1,icase)
      implicit none
      integer i, n, icase
      real    t(400), h(400), t1, h1, err
c
      open(1,file='th.dat')
      do i=1, 400
        read(1,*,end=100) t(i), h(i)
!        write(*,*) t(i), h(i)
      enddo
 100  n = i - 1
      close(1)
      if (icase .eq. 1) then
         call ratint(t, h, n, t1, h1, err)
c         write(*,*) n, t1, h1, err
      else
         call ratint(h, t, n, h1, t1, err)
c         write(*,*) n, h1, t1, err
      endif
c
      return
      end
