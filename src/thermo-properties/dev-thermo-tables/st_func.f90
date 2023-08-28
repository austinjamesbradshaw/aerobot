real function st_func(t, s, lambda, minl)
  implicit none
  real, intent(in) :: t, s, lambda, minl
  real :: term, sair, ssto, w1, w2
  !------------------------------------------------------------------
  term = 1.0 / (1.0 + lambda * minl)
  w1 = (1.0 + minl) * term
  w2 = (lambda - 1.0) * minl * term
  call ts_air(t, sair, 1)
  call ts_sto(t, ssto, 1)
  st_func = s - w1 * ssto - w2 * sair
end function st_func
  
