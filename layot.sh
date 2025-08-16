#!/bin/bash
# переключение с сигналом dwmblocks
pid=$(pidof dwmblocks)
[ -n "$pid" ] && kill -SIGRTMIN+1 $pid

