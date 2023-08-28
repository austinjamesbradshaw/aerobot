      subroutine hs_air(h1,s1,icase)
c
c
c
      implicit none
      integer icase, icasel
      real    h1, s1, t1
c
      if (icase .eq. 1) then
         icasel = 2
         call th_air(t1, h1, icasel)
         icasel = 1
         call ts_air(t1, s1, icasel)
      else
         icasel = 2
         call ts_air(t1, s1, icasel)
         icasel = 1
         call th_air(t1, h1, icasel)
      endif
c
      return
      end

