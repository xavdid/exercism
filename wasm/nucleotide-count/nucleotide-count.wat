(module
  (memory (export "mem") 1)
  (func
    (export "countNucleotides")
    (param $offset i32)
    (param $length i32)
    (result i32 i32 i32 i32)
      ;; initialize counters
      (local $countA i32)
      (local $countC i32)
      (local $countG i32)
      (local $countT i32)

      (local $i i32)  ;; instruction index
      (local $c i32)  ;; current character
      (local $valid i32)  ;; whether current character is valid

      ;; empty case - bail early if length is 0
      ;; could let this fall through, but it makes the invalid case more confusing
      local.get $length
      (if
        (then)
        (else
          (return
            (i32.const 0)
            (i32.const 0)
            (i32.const 0)
            (i32.const 0)
          )
        )
      )

      (loop $loop ;; declare a label to act as a jump target
        local.get $offset ;; push offset; [64]
        local.get $i ;; push instruction index; [64, 0]
        i32.add ;; add and push result; [64]

        i32.load8_u ;; push data at memory index; [71]
        local.set $c ;; pop and store data in var; []

        ;; check each character

        ;; push equality of local var and A (ACII 65); [0]
        (i32.eq (local.get $c) (i32.const 65))
        ;; if pop == 1, then; else; []
        (if
          (then
            ;; $countA = $countA + 1
            (local.set $countA (i32.add (local.get $countA) (i32.const 1)))
            (local.set $valid (i32.const 1))
          )
        )

        ;; check C
        (i32.eq (local.get $c) (i32.const 67))
        (if
          (then
            (local.set $countC (i32.add (local.get $countC) (i32.const 1)))
            (local.set $valid (i32.const 1))
          )
        )

        ;; check G
        (i32.eq (local.get $c) (i32.const 71))
        (if
          (then
            (local.set $countG (i32.add (local.get $countG) (i32.const 1)))
            (local.set $valid (i32.const 1))
          )
        )

        ;; check T
        (i32.eq (local.get $c) (i32.const 84))
        (if
          (then
            (local.set $countT (i32.add (local.get $countT) (i32.const 1)))
            (local.set $valid (i32.const 1))
          )
        )

        ;; if valid was never set to true, return the error state
        local.get $valid
        (if
          (then
            ;; reset validity
            (local.set $valid (i32.const 0))
          )
          (else
            (return
              (i32.const -1)
              (i32.const -1)
              (i32.const -1)
              (i32.const -1)
            )
          )
        )

        ;; increment instruction index
        (local.set $i (i32.add (local.get $i) (i32.const 1)))

        local.get $i ;; push instruction index
        local.get $length ;; push character length

        ;; decide if we're looping
        i32.lt_u ;; push result of `$i <= $length`;

        ;; goto $loop if popped item == 1
        br_if $loop
      )

      (return
        (local.get $countA)
        (local.get $countC)
        (local.get $countG)
        (local.get $countT)
      )
  )
)
