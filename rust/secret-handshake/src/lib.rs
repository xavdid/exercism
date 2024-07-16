pub fn actions(n: u8) -> Vec<&'static str> {
    let mut result = Vec::new();

    let bits = format!("{n:05b}");
    assert_eq!(bits.len(), 5);

    for (pos, bit) in bits.chars().rev().enumerate() {
        if bit == '1' {
            match pos {
                0 => result.push("wink"),
                1 => result.push("double blink"),
                2 => result.push("close your eyes"),
                3 => result.push("jump"),
                4 => result.reverse(),
                _ => panic!("invalid pos: {pos}"),
            }
        }
    }

    result
}
