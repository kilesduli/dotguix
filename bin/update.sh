#!/usr/bin/env sh
guix pull --channels=../channels.scm
guix describe --format=channels > channels-lock.scm
