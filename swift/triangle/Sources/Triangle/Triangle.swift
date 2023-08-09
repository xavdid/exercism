//Solution goes in Sources

struct Result {
  let kind: String
}

func Triangle(_ x: Double, _ y: Double,_ z: Double) -> Result {
  var sides = [x,y,z]
  sides.sort()

  for s in sides {
    if s <= 0 {
      return Result(kind: "ErrorKind")
    }
  }

  if sides[0] + sides[1] < sides[2] {
    return Result(kind: "ErrorKind")
  }

  switch Set(sides).count {
  case 1:
    return Result(kind: "Equilateral")
  case 2:
    return Result(kind: "Isosceles")
  default:
    return Result(kind: "Scalene")
  }
}
