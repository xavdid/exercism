pub struct CircularBuffer<T> {
    data: Vec<T>,
}

#[derive(Debug, PartialEq, Eq)]
pub enum Error {
    EmptyBuffer,
    FullBuffer,
}

impl<T> CircularBuffer<T> {
    pub fn new(capacity: usize) -> Self {
        CircularBuffer {
            data: Vec::with_capacity(capacity),
        }
    }

    pub fn write(&mut self, _element: T) -> Result<(), Error> {
        if self.is_full() {
            Err(Error::FullBuffer)
        } else {
            self.data.push(_element);
            Ok(())
        }
    }

    pub fn read(&mut self) -> Result<T, Error> {
        if self.data.len() == 0 {
            Err(Error::EmptyBuffer)
        } else {
            let result = self.data.remove(0);
            Ok(result)
        }
    }

    pub fn clear(&mut self) {
        self.data.clear()
    }

    pub fn overwrite(&mut self, _element: T) {
        if self.is_full() {
            self.read().unwrap();
        }
        self.write(_element).unwrap()
    }

    fn is_full(&self) -> bool {
        self.data.capacity() == self.data.len()
    }
}
