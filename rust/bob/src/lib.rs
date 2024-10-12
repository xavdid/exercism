pub fn reply(message: &str) -> &str {
    let message = message.trim();

    if message.is_empty() {
        return "Fine. Be that way!";
    }

    let letters: String = message
        .chars()
        .filter(|c| c.is_ascii_alphabetic())
        .collect();

    if !letters.is_empty() && letters.chars().all(|c| c.is_ascii_uppercase()) {
        // screaming
        if message.ends_with('?') {
            return "Calm down, I know what I'm doing!";
        }
        return "Whoa, chill out!";
    }

    if message.ends_with('?') {
        return "Sure.";
    }

    "Whatever."
}
