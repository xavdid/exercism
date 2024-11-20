pub fn encode(source: &str) -> String {
    let mut result = String::new();
    let mut input = source;

    while !input.is_empty() {
        let c = input.chars().next().unwrap();
        let width = input.chars().take_while(|h| *h == c).count();
        match width {
            0 => panic!("0 width for head??"),
            1 => result.push(c),
            _ => result.push_str(&format!("{width}{c}")),
        }
        input = &input[width..]
    }

    result
}

pub fn decode(source: &str) -> String {
    let mut result = String::new();
    let mut input = source;

    while !input.is_empty() {
        let len_str = input
            .chars()
            .take_while(|c| c.is_ascii_digit())
            .collect::<String>();

        if len_str.is_empty() {
            // letter, just add it
            result.push(input.chars().next().unwrap());
            input = &input[1..];
        } else {
            let len: usize = len_str.parse().expect("unable to parse len str!");
            result.push_str(&String::from(input.chars().nth(len_str.len()).unwrap()).repeat(len));
            input = &input[len_str.len() + 1..]
        }
    }

    result
}
