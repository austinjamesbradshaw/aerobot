      subroutine hps_lambda(h, p, s, xlambda, xminl, r)
c
c
c    
      implicit none
      integer icase
      real h, p, r, s, sp, xlambda, xminl
c
      icase = 1
      call hs_lambda(h, sp, xlambda, xminl, icase)
      s = sp - r * alog(p)
      return
      end

      subroutine hsp_lambda(h, s, p, xlambda, xminl, r)
c
c
c    
      implicit none
      integer icase
      real h, p, r, s, sp, xlambda, xminl
c
      icase = 1
      call hs_lambda(h, sp, xlambda, xminl, icase)
      p = exp((sp - s)/r)
      return
      end

      subroutine psh_lambda(p, s, h, xlambda, xminl, r)
c
c
c    
      implicit none
      integer icase
      real h, p, r, s, sp, xlambda, xminl
c
      sp = s + r * alog(p)
      icase = 2
      call hs_lambda(h, sp, xlambda, xminl, icase)
      return
      end

