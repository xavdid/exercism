import "random" for Random

var Die = Random.new()

class Character {
  static rollAbility() {
    return (1..4).map { Die.int(1, 7) }.toList
      .sort()
      .skip(1)
      .reduce { | total, e | total + e }
  }

  construct new() {
    _str = Character.rollAbility()
    _dex = Character.rollAbility()
    _con = Character.rollAbility()
    _int = Character.rollAbility()
    _wis = Character.rollAbility()
    _cha = Character.rollAbility()
    _hp = 10 + Util.abilityModifier(_cha)
  }

  strength { _str }
  dexterity { _dex }
  constitution { _cha }
  intelligence { _int }
  wisdom { _wis }
  charisma { _cha }
  hitpoints { _hp }
}

class Util {
  static abilityModifier (n) {
    if (n < 3) {
      Fiber.abort("Ability scores must be at least 3")
    }

    if (n > 18) {
      Fiber.abort("Ability scores can be at most 18")
    }

    return ((n - 10) / 2).floor
  }
}
