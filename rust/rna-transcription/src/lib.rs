pub trait NucleicAcid: Sized {
    const VALID_LETTERS: &'static str;
    fn build(sequence: &str) -> Result<Self, usize>;
}

#[derive(Debug, PartialEq, Eq)]
pub struct Dna {
    sequence: String,
}

#[derive(Debug, PartialEq, Eq)]
pub struct Rna {
    sequence: String,
}

macro_rules! impl_nucleic_acid {
    ($name:ident, $letters:expr) => {
        impl NucleicAcid for $name {
            const VALID_LETTERS: &'static str = $letters;
            fn build(dna: &str) -> Result<Self, usize> {
                for (idx, c) in dna.chars().enumerate() {
                    if !Self::VALID_LETTERS.contains(c) {
                        return Err(idx);
                    }
                }
                Ok(Self {
                    sequence: dna.to_string(),
                })
            }
        }
    };
}

impl_nucleic_acid!(Dna, "GCTA");
impl_nucleic_acid!(Rna, "CGAU");

impl Dna {
    // little wrapper so tests don't need the trait
    pub fn new(sequence: &str) -> Result<Self, usize> {
        Self::build(sequence)
    }

    pub fn into_rna(self) -> Rna {
        let sequence: String = self
            .sequence
            .chars()
            .map(|c| match c {
                'G' => 'C',
                'C' => 'G',
                'T' => 'A',
                'A' => 'U',
                _ => panic!("invalid char: {c}"),
            })
            .collect();

        Rna { sequence }
    }
}

impl Rna {
    // little wrapper so tests don't need the trait
    pub fn new(sequence: &str) -> Result<Self, usize> {
        Self::build(sequence)
    }
}
