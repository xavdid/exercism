const VOWEL_CLUSTERS: [&str; 7] = ["a", "e", "i", "o", "u", "yt", "xr"];
const CONSONANT_CLUSTERS: [&str; 6] = ["ch", "thr", "th", "sch", "rh", "qu"];

pub fn translate(input: &str) -> String {
    input
        .split(' ')
        .map(|w| {
            for v in VOWEL_CLUSTERS {
                if w.starts_with(v) {
                    return format!("{w}ay");
                }
            }

            for c in CONSONANT_CLUSTERS {
                if w.starts_with(c) {
                    return format!("{}{}ay", w.strip_prefix(c).unwrap(), c);
                }
            }

            if w.chars().skip(1).take(2).collect::<String>() == "qu" {
                return format!("{}{}ay", &w[3..], &w[..3]);
            }

            // default case - consonants
            format!("{}{}ay", &w[1..], &w.chars().next().unwrap())
        })
        .collect::<Vec<String>>()
        .join(" ")
}
