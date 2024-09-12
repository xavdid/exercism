pub fn rotate(input: &str, key: u8) -> String {
    input
        .chars()
        .map(|c| {
            if c.is_ascii_alphabetic() {
                // informs how to get to the 0-26 range
                let offset = if c.is_ascii_uppercase() { 'A' } else { 'a' } as u8;

                let base = c as u8 - offset;
                let shifted = (base + key) % 26;

                (shifted + offset) as char
            } else {
                c
            }
        })
        .collect()
}
