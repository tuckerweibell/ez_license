#!/bin/bash

while getopts "o:n;" opt; do
    case $opt in
        o)
            echo "argument -o called";;
        n)
            echo "argument -n called";;
    esac

done