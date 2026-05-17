-- part 1:

-- md5 hashing procedure (from: https://en.wikipedia.org/wiki/MD5 near bottom)

-- lean4 doesn't have one, but macOS does have an implementation, so we just
-- run the systems and return the hash it gives as a string.
def md5HexIO : String -> IO String := λ s => do
  let out ← IO.Process.output {
    cmd := "md5"
    args := #["-q", "-s", s]
  }

  if out.exitCode == 0 then
    pure out.stdout.trimAscii.toString
  else
    throw <| IO.userError out.stderr

#eval md5HexIO ""       -- d41d8cd98f00b204e9800998ecf8427e
#eval md5HexIO "a"      -- 0cc175b9c0f1b6a831c399e269772661
#eval md5HexIO "abc"    -- 900150983cd24fb0d6963f7d28e17f72