use std::collections::{HashMap, HashSet};

fn char_counts(word: &str) -> HashMap<char, u8> {
    word.chars().fold(HashMap::new(), |mut result, c| {
        *result.entry(c.to_lowercase().next().unwrap()).or_insert(0) += 1;
        result
    })
}

pub fn anagrams_for<'a>(word: &str, possible_anagrams: &[&'a str]) -> HashSet<&'a str> {
    let target = char_counts(word);

    possible_anagrams
        .iter()
        .filter(|w| w.to_lowercase() != word.to_lowercase() && char_counts(w) == target)
        .copied()
        .collect()
}
