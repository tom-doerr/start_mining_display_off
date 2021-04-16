#!/bin/bash

export CUDA_VISIBLE_DEVICES=0

command="$@"

display_off() {
    [[ ! $(xset q | awk 'END{print $3}') == 'On' ]]
}

while true
do
    if display_off
    then
        if [[ $pid_miner == '' ]]
        then
            echo 'Starting ethminer...'
            ethminer -U -P stratum1+tcp://0xaa3e2211dd1c7e6a55d46e5af8a873e9967d1926@eth.2miners.com:2020 &
            pid_miner=$!
        else
            printf 'Already running  '
            date
        fi
    else
        printf 'Display on, waiting for display to turn off...    '
        date
        if [ -v pid_miner ]
        then
            printf "Killing the miner with PID $pid_miner."
            kill $pid_miner
            unset pid_miner
        fi
    fi
    sleep 1
done
