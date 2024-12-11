#[derive(Debug, PartialEq, Eq)]
pub enum Error {
    SpanTooLong,
    InvalidDigit(char),
    Misc,
}

pub fn lsp(string_digits: &str, span: usize) -> Result<u64, Error> {
    if span > string_digits.len() {
        return Err(Error::SpanTooLong);
    }

    (0..=string_digits.len() - span)
        .map(|s| {
            string_digits
                .chars()
                .skip(s)
                .take(span)
                .map(|c| c.to_digit(10).ok_or(Error::InvalidDigit(c)).map(u64::from))
                // have to collect in the middle for error handling reasons
                .collect::<Result<Vec<u64>, _>>()
                .and_then(|digits| {
                    digits
                        .into_iter()
                        .reduce(|acc, e| acc * e)
                        .ok_or(Error::Misc)
                })
        })
        .collect::<Result<Vec<u64>, _>>()
        .and_then(|products| products.into_iter().max().ok_or(Error::Misc))
}
