extern crate nth_prime as np;

fn main() {
    println!("Result: {}", np::nth(10001).unwrap());
}
