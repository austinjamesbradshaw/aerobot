      subroutine hs_sto(h1,s1,icase)
c
c
c
      implicit none
      integer i, n, icase
      real    h(400), s(400), h1, s1
c
      open(1,file='hssto.dat')
      do i=1, 1000
        read(1,*,end=100) h(i), s(i)
      enddo
 100  n = i - 1
      close(1)
      if (n > 400) stop 'increase dimension of h & s'
!
      if (icase .eq. 1) then
         call myspline(h, s, n, h1, s1)
      else
         call myspline(s, h, n, s1, h1)
      endif
c
      return
      end
