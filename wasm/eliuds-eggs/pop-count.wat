(module
  (func (export "eggCount") (param $number i32) (result i32)
    (local $res i32) ;; result
    (local $remainder i32) ;; loop counter

    (loop $loop

      ;; $res =
      (local.set $res
        ;; $res +
        (i32.add
          (local.get $res)
          ;; $number % 2
          (i32.rem_u
            (local.get $number)
            (i32.const 2)
          )
        )
      )

      ;; $number //= 2
      ;; (keep on stack)
      (local.tee $number
        (i32.div_u
          (local.get $number)
          (i32.const 2)
        )
      )

      ;; this will keep looping until remainder is 0
      br_if $loop
    )

    local.get $res
  )
)
