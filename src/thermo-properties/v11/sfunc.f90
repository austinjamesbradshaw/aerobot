real function sfunc(h, s, lambda, minl)
  implicit none
  real, intent(in) :: h, s, lambda, minl
  real :: term, sair, ssto, w1, w2
  !------------------------------------------------------------------
  term = 1.0 / (1.0 + lambda * minl)
  w1 = (1.0 + minl) * term
  w2 = (lambda - 1.0) * minl * term
  call hs_air(h, sair, 1)
  call hs_sto(h, ssto, 1)
  sfunc = s - w1 * ssto - w2 * sair
end function sfunc
  
