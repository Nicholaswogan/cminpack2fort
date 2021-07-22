module test_wrapper
  use, intrinsic :: iso_c_binding, only : c_ptr, c_loc, c_f_pointer
  implicit none
  
  integer, parameter :: real_kind = kind(1.0d0)
  
  type f_data
    real(real_kind) :: a
    real(real_kind) :: b
  end type
  
contains
  
  integer function mysub(p, n, x, fvec, iflag) result(res)
    type(c_ptr) :: p
    integer, value :: n
    real(real_kind), intent(in) :: x(n)
    real(real_kind) :: fvec(n)
    integer, value :: iflag
    type(f_data), pointer :: params
    
    call c_f_pointer(p, params) ! dereference pointer
    fvec(1) = x(1)**2.d0 - (params%a + params%b)
    
    res = 0
  end function
  
end module

program main
  use cminpack_wrapper, only: hybrd1c
  use test_wrapper, only: mysub, real_kind, f_data
  use, intrinsic :: iso_c_binding, only : c_loc, c_ptr
  implicit none

  type(f_data), target :: params
  type(c_ptr), target :: p
  integer :: n = 1
  real(real_kind) :: x(1)
  real(real_kind) :: fvec(1)
  real(real_kind) :: tol = 1.d-8
  integer :: lwa = (1*(3*1+13))/2+2
  integer :: info
  real(real_kind) :: wa((1*(3*1+13))/2+2)

  x = [10.0d0]
  params%a = 5.d0
  params%b = 5.d0
  
  p = c_loc(params) ! get pointer to params
  ! pass pointer to hybrd1c
  call hybrd1c(mysub, p, n, x, fvec, tol, info, wa, lwa)
  
  print*,x
  
end program
