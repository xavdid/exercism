use std::collections::HashMap;

pub fn primes_up_to(upper_bound: u64) -> Vec<u64> {
    if upper_bound < 2 {
        return vec![];
    }

    let mut numbers: HashMap<u64, bool> = (2..=upper_bound).map(|k| (k, true)).collect();

    for i in 2..=upper_bound {
        for m in 2..=upper_bound / i {
            numbers.insert(m * i, false);
        }
    }

    let mut result: Vec<u64> = numbers
        .iter()
        .filter(|(_, v)| **v)
        .map(|(k, _)| *k)
        .collect();
    result.sort();

    result
}
