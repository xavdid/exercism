#[derive(Debug, PartialEq, Eq)]
pub enum Allergen {
    Eggs,
    Peanuts,
    Shellfish,
    Strawberries,
    Tomatoes,
    Chocolate,
    Pollen,
    Cats,
}

const ALL_ALLERGENS: [Allergen; 8] = [
    Allergen::Cats,
    Allergen::Pollen,
    Allergen::Chocolate,
    Allergen::Tomatoes,
    Allergen::Strawberries,
    Allergen::Shellfish,
    Allergen::Peanuts,
    Allergen::Eggs,
];

impl Allergen {
    fn value(&self) -> u32 {
        match self {
            Allergen::Eggs => 2_u32.pow(0),
            Allergen::Peanuts => 2_u32.pow(1),
            Allergen::Shellfish => 2_u32.pow(2),
            Allergen::Strawberries => 2_u32.pow(3),
            Allergen::Tomatoes => 2_u32.pow(4),
            Allergen::Chocolate => 2_u32.pow(5),
            Allergen::Pollen => 2_u32.pow(6),
            Allergen::Cats => 2_u32.pow(7),
        }
    }
}

pub struct Allergies {
    score: u32,
}

impl Allergies {
    pub fn new(score: u32) -> Self {
        Allergies { score }
    }

    pub fn is_allergic_to(&self, allergen: &Allergen) -> bool {
        self.score & allergen.value() == allergen.value()
    }

    pub fn allergies(&self) -> Vec<Allergen> {
        ALL_ALLERGENS
            .into_iter()
            .filter(|a| self.is_allergic_to(a))
            .collect()
    }
}
