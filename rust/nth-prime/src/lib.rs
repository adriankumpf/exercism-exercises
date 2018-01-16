pub fn nth(n: u32) -> Result<u32, &'static str> {
    if n == 0 {
        return Err("Index must be > 0");
    }

    let mut count = 0;

    for i in 2.. {
        if is_prime(i) {
            count += 1;

            if count == n {
                return Ok(i);
            }
        }
    }

    Err("Number too large")
}

fn is_prime(n: u32) -> bool {
    for i in 2..sqrt(n) {
        if n % i == 0 {
            return false;
        }
    }

    true
}

fn sqrt(n: u32) -> u32 {
    (n as f32).sqrt() as u32 + 1
}
