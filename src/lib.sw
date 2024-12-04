library;

pub struct I8 {
    underlying: u8,
}

impl I8 {
    const MIN: Self = Self {
        underlying: u8::min(),
    };
}

impl I8 {
    pub fn foo() {
        let x = Self::MIN;
        log(x);
    }
}