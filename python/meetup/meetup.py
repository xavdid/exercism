from calendar import Calendar
from datetime import date


# subclassing the built-in ValueError to create MeetupDayException
class MeetupDayException(ValueError):
    """Exception raised when the Meetup weekday and count do not result in a valid date.

    message: explanation of the error.

    """

    def __init__(self):
        super().__init__("That day does not exist.")


def meetup(year: int, month: int, week: str, day_of_week: str) -> date:
    c = Calendar()

    weekday = [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday",
    ].index(day_of_week)

    days = list(
        d
        for d in c.itermonthdates(year, month)
        if d.weekday() == weekday and d.month == month
    )

    if week == "teenth":
        return next(d for d in days if 13 <= d.day <= 19)

    if week == "last":
        return days[-1]

    idx = ["first", "second", "third", "fourth", "fifth"].index(week)

    try:
        return days[idx]
    except IndexError:
        raise MeetupDayException
