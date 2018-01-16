pub fn reply(message: &str) -> &str {
    match message.trim() {
        m if is_silence(m) => "Fine. Be that way!",
        m if is_shouting(m) && is_question(m) => "Calm down, I know what I'm doing!",
        m if is_question(m) => "Sure.",
        m if is_shouting(m) => "Whoa, chill out!",
        _ => "Whatever.",
    }
}

fn is_question(msg: &str) -> bool {
    msg.ends_with('?')
}
fn is_shouting(msg: &str) -> bool {
    msg.to_ascii_uppercase() == msg && msg.to_ascii_lowercase() != msg
}
fn is_silence(msg: &str) -> bool {
    msg.is_empty()
}
