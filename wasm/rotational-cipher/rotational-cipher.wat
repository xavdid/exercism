(module
  (memory (export "mem") 1)

  ;; functionally doing `chr(((ord($letter)-$aIndex+$distance)%26)+$aIndex)`
  (func $rotate
    (param $letter i32)
    (param $distance i32)
    (param $aIndex i32) ;; 65 or 97
    (result i32)

    (i32.sub (local.get $letter) (local.get $aIndex))
    local.get $distance
    i32.add

    i32.const 26
    i32.rem_u

    local.get $aIndex
    i32.add
  )

  (func
    (export "rotate")
    (param $textOffset i32)
    (param $textLength i32)
    (param $shiftKey i32)
    (result i32 i32)
      (local $i i32)  ;; instruction index
      (local $letter i32)  ;; current character
      (local $currentPosition i32)  ;; current character

      (loop $loop
        (local.set $currentPosition (i32.add (local.get $textOffset) (local.get $i)))

        ;; read current letter
        (local.set $letter (i32.load8_u (local.get $currentPosition)))

        ;; if 65 <= letter <= 90, call $rotate and store the result in place
        (i32.and
          (i32.ge_u (local.get $letter) (i32.const 65))
          (i32.le_u (local.get $letter) (i32.const 90))
        )
        (if
          (then
            (i32.store8
              (local.get $currentPosition)
              (call
                $rotate
                (local.get $letter)
                (local.get $shiftKey)
                (i32.const 65)
              )
            )
          )
        )

        ;; if 97 <= letter <= 122, call $rotateLower and store the result in place
        (i32.and
          (i32.ge_u (local.get $letter) (i32.const 97))
          (i32.le_u (local.get $letter) (i32.const 122))
        )
        (if
          (then
            (i32.store8
              (local.get $currentPosition)
              (call
                $rotate
                (local.get $letter)
                (local.get $shiftKey)
                (i32.const 97)
              )
            )
          )
        )

        ;; increment instruction index
        (local.set $i (i32.add (local.get $i) (i32.const 1)))

        ;; loop if $i < $textLength
        (br_if $loop (i32.lt_u (local.get $i) (local.get $textLength)))
      )


    (return (local.get $textOffset) (local.get $textLength))
  )
)
