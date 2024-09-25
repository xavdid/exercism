use std::collections::HashSet;

pub fn check(candidate: &str) -> bool {
    let letters: Vec<char> = candidate
        .to_ascii_lowercase()
        .chars()
        .filter(|c| c.is_ascii_alphabetic())
        .collect();

    letters.len() == HashSet::<char>::from_iter(letters).len()
}
