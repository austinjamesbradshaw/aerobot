      subroutine hps(h, p, s, r)
c
c
c    
      implicit none
      integer icase
      real h, p, r, s, sp
c
      icase = 1
      call hs_air(h, sp, icase)
      s = sp - r * alog(p)
      return
      end

      subroutine hsp(h, s, p, r)
c
c
c    
      implicit none
      integer icase
      real h, p, r, s, sp
c
      icase = 1
      call hs_air(h, sp, icase)
      p = exp((sp - s)/r)
      return
      end

      subroutine psh(p, s, h, r)
c
c
c    
      implicit none
      integer icase
      real h, p, r, s, sp
c
      sp = s + r * alog(p)
      icase = 2
      call hs_air(h, sp, icase)
      return
      end

