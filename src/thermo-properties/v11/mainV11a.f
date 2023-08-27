!     
!     Example of how to use the h-s-p table subroutines
!     
!     Input:  obvious
!     
!     Output: obvious
!     
!     Author: Paul Cizmas
!     04/04/00
!     
!     Updates: 
!     pgc - 09/01/02: beautified
!     pgc - 08/30/06: beautified
!     pgc - 10/10/09: run options
!     V10 - pgc - 04/13/17: added gamma computation
!     V11 - pgc - 05/11/19 - added T(p,s)
!     V11a- pgc - 09/05/19 - added p(T,s), equivalence ratio
!
      implicit none
      real t, h, p, s, xlambda, r, xminl, f, sair, ssto, term
!      real    cpv, cpair, cvair, cpsto, cvsto
!      real    gamma, gamma_der_air, gamma_air, gamma_der_sto, gamma_sto
      integer icase, gastype, comptype, mix
!-----------------------------------------------------------------------------
      write(*,*) 'Select gas type: 0 - air; 1 - combustion products'
      read (*,*) gastype
      select case (gastype)
      case (0) 
         r = 0.28716
         write(*,*) ' 1-T(h); 2-T(p,s); 3-h(T); 4-h(p,s); 5-p(T,s);',
     $       '6-p(h,s); 7-s(T,p); 8-s(h,p)'
         read (*,*) comptype
         select case (comptype)
         case (1) ! T(h)
            write(*,*) 'h[kJ/kg]='
            read (*,*) h
            icase = 0
            call th_air(t, h, icase)
            write(*,'(A,f10.3,A,f10.3,A)') 'h=', h, ' [kJ/kg] &T=', t,
     $            ' [K]&'
         case (2) ! T(p,s)
            write(*,*) 'p[bar]='
            read (*,*) p
            write(*,*) 's[kJ/(kg K)]='
            read (*,*) s
            call psh_air(p, s, h, r) ! h(p,s)
            icase = 0
            call th_air(t,h,icase)   ! t(h)
            write(*,'(A,f10.3,A,f10.4,A,f10.1,A)') 'p=', p, 
     1           '[bar] s=', s, '[kJ/(kg K)] &T=', T, '[K]&'
         case (3) ! h(T)
            write(*,*) 'T[K]='
            read (*,*) t
            icase = 1
            call th_air(t, h, icase)
            write(*,'(A,f10.3,A,f10.3,A)') 'T=', t, ' [K] &h=', h,
     $            ' [kJ/kg]&'
         case (4) ! h(p,s)
            write(*,*) 'p[bar]='
            read (*,*) p
            write(*,*) 's[kJ/(kg K)]='
            read (*,*) s
            call psh_air(p, s, h, r)
            write(*,'(A,f10.3,A,f10.4,A,f10.3,A)') 'p=', p, 
     1           '[bar] s=', s, '[kJ/(kg K)] &h=', h, '[kJ/kg]&'
         case (5) ! p(T,s)
            write(*,*) 'T[K]='
            read (*,*) T
            write(*,*) 's[kJ/(kg K)]='
            read (*,*) s
            icase = 1
            call th_air(t, h, icase) ! h[T]
            call hsp_air(h, s, p, r)
            write(*,'(A,f10.3,A,f10.4,A,f10.3,A)') 'T=', T, 
     1           '[K] s=', s, '[kJ/(kg K)] &p=', p, '[bar]&'
         case (6) ! p(h,s)
            write(*,*) 'h[kJ/kg]='
            read (*,*) h
            write(*,*) 's[kJ/(kg K)]='
            read (*,*) s
            call hsp_air(h, s, p, r)
            write(*,'(A,f10.3,A,f10.4,A,f10.3,A)') 'h=', h, 
     1           '[kJ/kg] s=', s, '[kJ/(kg K)] &p=', p, '[bar]&'
         case (7) ! s(T,p)
            write(*,*) 'T[K]='
            read (*,*) T
            write(*,*) 'p[bar]='
            read (*,*) p
            icase = 1
            call th_air(t, h, icase)
            call hps_air(h, p, s, r)
            write(*,'(A,f6.1,A,f10.3,A,f7.4,A,f6.4,A)') 'T=', T,
     1           '[K], h=', h, 
     2           ' [kJ/kg], p=', p, ' [bar], &s=', s, ' [kJ/(kg K)]&'
         case (8) ! s(h,p)
            write(*,*) 'h[kJ/kg]='
            read (*,*) h
            write(*,*) 'p[bar]='
            read (*,*) p
            call hps_air(h, p, s, r)
            write(*,'(A,f8.3,A,f7.4,A,f6.4,A)') 'h=', h, 
     1           ' [kJ/kg], p=', p, ' [bar], &s=', s, ' [kJ/(kg K)]&'
         case default
            stop 'Incorrect selection of computational type'
         end select
!
!  Combustion products
!
      case (1)
         xminl = 14.66
         r     = 0.28716        !0.294 ???
         write(*,*) 'Select mixture definition: 0 - use excess air;',
     $        ' 1 - equivalence ratio'
         read (*,*) mix
         if (mix == 0) then
            write(*,*) 'excess air, lambda [-]='
            read (*,*) xlambda
         else if (mix == 1) then
            write(*,*) 'equivalence ratio, Phi [-]='
            read (*,*) xlambda
            xlambda = 1.0/xlambda  ! turn Phi into lambda
         else
            stop 'Wrong mixture selection: should be 0 or 1'
         end if

         write(*,*) '1-T(h); 2-T(p,s); 3-h(T); 4-h(p,s); 5-p(T,s); ',
     1              '6-p(h,s); 7-s(T,p); 8-s(h,p)'
         read (*,*) comptype
         select case (comptype)
         case (1) ! T(h)
            write(*,*) 'h[kJ/kg]='
            read (*,*) h
            icase = 0
            call th_lambda(t, h, xlambda, xminl, icase)
            write(*,'(A,f10.3,A,f10.3,A)') 'h=', h, '[kJ/kg] &T=', t,
     $                ' [K]&'
         case (2) ! T(p,s)
            write(*,*) 'p[bar]='
            read (*,*) p
            write(*,*) 's[kJ/(kg K)]='
            read (*,*) s
            call psh_lambda(p, s, h, xlambda, xminl, r) ! h
            icase = 0
            call th_lambda(t, h, xlambda, xminl, icase) ! T(h)
            write(*,'(A,f10.4,A,f10.4,A,f10.2,A)') 'p=', p,
     $       ' [bar]  s=', s, '[kJ/(kg K)] &T=', t, ' [K]&' 
         case (3) ! h(T)
            write(*,*) 'T[K]='
            read (*,*) t
            icase = 1
            call th_lambda(t, h, xlambda, xminl, icase)
            write(*,'(A,f10.3,A,f10.3,A)') 'T=', t, '[K] &h=', h,
     $                ' [kJ/kg]&'
         case (4) ! h(p,s)
            write(*,*) 'p[bar]='
            read (*,*) p
            write(*,*) 's[kJ/(kg K)]='
            read (*,*) s
            call psh_lambda(p, s, h, xlambda, xminl, r)
            write(*,'(A,f10.4,A,f10.4,A,f10.2,A)') 'p=', p, 
     $       ' [bar]  s=', s, '[kJ/(kg K)]  &h=', h, ' [kJ/kg]&' 
         case (5) ! p(T,s)
            write(*,*) 'T[K]='
            read (*,*) t
            write(*,*) 's[kJ/(kg K)]='
            read (*,*) s
            icase = 1
            call th_lambda(t, h, xlambda, xminl, icase) ! h
            call hsp_lambda(h, s, p, xlambda, xminl, r)
            write(*,'(A,f10.2,A,f10.4,A,f10.4,A)') 'T=', t, ' [K]  s=',
     $        s, '[kJ/(kg K)] &p=', p, ' [bar]&'
         case (6) ! p(h,s)
            write(*,*) 'h[kJ/kg]='
            read (*,*) h
            write(*,*) 's[kJ/(kg K)]='
            read (*,*) s
            call hsp_lambda(h, s, p, xlambda, xminl, r)
            write(*,'(A,f10.2,A,f10.4,A,f10.4,A)') 'h=', h, 
     $       ' [kJ/kg]  s=', s, '[kJ/(kg K)] &p=', p, ' [bar]&'
         case (7) ! s(T,p)
            write(*,*) 'T[K]='
            read (*,*) t
            call th_lambda(t, h, xlambda, xminl, 1) ! h(t)
            write(*,*) 'p[bar]='
            read (*,*) p
            call hps_lambda(h, p, s, xlambda, xminl, r)
            write(*,'(A,f10.2,A,f10.4,A,f10.4,A)') 'T=', t,
     $       '[K] p=', p, ' [bar] &s=', s, ' [kJ/(kg K)]&'
         case (8) ! s(h,p)
            write(*,*) 'h[kJ/kg]='
            read (*,*) h
            write(*,*) 'p[bar]='
            read (*,*) p
            call hps_lambda(h, p, s, xlambda, xminl, r)
            write(*,'(A,f10.2,A,f10.4,A,f10.4,A)') 'h=', h,
     $       '[kJ/kg] p=', p, ' [bar] &s=', s, ' [kJ/(kg K)]&'
         case (20) ! T(s)
            write(*,*) 's[kJ/(kg K)]='
            read (*,*) s
            icase = 0
            call ts_lambda(t, s, xlambda, xminl, icase)
            write(*,'(A,f10.4,A,f8.1,A)') 's=', s, '[kJ/(kg K)] &T=', t,
     $                ' [K]&'
         case (30) ! s(T)
            write(*,*) 'T[K]='
            read (*,*) t
            icase = 1
            call ts_lambda(t, s, xlambda, xminl, icase)
            write(*,'(A,f10.4,A,f8.1,A)') 's=', s, '[kJ/(kg K)] &T=', t,
     $                ' [K]&'
         case (40)               ! s - w1 * s_sto(T) - w2 * s_air(T)
            write(*,*) 's[kJ/(kg K)]='
            read (*,*) s
 1          continue
            write(*,*) 'T[K]='
            read (*,*) t
            icase = 1
            call ts_air(t, sair, icase) ! s(T)
            call ts_sto(t, ssto, icase) ! s(T)
            term = 1.0 / (1.0 + xlambda * xminl)
            f    = s - (1.0 + xminl) * term * ssto -
     $          (xlambda - 1.0) * xminl * term * sair
            write(*,'(A,f10.4,2(A,f10.4),A,f10.2,A)') 'f=',f, ', sair='
     $           , sair, ', ssto=', ssto, '[kJ/(kg K)] &T=', t, '[K]&'
            go to 1
         case default
            stop 'Incorrect selection of computational type'
         end select
      case default
         stop 'Incorrect selection of gas type'
      end select
      
      end
      
