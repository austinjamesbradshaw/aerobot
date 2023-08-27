      subroutine th_lambda(t1, h1, xlambda, xminl, icase)
!
!     Returns h(T) if icase = 1, else returns T(h)
!
      implicit none
      integer icase, i
      real    t1, h1, hair, hsto, tair, term, tsto, xlambda, xminl, hi
      logical converged
!-----------------------------------------------------------------------
      term = 1.0 / (1.0 + xlambda * xminl)
      if (icase .eq. 1) then
!        calculate enthalpy
         call th_air(t1, hair, icase)
         call th_sto(t1, hsto, icase)
         h1   = (1.0 + xminl) * term * hsto +
     $          (xlambda - 1.0) * xminl * term * hair
      else
         converged = .false.
!        initial guess of temperature
         icase = 0
         call th_air(tair, h1, icase) ! approx. value of tair
         call th_sto(tsto, h1, icase) ! approx. value of tsto
         t1   = (1.0 + xminl) * term * tsto +
     $        (xlambda - 1.0) * xminl * term * tair

         do i = 1, 10 ! max number of iterations
!           calculate enthalpy hi corresponding to t1
            icase = 1
            call th_air(t1, hair, icase)
            call th_sto(t1, hsto, icase)
            hi   = (1.0 + xminl) * term * hsto +
     $           (xlambda - 1.0) * xminl * term * hair
            if (abs(h1 - hi) < .01) then
               converged = .true.
               exit
            else
               print *, h1, hi
               t1 = t1 + h1 - hi
            end if
         end do
         if (.not.converged) stop 'failed to converge in th_lambda'
      endif
c
      return
      end
