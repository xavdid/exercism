use std::cmp::min;
use std::collections::HashSet;

#[derive(PartialEq, Eq, Debug)]
pub enum Bucket {
    One,
    Two,
}

/// A struct to hold your results in.
#[derive(PartialEq, Eq, Debug)]
pub struct BucketStats {
    /// The total number of "moves" it should take to reach the desired number of liters, including
    /// the first fill.
    pub moves: u8,
    /// Which bucket should end up with the desired number of liters? (Either "one" or "two")
    pub goal_bucket: Bucket,
    /// How many liters are left in the other bucket?
    pub other_bucket: u8,
}

type Buckets = (u8, u8);
/// Solve the bucket problem
pub fn solve(
    capacity_1: u8,
    capacity_2: u8,
    goal: u8,
    start_bucket: &Bucket,
) -> Option<BucketStats> {
    let start = if matches!(start_bucket, Bucket::One) {
        (capacity_1, 0)
    } else {
        (0, capacity_2)
    };
    let mut queue: Vec<Buckets> = vec![start];
    let mut seen: HashSet<Buckets> = HashSet::new();

    for moves in 1.. {
        if queue.is_empty() {
            break;
        }

        let mut next_queue: Vec<Buckets> = vec![];

        while let Some(buckets) = queue.pop() {
            if buckets.0 == goal {
                return Some(BucketStats {
                    moves,
                    goal_bucket: Bucket::One,
                    other_bucket: buckets.1,
                });
            }
            if buckets.1 == goal {
                return Some(BucketStats {
                    moves,
                    goal_bucket: Bucket::Two,
                    other_bucket: buckets.0,
                });
            }

            if !seen.insert(buckets) {
                continue;
            }

            let (l, r) = buckets;

            // 3 actions:

            // 1a: pour l into r
            if l > 0 && r < capacity_2 {
                let space = min(l, capacity_2 - r);
                next_queue.push((l - space, r + space));
            }

            // 1b: pour r into l
            if r > 0 && l < capacity_1 {
                let space = min(r, capacity_1 - l);
                next_queue.push((l + space, r - space));
            }

            // 2a: empty l - can't leave start bucket empty
            if l > 0 {
                next_queue.push((0, r));
            }

            // 2b: empty r - can't leave start bucket empty
            if r > 0 {
                next_queue.push((l, 0));
            }

            // 3a: fill l - don't fill the non-starting bucket if start is empty
            if l < capacity_1 {
                next_queue.push((capacity_1, r));
            }

            // 3b: fill r - don't fill the non-starting bucket if start is empty
            if r < capacity_2 {
                next_queue.push((l, capacity_2));
            }
        }

        queue = next_queue
            .into_iter()
            // filter invalid cases
            .filter(|(l, r)| !match start_bucket {
                Bucket::One => *l == 0 && *r == capacity_2,
                Bucket::Two => *r == 0 && *l == capacity_1,
            })
            .collect();
    }

    None
}
