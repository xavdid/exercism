#[derive(Debug, PartialEq, Eq)]
pub enum Error {
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit(u32),
}

pub fn convert(number: &[u32], from_base: u32, to_base: u32) -> Result<Vec<u32>, Error> {
    if from_base < 2 {
        return Err(Error::InvalidInputBase);
    }

    if to_base < 2 {
        return Err(Error::InvalidOutputBase);
    }

    for d in number {
        if *d >= from_base {
            return Err(Error::InvalidDigit(*d));
        }
    }

    // .all on an empty iter returns truthy, so I don't need an explicit empty check
    if number.iter().all(|d| *d == 0) {
        return Ok(vec![0]);
    }

    let mut num = number.iter().fold(0, |acc, d| acc * from_base + d);

    let mut result: Vec<u32> = vec![];

    while num > 0 {
        result.push(num % to_base);
        num /= to_base;
    }

    result.reverse();

    Ok(result)
}
