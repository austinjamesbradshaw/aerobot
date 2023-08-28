subroutine readtable (n)
  use th
  implicit none
  integer io, i, istatus
  integer, intent(out) :: n
  real    fake
!-------------------------------------------------
  open(1,file='th.dat')
  n = 1
  do
     read(1,*,iostat=io) fake, fake
     if (io == -1) exit
     n = n + 1
  enddo
  n = n - 1
! 
  allocate(t(n), h(n), stat=istatus)
  if (istatus /= 0) then
     write (*, *) "Failed to allocate tv, hv", n
     stop 'stopped due to allocation failure in readtable'
  end if
  rewind (1)
!
  do i = 1, n
     read(1,*,iostat=io) t(i), h(i)
     if (io /= 0) then
        write(*,*) i, n
        stop 'stopped in readtable'
     end if
  enddo
  close(1)
!
  return
end subroutine readtable
