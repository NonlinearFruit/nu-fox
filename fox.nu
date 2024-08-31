# Requires gron.nu <github.com/NonlinearFruit/nu-gron>
export def generate-config [] {
  let config = $in
  use gron.nu
  $config
  | gron $in
  | where ($it.value | describe) not-in [record list<any>]
  | each {[
    $"user_pref\(\"nu-fox.debug\", \"Error in preference: '($in.key)'\");"
    $"user_pref\(\"($in.key)\", ($in.value | to nuon));"
  ]}
  | flatten
  | append $"user_pref\(\"nu-fox.debug\", \"Successfully loaded!\");"
  | str join (char newline)
}

