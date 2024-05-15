use std::collections::HashMap;

pub fn annotate(minefield: &[&str]) -> Vec<String> {
    let grid: HashMap<(i32, i32), char> = minefield
        .iter()
        .enumerate()
        .flat_map(|(row, line)| {
            line.as_bytes()
                .iter()
                .enumerate()
                .map(move |(col, c)| ((row as i32, col as i32), *c as char))
        })
        .collect();

    (0..(minefield.len() as i32))
        .map(|row| {
            (0..(minefield[0].len() as i32))
                .map(|col| {
                    if grid.get(&(row, col)).unwrap() == &'*' {
                        '*'
                    } else {
                        let v = [
                            (row - 1, col - 1),
                            (row - 1, col),
                            (row - 1, col + 1),
                            (row, col - 1),
                            (row, col + 1),
                            (row + 1, col - 1),
                            (row + 1, col),
                            (row + 1, col + 1),
                        ]
                        .map(|neighbor| match grid.get(&neighbor) {
                            Some(c) if *c == '*' => 1,
                            _ => 0,
                        })
                        .iter()
                        .sum();

                        if v == 0 {
                            ' '
                        } else {
                            char::from_digit(v, 10).unwrap()
                        }
                    }
                })
                .collect()
        })
        .collect()
}
