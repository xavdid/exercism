use std::collections::HashMap;

#[derive(Debug)]
pub enum Category {
    Ones,
    Twos,
    Threes,
    Fours,
    Fives,
    Sixes,
    FullHouse,
    FourOfAKind,
    LittleStraight,
    BigStraight,
    Choice,
    Yacht,
}

type Dice = [u8; 5];

fn count_num(dice: Dice, num: u8) -> u8 {
    dice.iter().filter(|c| **c == num).count() as u8 * num
}

pub fn score(dice: Dice, category: Category) -> u8 {
    let mut dice = dice;
    dice.sort();

    let totals = dice.iter().fold(HashMap::new(), |mut res, e| {
        *res.entry(*e).or_insert(0) += 1;
        res
    });

    let mut counts: Vec<u8> = totals.clone().into_values().collect();
    counts.sort_unstable();

    println!("{dice:?} {counts:?}");

    match category {
        Category::Yacht if dice.iter().all(|c| *c == dice[0]) => 50,
        Category::Ones => count_num(dice, 1),
        Category::Twos => count_num(dice, 2),
        Category::Threes => count_num(dice, 3),
        Category::Fours => count_num(dice, 4),
        Category::Fives => count_num(dice, 5),
        Category::Sixes => count_num(dice, 6),
        Category::FullHouse if counts == vec![2, 3] => dice.iter().sum(),
        Category::FourOfAKind => match totals.clone().into_iter().find(|(_, num)| *num >= 4) {
            Some((die, _)) => die * 4,
            None => 0,
        },
        Category::LittleStraight if dice == [1, 2, 3, 4, 5] => 30,
        Category::BigStraight if dice == [2, 3, 4, 5, 6] => 30,
        Category::Choice => dice.iter().sum(),
        _ => 0,
    }
}
