      subroutine th_lambda(t1, h1, xlambda, xminl, icase)
c
c
c
      implicit none
      integer icase, i
      real    t1, h1, hair, hsto, tair, term, tsto, xlambda, xminl, hi
c
      term = 1.0 / (1.0 + xlambda * xminl)
      if (icase .eq. 1) then
         call th_air(t1, hair, icase)
         call th_sto(t1, hsto, icase)
         h1   = (1.0 + xminl) * term * hsto +
     $          (xlambda - 1.0) * xminl * term * hair
      else
         do i = 1, 10
            call th_air(tair, h1, icase) ! approx. value of tair
            call th_sto(tsto, h1, icase) ! approx. value of tsto
            t1   = (1.0 + xminl) * term * tsto +
     $           (xlambda - 1.0) * xminl * term * tair

!           calculate enthalpy hi corresponding to t1

            call th_air(t1, hair, icase)
            call th_sto(t1, hsto, icase)
            hi   = (1.0 + xminl) * term * hsto +
     $           (xlambda - 1.0) * xminl * term * hair
            if (abs(h1 - hi) < .1) exit
            print *, h1, hi
         end do
      endif
c
      return
      end
