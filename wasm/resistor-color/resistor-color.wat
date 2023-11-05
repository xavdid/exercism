(module
  (memory (export "mem") 1)
  (data (i32.const 200) "black")

  ;; Return buffer of comma separated colors
  ;; black,brown,red,orange,yellow,green,blue,violet,grey,white
  (func (export "colors") (result i32 i32)
    (return (i32.const 200) (i32.const 58))
  )

  ;; Called each time a module is initialized
  ;; Can be used to populate globals similar to a constructor
  (func $initialize)
  (start $initialize)

  ;; Given a valid resistor color, returns the associated value
  (func (export "colorCode") (param $offset i32) (param $len i32) (result i32)
    (i32.eq
      (i32.load8_u (local.get $offset))
      (i32.const 119) ;; w
    )
    (if
      (then (return (i32.const 9)))
    )

    (i32.eq
      (i32.load8_u (local.get $offset))
      (i32.const 98) ;; b
    )
    (if
      (then (return (i32.const 0)))
    )

    (i32.eq
      (i32.load8_u (local.get $offset))
      (i32.const 111) ;; o
    )
    (if
      (then (return (i32.const 3)))
    )

    (return (i32.const -1))
  )
)
