/// given a 10 digit char, are the 0th and 3rd indexes >= 2?
fn nums_to_str(nums: &[u32]) -> String {
    nums.iter().map(|n| n.to_string()).collect()
}

pub fn number(user_number: &str) -> Option<String> {
    let simplified: Vec<_> = user_number
        .chars()
        .filter(|c| c.is_ascii_digit())
        .map(|c| c.to_digit(10).unwrap())
        .collect();

    match simplified.len() {
        10 if simplified[0] >= 2 && simplified[3] >= 2 => Some(nums_to_str(&simplified)),
        11 if simplified[1] >= 2 && simplified[4] >= 2 && simplified[0] == 1 => {
            Some(nums_to_str(&simplified[1..]))
        }
        _ => None,
    }
}
