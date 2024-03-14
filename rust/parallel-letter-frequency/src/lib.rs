use std::collections::HashMap;

// TODO actually parallelize this
pub fn frequency(input: &[&str], worker_count: usize) -> HashMap<char, usize> {
    let mut result: HashMap<char, usize> = HashMap::new();

    for line in input {
        for c in line.chars() {
            if !c.is_alphabetic() {
                continue;
            }
            result
                .entry(c.to_lowercase().next().unwrap())
                .and_modify(|v| *v += 1)
                .or_insert(1);
        }
    }

    result
}
