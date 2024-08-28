pub struct PascalsTriangle {
    row_count: u32,
}

fn row(n: u32) -> Vec<u32> {
    let mut res: Vec<u32> = vec![1];

    // https://en.wikipedia.org/wiki/Pascal%27s_triangle#Calculating_a_row_or_diagonal_by_itself
    for k in 1..=n {
        let last = res[(k - 1) as usize];
        res.push(last * (n + 1 - k) / k);
    }

    res
}

impl PascalsTriangle {
    pub fn new(row_count: u32) -> Self {
        Self { row_count }
    }

    pub fn rows(&self) -> Vec<Vec<u32>> {
        if self.row_count == 0 {
            vec![]
        } else {
            (0..self.row_count).map(row).collect()
        }
    }
}
