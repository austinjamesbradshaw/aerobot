      subroutine ts_sto(t1,s1,icase)
c
c
c
      implicit none
      integer i, n, icase
      real    t(400), s(400), t1, s1, err
c
      open(1,file='tssto.dat')
      do i=1, 1000
        read(1,*,end=100) t(i), s(i)
      enddo
 100  n = i - 1
      close(1)
      if (icase .eq. 1) then
         call ratint(t, s, n, t1, s1, err)
      else
         call ratint(s, t, n, s1, t1, err)
      endif
c
      return
      end
