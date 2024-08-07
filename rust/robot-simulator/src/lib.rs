// The code below is a stub. Just enough to satisfy the compiler.
// In order to pass the tests you can add-to or change any of this code.

#[derive(PartialEq, Eq, Debug)]
pub enum Direction {
    North,
    East,
    South,
    West,
}

pub struct Robot {
    position: (i32, i32),
    direction: Direction,
}

impl Robot {
    pub fn new(x: i32, y: i32, direction: Direction) -> Self {
        Robot {
            position: (x, y),
            direction,
        }
    }

    #[must_use]
    pub fn turn_right(self) -> Self {
        Robot {
            direction: match self.direction {
                Direction::North => Direction::East,
                Direction::East => Direction::South,
                Direction::South => Direction::West,
                Direction::West => Direction::North,
            },
            ..self
        }
    }

    #[must_use]
    pub fn turn_left(self) -> Self {
        Robot {
            direction: match self.direction {
                Direction::North => Direction::West,
                Direction::West => Direction::South,
                Direction::South => Direction::East,
                Direction::East => Direction::North,
            },
            ..self
        }
    }

    #[must_use]
    pub fn advance(self) -> Self {
        let offset = match self.direction {
            Direction::North => (0, 1),
            Direction::South => (0, -1),
            Direction::East => (1, 0),
            Direction::West => (-1, 0),
        };
        let position = (self.position.0 + offset.0, self.position.1 + offset.1);

        Robot { position, ..self }
    }

    #[must_use]
    pub fn instructions(self, instructions: &str) -> Self {
        match instructions.chars().next() {
            Some(c) => match c {
                'L' => self.turn_left(),
                'R' => self.turn_right(),
                'A' => self.advance(),
                _ => panic!("unknown letter: {c}"),
            }
            .instructions(&instructions[1..]),
            None => self,
        }
    }

    pub fn position(&self) -> (i32, i32) {
        self.position
    }

    pub fn direction(&self) -> &Direction {
        &self.direction
    }
}
