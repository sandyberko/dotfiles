$env.Path ++= [$"($nu.home-path)/.cargo/bin"]
$env.config.show_banner = false
$env.EDITOR = "hx"
alias cfg = git --git-dir=($env.HOME)/.dotfiles/ --work-tree=($env.HOME)

# android dev
$env.JAVA_HOME = ($env.PREFIX)/lib/jvm/java-17-openjdk
$env.ANDROID_HOME = $"($env.HOME)/android/sdk"
$env.Path ++= [$"($env.ANDROID_HOME)/cmdline-tools/latest/bin"]
