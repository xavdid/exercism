use std::cmp::Ordering::{Equal, Greater, Less};

pub fn find<T: Ord>(array: impl AsRef<[T]>, key: T) -> Option<usize> {
    let array = array.as_ref();

    if array.is_empty() {
        return None;
    }

    let mut low = 0;
    let mut high = array.len() - 1;

    while low <= high {
        let mid = (low + high) / 2;

        match array[mid].cmp(&key) {
            Equal => return Some(mid),
            Less => {
                low = mid + 1;
            }
            Greater if mid > 0 => {
                high = mid - 1;
            }
            _ => break,
        }
    }

    None
}
