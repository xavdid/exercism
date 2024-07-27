# adaptation of
# https://rosettacode.org/wiki/Zebra_puzzle#Alternative_Version_4
# and
# https://exercism.org/tracks/scala/exercises/zebra-puzzle/solutions/segfaultsourcery

from enum import Enum, auto
from functools import cache
from itertools import permutations


class PermutableEnum(Enum):
    @classmethod
    def permutations(cls):
        yield from permutations(cls)


class Color(PermutableEnum):
    RED = auto()
    GREEN = auto()
    BLUE = auto()
    IVORY = auto()
    YELLOW = auto()


class Drink(PermutableEnum):
    MILK = auto()
    COFFEE = auto()
    WATER = auto()
    OJ = auto()
    TEA = auto()


class Hobby(PermutableEnum):
    PAINTING = auto()
    CHESS = auto()
    FOOTBALL = auto()
    READING = auto()
    DANCING = auto()


class Pet(PermutableEnum):
    FOX = auto()
    SNAILS = auto()
    ZEBRA = auto()
    HORSE = auto()
    DOG = auto()


class Nationality(PermutableEnum):
    ENGLISH = auto()
    SPANISH = auto()
    NORWEGIAN = auto()
    JAPANESE = auto()
    UKRANIAN = auto()


@cache
def solve():
    # we're building a valid grid where each row is ordered based on the ordering of the Nationalities
    # possible rows are eliminated if they don't match a condition and only one will remain

    # the loops are ordered fewest to most dependents
    # that is, there are color rules that depend on nationality, but not vice versa
    for nations in Nationality.permutations():
        # 10. The Norwegian lives in the first house.
        if nations.index(Nationality.NORWEGIAN) != 0:
            continue

        for colors in Color.permutations():
            # 2. The Englishman lives in the red house.
            if nations.index(Nationality.ENGLISH) != colors.index(Color.RED):
                continue

            # 15. The Norwegian lives next to the blue house.
            # that plus #10 (above) means blue house must be in the second position
            if colors.index(Color.BLUE) != 1:
                continue

            # 6. The green house is immediately to the right of the ivory house.
            if colors.index(Color.IVORY) + 1 != colors.index(Color.GREEN):
                continue

            for hobbies in Hobby.permutations():
                # 8. The person in the yellow house is a painter.
                if colors.index(Color.YELLOW) != hobbies.index(Hobby.PAINTING):
                    continue

                # 14. The Japanese person plays chess.
                if nations.index(Nationality.JAPANESE) != hobbies.index(Hobby.CHESS):
                    continue

                for pets in Pet.permutations():
                    # 11. The person who enjoys reading lives in the house next to the person with the fox.
                    if abs(hobbies.index(Hobby.READING) - pets.index(Pet.FOX)) != 1:
                        continue

                    # 12. The painter's house is next to the house with the horse.
                    if abs(hobbies.index(Hobby.PAINTING) - pets.index(Pet.HORSE)) != 1:
                        continue

                    # 3. The Spaniard owns the dog.
                    if nations.index(Nationality.SPANISH) != pets.index(Pet.DOG):
                        continue

                    # 7. The snail owner likes to go dancing.
                    if pets.index(Pet.SNAILS) != hobbies.index(Hobby.DANCING):
                        continue

                    for drinks in Drink.permutations():
                        # 9. The person in the middle house drinks milk.
                        if drinks.index(Drink.MILK) != 2:
                            continue

                        # 5. The Ukrainian drinks tea.
                        if drinks.index(Drink.TEA) != nations.index(
                            Nationality.UKRANIAN
                        ):
                            continue

                        # 4. The person in the green house drinks coffee.
                        if colors.index(Color.GREEN) != drinks.index(Drink.COFFEE):
                            continue

                        # 13. The person who plays football drinks orange juice.
                        if hobbies.index(Hobby.FOOTBALL) != drinks.index(Drink.OJ):
                            continue

                        return {
                            "water": nations[drinks.index(Drink.WATER)],
                            "zebra": nations[pets.index(Pet.ZEBRA)],
                        }

    raise RuntimeError("no solution")


def drinks_water() -> str:
    return solve()["water"].name.capitalize()


def owns_zebra() -> str:
    return solve()["zebra"].name.capitalize()
