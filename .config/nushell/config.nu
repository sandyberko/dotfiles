$env.EDITOR = "helix"
alias hx = helix
alias cfg = git --git-dir=($env.HOME)/.dotfiles/ --work-tree=($env.HOME)

# Rust
$env.Path ++= [$"($nu.home-path)/.cargo/bin"]
$env.CARGO_TARGET_DIR = ($env.HOME)/.cargo/target

# android dev
# $env.JAVA_HOME = ($env.PREFIX)/lib/jvm/java-17-openjdk
# $env.ANDROID_HOME = $"($env.HOME)/android/sdk"
# $env.Path ++= [$"($env.ANDROID_HOME)/cmdline-tools/latest/bin"]

$env.config.show_banner = false

$env.config.edit_mode = "vi"
$env.config.keybindings ++= [
  {
      name: history_hint_word_complete
      modifier: alt
      keycode: Char_L
      mode: [vi_normal, vi_insert]
      event: { send: HistoryHintWordComplete }
  },
  {
      name: delete_word
      modifier: alt
      keycode: Char_H
      mode: [vi_normal, vi_insert]
      event: { edit: DeleteWord }
  }
]
