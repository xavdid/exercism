from datetime import date


def leap_year(year):
    try:
        return bool(date(year, 2, 29))
    except ValueError:
        return False
