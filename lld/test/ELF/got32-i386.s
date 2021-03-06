# REQUIRES: x86
# RUN: llvm-mc -filetype=obj -triple=i686-pc-linux %s -o %t.o
# RUN: ld.lld %t.o -o %t
# RUN: llvm-objdump -section-headers -d %t | FileCheck %s

## We have R_386_GOT32 relocation here.
.globl foo
.type foo, @function
foo:
 nop

_start:
 movl foo@GOT, %ebx

## 73728 == 0x12000 == ADDR(.got)
# CHECK:       _start:
# CHECK-NEXT:   11001: 8b 1d {{.*}}  movl 73728, %ebx
# CHECK: Sections:
# CHECK:  Name Size     Address
# CHECK:  .got 00000004 0000000000012000

# RUN: not ld.lld %t.o -o %t -pie 2>&1 | FileCheck %s --check-prefix=ERR
# ERR: relocation R_386_GOT32 against 'foo' without base register can not be used when PIC enabled
