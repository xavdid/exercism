use std::collections::HashSet;

/// Determine whether a sentence is a pangram.
pub fn is_pangram(sentence: &str) -> bool {
    let chars: HashSet<char> = HashSet::from_iter(
        sentence
            .to_lowercase()
            .chars()
            .filter(|c| c.is_ascii_alphabetic()),
    );

    chars.len() == 26
}
