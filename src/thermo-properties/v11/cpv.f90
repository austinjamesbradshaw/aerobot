real    function cpv(t1, filename)
  !
  !     Returns C_p(T) or C_v(T), i.e., dh/dT(T) or du/dT(T) depending on
  !     the content of file filename (either th*.dat or tu*.dat)
  ! 
  implicit none
  real, intent(in) :: t1
  character(len=*), intent(in) :: filename ! name of file T, h
  integer :: i, n, case, io
  real    :: t(400), h(400)
  real    :: h1, cpv1
  !------------------------------------------------------------------
  open(1,file=trim(filename))
  do i=1, 400
     read(1,*,iostat=io) t(i), h(i)
     if (io /= 0) exit
  enddo
  n = i - 1
  close(1)
  if (n > 400) stop 'increase dimension of T & h in cp'
  !
  case = 2 ! returns dy/dx(x), i.e., the slope at T
  call spline01(t, h, n, case, dble(t1), h1, cpv1)
  cpv = cpv1
  !
  return
end function cpv
