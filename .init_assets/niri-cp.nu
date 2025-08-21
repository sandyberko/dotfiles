#!/usr/bin/env nu
let dir = "./niri-bins/"
[
    [$"($dir)resources/niri.desktop",
        $"/usr/local/share/wayland-sessions/"],
    [$"($dir)resources/niri-session",
        $"/usr/local/bin/"],
    [$"($dir)resources/niri-portals.conf",
        $"/usr/local/share/xdg-desktop-portal/"],
    [$"($dir)resources/niri.service",
        $"/etc/systemd/user/"],
    [$"($dir)niri",
        $"/usr/local/bin/"],
    [$"($dir)resources/niri-shutdown.target",
        $"/etc/systemd/user/"]
] | each {
    if not ($in.1 | path exists) {
        sudo mkdir $in.1;
    }
    sudo cp -up $in.0 $in.1;
}