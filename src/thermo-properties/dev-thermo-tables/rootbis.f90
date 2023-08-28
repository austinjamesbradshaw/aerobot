real FUNCTION rootbis(func, x1, x2, s, lambda, minl, xacc)
  implicit none
  INTEGER JMAX
  REAL, intent(in) :: x1, x2, s, lambda, minl, xacc
  EXTERNAL func
  real func
  PARAMETER (JMAX=40)
  INTEGER j
  REAL :: dx, f, fmid, xmid
  !------------------------------------------------------------------
  fmid=func(x2, s, lambda, minl)
  f=func(x1, s, lambda, minl)
  if(f*fmid.ge.0.) stop 'root must be bracketed in rootbis'
  if(f.lt.0.)then
     rootbis=x1
     dx=x2-x1
  else
     rootbis=x2
     dx=x1-x2
  endif
  do j=1,JMAX
     dx=dx*.5
     xmid=rootbis+dx
     fmid=func(xmid, s, lambda, minl)
     if(fmid.le.0.)rootbis=xmid
     if(abs(dx).lt.xacc .or. fmid.eq.0.) return
  end do
  stop 'too many bisections in rootbis'
end FUNCTION rootbis
