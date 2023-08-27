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
!     pgac - 09/01/02: beautified
!     pgac - 08/30/06: beautified
!     pgac - 10/10/09: run options
!     pgac - 04/13/17: added gamma computation
!     
      implicit none
      real t, h, p, s, xlambda, r, xminl
      real    cpv, cpair, cvair, cpsto, cvsto
      real    gamma, gamma_der_air, gamma_air, gamma_der_sto, gamma_sto
      integer icase, gastype, comptype
!-----------------------------------------------------------------------------
c$$$      t = 250.
c$$$      do
c$$$         if (t > 1770.0) exit
c$$$         cpair = cpv(t,'th.dat')
c$$$         cvair = cpv(t,'tu.dat')
c$$$         gamma_der_air = cpair / cvair
c$$$         gamma_air = gamma(t,'th.dat','tu.dat')
c$$$         write(101,*) t,cpair,cvair,gamma_der_air,gamma_air
c$$$         t = t + 20.0
c$$$      end do
c$$$      t = 290.
c$$$      do
c$$$         if (t > 1770.0) exit
c$$$         cpsto = cpv(t,'thsto.dat')
c$$$         cvsto = cpv(t,'tusto.dat')
c$$$         gamma_der_sto = cpsto / cvsto
c$$$         gamma_sto = gamma(t,'thsto.dat','tusto.dat')
c$$$         write(102,*) t,cpsto,cvsto,gamma_der_sto,gamma_sto
c$$$         t = t + 20.0
c$$$      end do
c$$$      stop
      
      write(*,*) 'Select gas type: 0 - air; 1 - combustion products'
      read (*,*) gastype
      select case (gastype)
      case (0) 
         r = 0.28716
         write(*,*) '0-h(T); 1-T(h); 2-s(h,p); 3-p(h,s); 4-h(p,s);',
     1              ' 5-s(T,p)'
         read (*,*) comptype
         select case (comptype)
         case (0) 
            write(*,*) 'T[K]='
            read (*,*) t
            icase = 1
            call th_air(t, h, icase)
            write(*,'(A,f10.3,A,f10.3,A)') 'T=', t, ' [K] h=', h,
     $            ' [kJ/kg]'
         case (1)
            write(*,*) 'h[kJ/kg]='
            read (*,*) h
            icase = 0
            call th_air(t, h, icase)
            write(*,'(A,f10.3,A,f10.3,A)') 'h=', h, ' [kJ/kg] T=', t,
     $            ' [K]'
         case (2)
            write(*,*) 'h[kJ/kg]='
            read (*,*) h
            write(*,*) 'p[bar]='
            read (*,*) p
            call hps(h, p, s, r)
            write(*,'(A,f8.3,A,f7.4,A,f6.4,A)') 'h=', h, 
     1           ' [kJ/kg], p=', p, ' [bar], s=', s, ' [kJ/(kg K)]'
         case (3)
            write(*,*) 'h[kJ/kg]='
            read (*,*) h
            write(*,*) 's[kJ/(kg K)]='
            read (*,*) s
            call hsp(h, s, p, r)
            write(*,'(A,f10.3,A,f10.4,A,f10.3,A)') 'h=', h, 
     1           '[kJ/kg] s=', s, '[kJ/(kg K)] p=', p, '[bar]'
         case (4)
            write(*,*) 'p[bar]='
            read (*,*) p
            write(*,*) 's[kJ/(kg K)]='
            read (*,*) s
            call psh(p, s, h, r)
            write(*,'(A,f10.3,A,f10.4,A,f10.3,A)') 'p=', p, 
     1           '[bar] s=', s, '[kJ/(kg K)] h=', h, '[kJ/kg]'
         case (5)
            write(*,*) 'T[K]='
            read (*,*) T
            write(*,*) 'p[bar]='
            read (*,*) p
            icase = 1
            call th_air(t, h, icase)
            call hps(h, p, s, r)
            write(*,'(A,f6.1,A,f10.3,A,f7.4,A,f6.4,A)') 'T=', T,
     1           '[K], h=', h, 
     2           ' [kJ/kg], p=', p, ' [bar], s=', s, ' [kJ/(kg K)]'
         case default
            stop 'Incorrect selection of computational type'
         end select
      case (1)
         xminl = 14.66
         r     = 0.28716  !0.294 ???
         write(*,*) 'excess air, lambda [-]='
         read (*,*) xlambda
         write(*,*) '0-h(T); 1-T(h); 2-T(s); 3-s(T); 4-s(h,p); ',
     1              '5-p(h,s); 6-h(p,s); 7-s(T,p)'
         read (*,*) comptype
         select case (comptype)
         case (0) 
            write(*,*) 'T[K]='
            read (*,*) t
            icase = 1
            call th_lambda(t, h, xlambda, xminl, icase)
            write(*,'(A,f10.3,A,f10.3,A)') 'T=', t, '[K] h=', h,
     $                ' [kJ/kg]'
         case (1)
            write(*,*) 'h[kJ/kg]='
            read (*,*) h
            icase = 0
            call th_lambda(t, h, xlambda, xminl, icase)
            write(*,'(A,f10.3,A,f10.3,A)') 'h=', h, '[kJ/kg] T=', t,
     $                ' [K]'
         case (2)
            write(*,*) 's[kJ/(kg K)]='
            read (*,*) s
            icase = 0
            call ts_lambda(t, s, xlambda, xminl, icase)
            write(*,'(A,f10.4,A,f8.1,A)') 's=', s, '[kJ/(kg K)] T=', t,
     $                ' [K]'
         case (3)
            write(*,*) 'T[K]='
            read (*,*) t
            icase = 1
            call ts_lambda(t, s, xlambda, xminl, icase)
            write(*,'(A,f10.4,A,f8.1,A)') 's=', s, '[kJ/(kg K)] T=', t,
     $                ' [K]'
         case (4)
            write(*,*) 'h[kJ/kg]='
            read (*,*) h
            write(*,*) 'p[bar]='
            read (*,*) p
            call hps_lambda(h, p, s, xlambda, xminl, r)
            write(*,'(A,f10.4,A,f10.2,A,f10.4,A)') 's=', s,
     $       '[kJ/(kg K)] h=', h, ' [kJ/kg] p=', p, ' [bar]'
         case (5)
            write(*,*) 'h[kJ/kg]='
            read (*,*) h
            write(*,*) 's[kJ/(kg K)]='
            read (*,*) s
            call hsp_lambda(h, s, p, xlambda, xminl, r)
            write(*,'(A,f10.4,A,f10.2,A,f10.4,A)') 's=', s,
     $       '[kJ/(kg K)] h=', h, ' [kJ/kg] p=', p, ' [bar]'
         case (6)
            write(*,*) 'p[bar]='
            read (*,*) p
            write(*,*) 's[kJ/(kg K)]='
            read (*,*) s
            call psh_lambda(p, s, h, xlambda, xminl, r)
            write(*,'(A,f10.4,A,f10.2,A,f10.4,A)') 's=', s,
     $       '[kJ/(kg K)] h=', h, ' [kJ/kg] p=', p, ' [bar]'
         case (7)
            write(*,*) 'T[K]='
            read (*,*) t
            call th_lambda(t, h, xlambda, xminl, 1) ! h(t)
            write(*,*) 'p[bar]='
            read (*,*) p
            call hps_lambda(h, p, s, xlambda, xminl, r)
            write(*,'(A,f10.4,A,f10.2,A,f10.4,A,f6.1,A)') 's=', s,
     $       '[kJ/(kg K)] h=', h, ' [kJ/kg] p=', p, ' [bar] T=', T,'[K]'
         case default
            stop 'Incorrect selection of computational type'
         end select
      case default
         stop 'Incorrect selection of gas type'
      end select
      
      stop
      end

      
