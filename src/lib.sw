library;

use std::convert::TryFrom;

pub trait WrappingNeg {
    fn wrapping_neg(self) -> Self;
}

pub struct I8 {
    underlying: u8,
}

impl I8 {
    pub fn indent() -> u8 {
        128u8
    }
}

impl core::ops::Eq for I8 {
    fn eq(self, other: Self) -> bool {
        self.underlying == other.underlying
    }
}

impl I8 {
    const MIN: Self = Self {
        underlying: u8::min(),
    };

    pub fn from_uint(underlying: u8) -> Self {
        Self { underlying }
    }

    pub fn neg_try_from(value: u8) -> Option<Self> {
        if value <= Self::indent() {
            Some(Self {
                underlying: Self::indent() - value,
            })
        } else {
            None
        }
    }

    pub fn new() -> Self {
        Self {
            underlying: Self::indent(),
        }
    }
}


impl core::ops::Multiply for I8 {
    /// Multiply a I8 with a I8. Panics of overflow.
    fn multiply(self, other: Self) -> Self {
        let mut res = Self::new();
        if self.underlying >= Self::indent()
            && other.underlying >= Self::indent()
        {
            res = Self::from_uint(
                (self.underlying - Self::indent()) * (other.underlying - Self::indent()) + Self::indent(),
            );
        } else if self.underlying < Self::indent()
            && other.underlying < Self::indent()
        {
            res = Self::from_uint(
                (Self::indent() - self.underlying) * (Self::indent() - other.underlying) + Self::indent(),
            );
        } else if self.underlying >= Self::indent()
            && other.underlying < Self::indent()
        {
            res = Self::from_uint(
                Self::indent() - (self.underlying - Self::indent()) * (Self::indent() - other.underlying),
            );
        } else if self.underlying < Self::indent()
            && other.underlying >= Self::indent()
        {
            res = Self::from_uint(
                Self::indent() - (other.underlying - Self::indent()) * (Self::indent() - self.underlying),
            );
        }
        res
    }
}


impl WrappingNeg for I8 {
    fn wrapping_neg(self) -> Self {
        if self == Self::MIN {
            return Self::MIN
        }
        self * Self::neg_try_from(1u8).unwrap()
    }
}
