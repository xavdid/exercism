use std::collections::HashMap;

const STOP: &str = "stop codon";

pub struct CodonsInfo<'a> {
    lookup_table: HashMap<&'a str, &'a str>,
}

impl<'a> CodonsInfo<'a> {
    pub fn name_for(&self, codon: &str) -> Option<&'a str> {
        match self.lookup_table.get(codon) {
            Some(x) => Some(x),
            None => None,
        }
    }

    pub fn of_rna(&self, rna: &str) -> Option<Vec<&'a str>> {
        let mut res: Vec<&'a str> = Vec::new();

        for c in rna.chars().collect::<Vec<char>>().chunks(3) {
            let codon: String = c.iter().collect();

            match self.name_for(&codon) {
                None => {
                    return None;
                }
                Some(name) if name == STOP => {
                    // bail early if we hit the stop
                    return Some(res);
                }
                Some(name) => res.push(name),
            }
        }

        Some(res)
    }
}

pub fn parse<'a>(pairs: Vec<(&'a str, &'a str)>) -> CodonsInfo<'a> {
    CodonsInfo {
        // https://stackoverflow.com/questions/30441698/how-do-i-create-a-map-from-a-list-in-a-functional-way
        lookup_table: pairs.into_iter().collect(),
    }
}
