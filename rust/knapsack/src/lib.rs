use std::ops::Add;

use itertools::Itertools;

#[derive(Debug, Clone, Copy)]
pub struct Item {
    pub weight: u32,
    pub value: u32,
}

impl Add for Item {
    type Output = Item;

    fn add(self, rhs: Self) -> Self::Output {
        Self {
            weight: self.weight + rhs.weight,
            value: self.value + rhs.value,
        }
    }
}

pub fn maximum_value(max_weight: u32, items: &[Item]) -> u32 {
    items
        .iter()
        .powerset()
        .map(|s| {
            let result = s.iter().fold(
                Item {
                    weight: 0,
                    value: 0,
                },
                |acc, item| acc + **item,
            );

            if result.weight <= max_weight {
                result.value
            } else {
                0
            }
        })
        .max()
        .unwrap()
}
