pub fn is_armstrong_number(num: u32) -> bool {
    let digits = num.to_string();
    let num_digits: u32 = u32::try_from(digits.len()).unwrap();

    digits
        .chars()
        .map(|c| c.to_digit(10).unwrap().pow(num_digits))
        .sum::<u32>()
        == num
}
