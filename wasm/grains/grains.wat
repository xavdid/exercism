(module
  ;; squareNum is signed
  ;; Result is unsigned
  (func $square (export "square") (param $squareNum i32) (result i64)
    (local $i i32) ;; loop counter
    (local $res i64) ;; result

    ;; verify that $squareNum is >= 1
    local.get $squareNum ;; push input; [$squareNum]
    i32.const 0 ;; push 0; [$squareNum, 0]
    i32.le_s ;; push `$squreNum <= 0`; [result]
    (if
      (then
        (return (i64.const 0))
      )
    )

    ;; verify that $squareNum is <= 64
    local.get $squareNum ;; push input; [$squareNum]
    i32.const 65 ;; push 0; [$squareNum, 0]
    i32.ge_s ;; push `$squreNum <= 0`; [result]
    (if
      (then
        (return (i64.const 0))
      )
    )

    ;; return 1 for square 1 (2**0)
    local.get $squareNum ;; push input; [$squareNum]
    i32.const 1 ;; push 0; [$squareNum, 0]
    i32.eq ;; push `$squreNum <= 0`; [result]
    (if
      (then
        (return (i64.const 1))
      )
    )

    (local.set $i (i32.const 1))
    (local.set $res (i64.const 1))

    (loop $loop
      ;; res *= 2
      (local.set $res (i64.mul (local.get $res) (i64.const 2)))
      ;; i += 1
      (local.set $i (i32.add (local.get $i) (i32.const 1)))

      ;; check if counter is equal to $square
      ;; if it's not (yet), loop
      (i32.ne (local.get $i) (local.get $squareNum))
      br_if $loop
    )

    ;; i64.const 1 ;; deafult return
    local.get $res
  )

  ;; Result is unsigned
  (func (export "total") (result i64)
    (local $i i32) ;; loop counter
    (local $res i64) ;; result

    (local.set $i (i32.const 1))

    (loop $loop
      ;; $res += $square($i)
      (local.set $res (i64.add (local.get $res) (call $square (local.get $i))))

      ;; i += 1
      (local.set $i (i32.add (local.get $i) (i32.const 1)))

      ;; check if counter is equal to $square
      ;; if it's not (yet), loop
      (i32.le_u (local.get $i) (i32.const 64))
      br_if $loop
    )

    local.get $res
  )
)
