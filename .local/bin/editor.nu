#!/usr/bin/env nu
def main [arg: string] {
  $arg | parse "x-editor:{arg}" | get arg | first | helix $in
}
