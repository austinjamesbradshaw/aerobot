      subroutine hs_lambda(h1, s1, xlambda, xminl, icase)
c
c
c
      implicit none
      integer icase
      real    h1, hair, hsto, s1, sair, ssto, term, xlambda, xminl
c
      if (icase .eq. 1) then
         call hs_air(h1, sair, icase)
         call hs_sto(h1, ssto, icase)
         term = 1.0 / (1.0 + xlambda * xminl)
         s1   = (1.0 + xminl) * term * ssto +
     $          (xlambda - 1.0) * xminl * term * sair
      else
         call hs_air(hair, s1, icase)
         call hs_sto(hsto, s1, icase)
         term = 1.0 / (1.0 + xlambda * xminl)
         h1   = (1.0 + xminl) * term * hsto +
     $          (xlambda - 1.0) * xminl * term * hair
      endif
c
      return
      end
