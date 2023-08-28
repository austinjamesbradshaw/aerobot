      subroutine ts_lambda(t1, s1, xlambda, xminl, icase)
c
c     Returns s(T) for icase = 1 and T(s) for icase /= 1
c
      implicit none
      integer icase
      external st_func
      real    rootbis, st_func
      real    t1, s1, sair, ssto, tair, term, tsto, xlambda, xminl
c
      if (icase .eq. 1) then ! s(T)
         call ts_air(t1, sair, icase)
         call ts_sto(t1, ssto, icase)
         term = 1.0 / (1.0 + xlambda * xminl)
         s1   = (1.0 + xminl) * term * ssto +
     $          (xlambda - 1.0) * xminl * term * sair
      else ! T(s)
         call ts_air(tair, s1, icase) ! T(s)
         call ts_sto(tsto, s1, icase) ! T(s)
         term = 1.0 / (1.0 + xlambda * xminl)
         t1   = (1.0 + xminl) * term * tsto +
     $          (xlambda - 1.0) * xminl * term * tair
         print *, tair, tsto, t1
         t1 = rootbis(st_func, tsto, tair, s1, xlambda, xminl, 0.01)
         print *, t1
      endif
c
      return
      end
