fn other(c: char) -> char {
    match c {
        ']' => '[',
        '}' => '{',
        ')' => '(',
        _ => panic!("unknown char: {c}"),
    }
}

pub fn brackets_are_balanced(string: &str) -> bool {
    let mut stack: Vec<char> = Vec::new();

    for c in string.chars() {
        match c {
            '[' | '{' | '(' => stack.push(c),
            ']' | '}' | ')' if other(c) == *stack.last().unwrap_or(&'x') => {
                stack.pop().unwrap();
            }
            ']' | '}' | ')' => return false,
            _ => {}
        };
    }
    stack.is_empty()
}
