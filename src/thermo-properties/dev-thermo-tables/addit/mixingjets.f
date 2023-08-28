!     
!     Solution for problem 2 given at final test
!     
!     Input:  A, B, C last 3 digits of UIN
!     
!     Output: temperature of mixed jets
!     
!     Author: Paul Cizmas
!     05/05/14
!     
!     Updates: 
!     
      implicit none
      real r, xminl, f
      real tair, hair, thot, hhot, lambda, cpair, cphot, bpr
      real lambdamix, hmix, tmix, cpmix
      integer a, b, c, icase
!---------------------------------------------------------------------------
      write(*,*) 'A B C from UIN'
      read (*,*) a, b, c
      write(*,'(A,i1,A,i1,A,i1)') 'a=', a, ' b=', b, ' c=', c
!
      r = 0.28716
      tair = 290.0
      icase = 1
      call th_air(tair, hair, icase)
      cpair = hair / tair
      write(*,'(A,f10.3,A,f10.3,A)') 'Tair=',tair,' K, hair=',hair,
     1     ' kJ/kg'
!
      xminl = 14.66
      thot = 950 + 10 * b
      lambda = 3.0 + 0.1 * c
      write(*,'(A,f10.3,A,f10.3)') 'lambda=', lambda
      icase = 1
      call th_lambda(thot, hhot, lambda, xminl, icase)
      write(*,'(A,f10.3,A,f10.3,A)') 'Thot=', thot, 'K, hhot=', hhot,
     1     ' kJ/kg'
      cphot = hhot / thot
!
      write(*,'(A,f10.5,A,f10.5)') 'cpair=', cpair, ' kJ/(kgK), cphot=', 
     1     cphot, ' kJ/(kgK)'
      f = 1.0 / (lambda * xminl)
      bpr = 4.0 + 0.2 * a
      hmix = (bpr * hair + (1.0 + f) * hhot)/(bpr + 1.0 + f)
      write(*,'(A,f10.3,A)') 'hmix=',hmix,' kJ/(kgK)'
!
      lambdamix = lambda * (1.0 + bpr)
      write(*,'(A,f10.3)') 'lambdamix=', lambdamix
      icase = 0
      call th_lambda(tmix, hmix, lambdamix, xminl, icase)
      cpmix = hmix / tmix
      write(*,'(A,f10.3,A,A,f10.3,A,f10.5,A)') 'hmix=',hmix,'kJ/(kgK),', 
     1     ' tmix=', tmix, ' K, cpmix=', cpmix, ' kJ/(kgK)'
      
      stop
      end

      
