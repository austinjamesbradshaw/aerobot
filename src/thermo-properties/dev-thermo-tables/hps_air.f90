  ! The three combinations of h, p, s for air

subroutine hps_air(h, p, s, r)
  !
  ! s(h,p)
  !    
  implicit none
  integer icase
  real h, p, r, s, sp
  !
  icase = 1
  call hs_air(h, sp, icase)
  s = sp - r * alog(p)
  return
end subroutine hps_air

subroutine hsp_air(h, s, p, r)
  !
  ! p(h,s)
  !    
  implicit none
  integer icase
  real h, p, r, s, sp
  !
  icase = 1
  call hs_air(h, sp, icase)
  p = exp((sp - s)/r)
  return
end subroutine hsp_air

subroutine psh_air(p, s, h, r)
  !
  ! h(p,s)
  !    
  implicit none
  integer icase
  real h, p, r, s, sp
  !
  sp = s + r * alog(p)
  icase = 2
  call hs_air(h, sp, icase)
  return
end subroutine psh_air

