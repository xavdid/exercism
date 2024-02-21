from typing import Callable


def append(list1: list, list2: list) -> list:
    return list1 + list2


def concat(lists: list[list]) -> list:
    result = []

    for l in lists:
        for i in l:
            result.append(i)

    return result


def filter(function: Callable[[int], bool], list: list[int]):
    result = []

    for i in list:
        if function(i):
            result.append(i)

    return result


def length(list: list) -> int:
    if list == []:
        return 0

    return 1 + length(list[1:])


def map(function: Callable[[int], int], list: list[int]) -> list[int]:
    result = []

    for i in list:
        result.append(function(i))

    return result


def foldl(function, list, initial):
    result = initial

    for i in list:
        result = function(result, i)

    return result


def foldr(function, list, initial):
    return foldl(function, reverse(list), initial)


def reverse(list) -> list:
    result = []

    for i in range(len(list) - 1, -1, -1):
        result.append(list[i])

    return result
