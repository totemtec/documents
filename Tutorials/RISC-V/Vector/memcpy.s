# Demo from https://pawelperek.github.io/eeric/


.text
main:
    li a0, 0xA0      # 目标内存地址
    la a1, to_copy   # 源内存地址
    li a2, 76        # 拷贝长度，字节数

    call memcpy
    j finish

memcpy:
    mv a3, a0 # Copy destination
loop:
  vsetvli t0, a2, e8, m8, ta, ma   # Vectors of 8b
  vle8.v v0, (a1)                  # Load bytes
    add a1, a1, t0                 # Bump pointer
    sub a2, a2, t0                 # Decrement count
  vse8.v v0, (a3)                  # Store bytes
    add a3, a3, t0                 # Bump pointer
    bnez a2, loop                  # Any more?
    ret                            # Return
    
finish:
    
.data
to_copy:
    .asciz "Hello, world! abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"