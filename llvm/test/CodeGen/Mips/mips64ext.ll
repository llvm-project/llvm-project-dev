; RUN: llc  < %s -march=mips64el -mcpu=mips64 -mattr=n64 | FileCheck %s 

define i64 @zext64_32(i32 %a) nounwind readnone {
entry:
; CHECK: addiu $[[R0:[0-9]+]], ${{[0-9]+}}, 2
; CHECK: dsll $[[R1:[0-9]+]], $[[R0]], 32
; CHECK: dsrl ${{[0-9]+}}, $[[R1]], 32
  %add = add i32 %a, 2
  %conv = zext i32 %add to i64
  ret i64 %conv
}
