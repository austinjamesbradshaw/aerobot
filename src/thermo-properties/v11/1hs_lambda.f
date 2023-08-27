      subroutine hs_lambda(h1, s1, xlambda, xminl, icase)
!
!     Returns s(h) for icase = 1 and h(s) for icase /= 1
!
      implicit none
      integer icase
      real    h1, hair, hsto, s1, sair, ssto, xlambda, xminl, sc
      external sfunc
      real    rootbis, sfunc
      real    w1, w2, term, t1
!------------------------------------------------------------------
      term = 1.0 / (1.0 + xlambda * xminl)
      w1 = (1.0 + xminl) * term
      w2 = (xlambda - 1.0) * xminl * term
      if (icase .eq. 1) then
         call th_lambda(t1, h1, xlambda, xminl, 0) ! T(h1)
         call ts_lambda(t1, sc, xlambda, xminl, 1) ! s(T)
         
!         call hs_air(h1, sair, icase)
!         call hs_sto(h1, ssto, icase)
!         s1   = w1 * ssto + w2 * sair
!         print *, sc, s1
         s1 = sc
      else
         call hs_air(hair, s1, icase) ! h_air(s)
         call hs_sto(hsto, s1, icase) ! h_sto(s)
         print *, hair, hsto
         h1 = rootbis(sfunc, hsto, hair, s1, xlambda, xminl, 0.01)
      endif
c
      return
      end
