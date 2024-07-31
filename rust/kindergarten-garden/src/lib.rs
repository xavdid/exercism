fn letter_to_plant(c: char) -> &'static str {
    match c {
        'G' => "grass",
        'C' => "clover",
        'R' => "radishes",
        'V' => "violets",
        _ => panic!("unknown letter"),
    }
}

fn offset(student: &str) -> usize {
    match "ABCDEFGHIJKL".find(student.chars().next().unwrap()) {
        Some(i) => i * 2,
        None => panic!("unable to find offset"),
    }
}

pub fn plants(diagram: &str, student: &str) -> Vec<&'static str> {
    diagram
        .split('\n')
        .flat_map(|row| row.chars().skip(offset(student)).take(2))
        .map(letter_to_plant)
        .collect()
}
