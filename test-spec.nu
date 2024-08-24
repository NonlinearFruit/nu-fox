export def "test handles string preferences" [] {
  use std assert
  use fox.nu

  { key: value }
  | fox generate-config
  | str contains 'user_pref("key", "value");'
  | assert $in
}

export def "test handles boolean preferences" [] {
  use std assert
  use fox.nu

  { key: true }
  | fox generate-config
  | str contains 'user_pref("key", true);'
  | assert $in
}

export def "test handles integer preferences" [] {
  use std assert
  use fox.nu

  { key: 100 }
  | fox generate-config
  | str contains 'user_pref("key", 100);'
  | assert $in
}

export def "test key name is dynamic" [] {
  use std assert
  use fox.nu

  { A: B }
  | fox generate-config
  | str contains 'user_pref("A", "B");'
  | assert $in
}

export def "test multiple preferences" [] {
  use std assert
  use fox.nu

  {
    A: B
    C: D
  }
  | fox generate-config
  | str contains 'user_pref("C", "D");'
  | assert $in
}

export def "test nested preferences" [] {
  use std assert
  use fox.nu

  {
    A: {
      B: C
    }
  }
  | fox generate-config
  | str contains 'user_pref("A.B", "C");'
  | assert $in
}

export def "test records do not show up as preferences" [] {
  use std assert
  use fox.nu

  {
    A: {
      B: C
    }
  }
  | fox generate-config
  | str contains 'user_pref("A", {});'
  | not $in
  | assert $in
}

export def "test arrays do not show up as preferences" [] {
  use std assert
  use fox.nu

  {
    A: [
      1
      2
      3
    ]
  }
  | fox generate-config
  | str contains 'user_pref("A", []);'
  | not $in
  | assert $in
}
