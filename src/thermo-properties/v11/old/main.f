!
!     Example of how to use the h-s-p table subroutines
!
!     Input:  obvious
!
!     Output: obvious
!
!     Author: Paul Cizmas
!             4.4.00
!
!     Updates: pgac - 9.01.02: beautified
!              pgac - 8.30.06: beautified
!      
      implicit none
      real t, h, p, s, xlambda, r, xminl
      integer icase
!
      write(*,*) 'This example is for lambda only, standard fuel'
      write(*,*) 'T= [K]'
      read (*,*) t
      write(*,*) 'lambda='
      read (*,*) xlambda
      xminl = 14.66
      icase = 1
      call th_lambda(t, h, xlambda, xminl, icase)
      write(*,*) 'p= [bar]'
      read (*,*) p
      r = 0.28716
      call hps_lambda(h, p, s, xlambda, xminl, r)
      write(*,102) t, h, p, xlambda, s
 102  format ('T=',f6.1,'K, h=',f6.1,'kJ/kg, p=',f6.3,
     1        'bar, lambda=',f6.3,', s=',f7.4,'kJ/(kg K)')
!
      write(*,*) 'This example is for air only, with icase=1'
      write(*,*) 'T= [K]'
      read (*,*) t
      icase = 1
      call th_air(t, h, icase)
      write(*,100) t, h, icase
 100  format ('T=',e12.5,'K, h=',e12.5,'kJ/kg, icase=',i1)
!
      write(*,*) 'This example is for lambda only, standard fuel'
      write(*,*) 'h= [kJ/kg]'
      read (*,*) h
      write(*,*) 'p= [bar]'
      read (*,*) p
      write(*,*) 'lambda='
      read (*,*) xlambda
      r = 0.28716
      xminl = 14.66
      call hps_lambda(h, p, s, xlambda, xminl, r)
      write(*,101) h, p, xlambda, s
 101  format ('h=',e12.5,'kJ/kg, p=',e12.5,'bar, lambda=',e12.5,
     1        ', s=',e12.5,'kJ/(kg K)')
      stop
      end

      
