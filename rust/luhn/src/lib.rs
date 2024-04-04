/// Check a Luhn checksum.
pub fn is_valid(code: &str) -> bool {
    if code.trim().len() <= 1 {
        return false;
    }

    if !code
        .chars()
        .all(|c| c.is_ascii_digit() || c.is_ascii_whitespace())
    {
        return false;
    }

    // this will alternate as we iterate / filter
    let mut should_double = false;

    let filtered_sum: u32 = code
        .chars()
        .rev()
        .filter_map(|c| match c.is_ascii_digit() {
            false => None,
            true => {
                let parsed = c.to_digit(10).expect("unabled to parse number from {c}");
                let result = if should_double {
                    if parsed > 4 {
                        parsed * 2 - 9
                    } else {
                        parsed * 2
                    }
                } else {
                    parsed
                };
                should_double = !should_double;
                Some(result)
            }
        })
        .sum();

    filtered_sum % 10 == 0
}
