import Std

-- part 1:

-- md5 hashing procedure
-- per-round shift amounts
def s : Array Nat := #[
  7, 12, 17, 22,  7, 12, 17, 22,  7, 12, 17, 22,  7, 12, 17, 22,
  5,  9, 14, 20,  5,  9, 14, 20,  5,  9, 14, 20,  5,  9, 14, 20,
  4, 11, 16, 23,  4, 11, 16, 23,  4, 11, 16, 23,  4, 11, 16, 23,
  6, 10, 15, 21,  6, 10, 15, 21,  6, 10, 15, 21,  6, 10, 15, 21
]

def K : Array UInt32 := #[
  0xd76aa478, 0xe8c7b756, 0x242070db, 0xc1bdceee,
  0xf57c0faf, 0x4787c62a, 0xa8304613, 0xfd469501,
  0x698098d8, 0x8b44f7af, 0xffff5bb1, 0x895cd7be,
  0x6b901122, 0xfd987193, 0xa679438e, 0x49b40821,
  0xf61e2562, 0xc040b340, 0x265e5a51, 0xe9b6c7aa,
  0xd62f105d, 0x02441453, 0xd8a1e681, 0xe7d3fbc8,
  0x21e1cde6, 0xc33707d6, 0xf4d50d87, 0x455a14ed,
  0xa9e3e905, 0xfcefa3f8, 0x676f02d9, 0x8d2a4c8a,
  0xfffa3942, 0x8771f681, 0x6d9d6122, 0xfde5380c,
  0xa4beea44, 0x4bdecfa9, 0xf6bb4b60, 0xbebfbc70,
  0x289b7ec6, 0xeaa127fa, 0xd4ef3085, 0x04881d05,
  0xd9d4d039, 0xe6db99e5, 0x1fa27cf8, 0xc4ac5665,
  0xf4292244, 0x432aff97, 0xab9423a7, 0xfc93a039,
  0x655b59c3, 0x8f0ccc92, 0xffeff47d, 0x85845dd1,
  0x6fa87e4f, 0xfe2ce6e0, 0xa3014314, 0x4e0811a1,
  0xf7537e82, 0xbd3af235, 0x2ad7d2bb, 0xeb86d391
]

def byte : Nat -> UInt8 :=
  λ n => UInt8.ofNat n

def u32 : Nat -> UInt32 :=
  λ n => UInt32.ofNat n

def two32 : Nat :=
  4294967296

-- This is rotate-left on a 32-bit word:
def shamt : Nat -> UInt32 :=
  λ n => UInt32.ofNat n

def leftrotate : UInt32 -> Nat -> UInt32 :=
  λ x => λ c =>
    (x <<< shamt c) ||| (x >>> shamt (32 - c))

def pad : ByteArray -> ByteArray :=
  λ input =>
    Id.run do
      let bitLen := input.size * 8
      let mut out := input

      out := out.push (byte 0x80)

      while out.size % 64 != 56 do
        out := out.push (byte 0)

      -- append original length as 64-bit little-endian integer
      for i in [0:8] do
        out := out.push (byte ((bitLen / (256 ^ i)) % 256))

      pure out

def getWordLE : ByteArray -> Nat -> UInt32 :=
  λ bytes => λ off =>
    let b0 := (bytes.get! off).toNat
    let b1 := (bytes.get! (off + 1)).toNat
    let b2 := (bytes.get! (off + 2)).toNat
    let b3 := (bytes.get! (off + 3)).toNat
    u32 (b0 + b1 * 256 + b2 * 65536 + b3 * 16777216)

def blockWords : ByteArray -> Nat -> Array UInt32 :=
  λ bytes => λ off =>
    Id.run do
      let mut words := #[]
      for j in [0:16] do
        words := words.push (getWordLE bytes (off + 4 * j))
      pure words

def wordToBytesLE : UInt32 -> ByteArray :=
  λ w =>
    Id.run do
      let n := w.toNat
      let mut out := ByteArray.empty
      out := out.push (byte (n % 256))
      out := out.push (byte ((n / 256) % 256))
      out := out.push (byte ((n / 65536) % 256))
      out := out.push (byte ((n / 16777216) % 256))
      pure out

def appendWordLE : ByteArray -> UInt32 -> ByteArray :=
  λ bytes => λ w =>
    Id.run do
      let mut out := bytes
      let wb := wordToBytesLE w
      for i in [0:4] do
        out := out.push (wb.get! i)
      pure out

def md5Bytes : ByteArray -> ByteArray :=
  λ input =>
    Id.run do
      let bytes := pad input

      let mut a0 : UInt32 := 0x67452301
      let mut b0 : UInt32 := 0xefcdab89
      let mut c0 : UInt32 := 0x98badcfe
      let mut d0 : UInt32 := 0x10325476

      for block in [0:(bytes.size / 64)] do
        let M := blockWords bytes (block * 64)

        let mut A := a0
        let mut B := b0
        let mut C := c0
        let mut D := d0

        for i in [0:64] do
          let F : UInt32 :=
            if i < 16 then
              (B &&& C) ||| ((~~~B) &&& D)
            else if i < 32 then
              (D &&& B) ||| ((~~~D) &&& C)
            else if i < 48 then
              B ^^^ C ^^^ D
            else
              C ^^^ (B ||| (~~~D))

          let g : Nat :=
            if i < 16 then
              i
            else if i < 32 then
              (5 * i + 1) % 16
            else if i < 48 then
              (3 * i + 5) % 16
            else
              (7 * i) % 16

          let tmp := D
          D := C
          C := B
          B := B + leftrotate (A + F + K[i]! + M[g]!) s[i]!
          A := tmp

        a0 := a0 + A
        b0 := b0 + B
        c0 := c0 + C
        d0 := d0 + D

      let mut out := ByteArray.empty
      out := appendWordLE out a0
      out := appendWordLE out b0
      out := appendWordLE out c0
      out := appendWordLE out d0
      pure out

def hexDigit : Nat -> Char :=
  λ n =>
    if n < 10 then
      Char.ofNat ('0'.toNat + n)
    else
      Char.ofNat ('a'.toNat + (n - 10))

def byteToHexChars : UInt8 -> List Char :=
  λ b =>
    let n := b.toNat
    [hexDigit (n / 16), hexDigit (n % 16)]

def bytesToHex : ByteArray -> String :=
  λ bytes =>
    Id.run do
      let mut chars : List Char := []
      for i in [0:bytes.size] do
        chars := chars ++ byteToHexChars (bytes.get! i)
      pure (String.ofList chars)

def md5Hex : String -> String :=
  λ s =>
    bytesToHex (md5Bytes s.toUTF8)

-- part 2 (just remove one of the  leading zeros from the starts with app in
--          part1loop)
def startsWithFiveHexZeroes : ByteArray -> Bool :=
  λ digest =>
    digest.get! 0 == 0 &&
    digest.get! 1 == 0 &&
    digest.get! 2 < 16

partial def partLoop : String -> Nat -> Nat :=
  λ key => λ i =>
    let h := md5Hex (key ++ toString i)
    if h.startsWith "000000" then
      i
    else
      partLoop key (i + 1)

-- same as part1, just tweak number of zeros we check in the substring to 5
def part2 : String -> Nat :=
  λ key =>
    partLoop key 0

def main : IO Unit := do
  IO.println "main started"

  let n := part2 "bgvyzdsv"
  IO.println s!"sample part1 answer: {n}"