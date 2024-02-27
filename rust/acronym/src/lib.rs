pub fn abbreviate(phrase: &str) -> String {
    phrase
        .replace('-', " ")
        .chars()
        .filter(|c| c.is_ascii_whitespace() || c.is_ascii_alphabetic())
        .collect::<String>()
        .split_whitespace()
        .map(|w| {
            // separate out
            if w.chars().all(|c| c.is_uppercase()) {
                w.chars().next().unwrap().to_string()
            } else {
                w.to_string()
            }
        })
        .fold(String::new(), |mut v, c| {
            c.char_indices()
                .filter(|(i, c)| *i == 0 || c.is_uppercase())
                .for_each(|c| v += c.1.to_uppercase().to_string().as_str());

            v
        })
}
