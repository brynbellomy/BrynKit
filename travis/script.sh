#!/bin/sh
set -e

xctool -workspace BrynKit -scheme BrynKit build test

