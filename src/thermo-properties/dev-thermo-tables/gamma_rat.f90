real    function gamma(t1, filenameh, filenameu)
  !
  !     Returns gamma calculated as the ratio h/u using the content of  
  !     files filenamecp and filenamecv (either th*.dat or tu*.dat)
  ! 
  implicit none
  real, intent(in) :: t1
  character(len=*), intent(in) :: filenameh, filenameu ! name of file T, h
  integer :: i, n, case, io
  real    :: t(400), h(400)
  real    :: h1, u1, fake
  !------------------------------------------------------------------
  ! reads in enthalpy, h
  open(1,file=trim(filenameh))
  do i=1, 400
     read(1,*,iostat=io) t(i), h(i)
     if (io /= 0) exit
  enddo
  n = i - 1
  close(1)
  if (n > 400) stop 'increase dimension of T & h in gamma'
  !
  case = 1 ! returns y(x), i.e., h(T)
  call spline01(t, h, n, case, dble(t1), h1, fake)
  !
  ! reads in internal energy, u (stored in h to save memory)
  open(1,file=trim(filenameu))
  do i=1, 400
     read(1,*,iostat=io) t(i), h(i)
     if (io /= 0) exit
  enddo
  n = i - 1
  close(1)
  if (n > 400) stop 'increase dimension of T & u (i.e., h) in gamma'
  !
  case = 1 ! returns y(x), i.e., u(T)
  call spline01(t, h, n, case, dble(t1), u1, fake)
  !
  gamma = h1/u1
  !
  return
end function gamma
