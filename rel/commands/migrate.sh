#!/bin/sh

release_ctl eval --mfa "School.ReleaseTasks.migrate/1" --argv -- "$@"
