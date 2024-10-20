use std::collections::{HashMap, HashSet};

pub struct School {
    _students: HashSet<String>,
    _grades: HashMap<u32, Vec<String>>,
}

impl School {
    pub fn new() -> School {
        School {
            _students: HashSet::new(),
            _grades: HashMap::new(),
        }
    }

    pub fn add(&mut self, grade: u32, student: &str) {
        let s = String::from(student);
        if !self._students.insert(s.clone()) {
            return;
        }

        self._grades
            .entry(grade)
            .and_modify(|v| v.push(s))
            .or_insert(vec![String::from(student)]);
    }

    pub fn grades(&self) -> Vec<u32> {
        let mut res: Vec<u32> = self._grades.keys().cloned().collect();
        res.sort();
        res
    }

    // If `grade` returned a reference, `School` would be forced to keep a `Vec<String>`
    // internally to lend out. By returning an owned vector of owned `String`s instead,
    // the internal structure can be completely arbitrary. The tradeoff is that some data
    // must be copied each time `grade` is called.
    pub fn grade(&self, grade: u32) -> Vec<String> {
        let mut v = self._grades.get(&grade).unwrap_or(&vec![]).clone();
        v.sort();
        v
    }
}
