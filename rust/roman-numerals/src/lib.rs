use std::fmt::{Display, Formatter, Result};

pub struct Roman(String);

// https://stackoverflow.com/a/4986630/1825390

const HUNDREDS: [&str; 10] = ["", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"];
const TENS: [&str; 10] = ["", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"];
const ONES: [&str; 10] = ["", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"];

impl Display for Roman {
    fn fmt(&self, _f: &mut Formatter<'_>) -> Result {
        write!(_f, "{}", self.0)
    }
}

impl Roman {
    pub fn from(mut num: u32) -> Self {
        let mut result = Vec::<&str>::new();

        while num >= 1_000 {
            result.push("M");
            num -= 1000;
        }

        result.push(HUNDREDS[(num / 100) as usize]);
        num %= 100;

        result.push(TENS[(num / 10) as usize]);
        num %= 10;

        result.push(ONES[num as usize]);

        Roman(String::from_iter(result))
    }
}
