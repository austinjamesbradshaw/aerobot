      subroutine hs_sto(h1,s1,icase)
c
c
c
      implicit none
      integer i, n, icase
      real    h(400), s(400), h1, s1, err
c
      open(1,file='hssto.dat')
      do i=1, 1000
        read(1,*,end=100) h(i), s(i)
      enddo
 100  n = i - 1
      close(1)
      if (icase .eq. 1) then
         call ratint(h, s, n, h1, s1, err)
      else
         call ratint(s, h, n, s1, h1, err)
      endif
c
      return
      end
