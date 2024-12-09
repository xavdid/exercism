fn spaces(num: usize) -> String {
    " ".repeat(num)
}
fn one_letter_row(c: char, spaces_around: usize) -> String {
    let gap = spaces(spaces_around);
    format!("{gap}{c}{gap}")
}
fn two_letter_row(c: char, spaces_around: usize, spaces_between: usize) -> String {
    let outer_gap = spaces(spaces_around);
    format!("{outer_gap}{c}{}{c}{outer_gap}", spaces(spaces_between),)
}

pub fn get_diamond(c: char) -> Vec<String> {
    // Determine the position of the character (A=0, B=1, ..., c)
    let upper_bound = (c as usize) - ('A' as usize);
    let total_width = 2 * upper_bound + 1;

    (0..total_width)
        .map(|k| {
            let spaces_before = (upper_bound as isize - k as isize).unsigned_abs();
            let current_char = (b'A'
                + (upper_bound as isize - (spaces_before as isize)).unsigned_abs() as u8)
                as char;

            if k == 0 || k == total_width - 1 {
                // Single letter row
                one_letter_row(current_char, spaces_before)
            } else {
                // Rows with letters on both ends
                two_letter_row(
                    current_char,
                    spaces_before,
                    2 * (upper_bound - spaces_before) - 1,
                )
            }
        })
        .collect()
}
