#!/bin/bash
#This script can be used to compile the presentation file.

export TEXINPUTS=".:./sty:" #necessary to include the LSE style files

lualatex document.tex

mv document.pdf pdf/document.pdf
./clean.sh
