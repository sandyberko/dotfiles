#!/usr/bin/env nu
let vm_cfg = "/mnt/internal/linux/vm_config.json"
open $vm_cfg | update memory_mib 8192 | save -f $vm_cfg
