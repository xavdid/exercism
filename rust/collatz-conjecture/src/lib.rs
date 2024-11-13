pub fn collatz(n: u64) -> Option<u64> {
    match n {
        0 => None,
        _ => Some(collatz_step(n, 0)),
    }
}

fn collatz_step(val: u64, step: u64) -> u64 {
    match val {
        1 => step,
        _ if val % 2 == 0 => collatz_step(val / 2, step + 1),
        _ => collatz_step(3 * val + 1, step + 1),
    }
}
