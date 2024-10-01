#!/usr/bin/env python3

from __future__ import annotations

from typing import Optional, Sequence
from datetime import datetime, timedelta

import subprocess

def main(argv: Optional[Sequence[str]] = None) -> int:
    import argparse

    parser = argparse.ArgumentParser()
    parser.add_argument("--hour",  type=int, required=True)
    parser.add_argument("--minute", type=int, default=0)
    args = parser.parse_args(argv)
    
    delta = 0
    now = datetime.today()
    until = datetime(
            year=now.year,
            month=now.month,
            day=now.day,
            hour=args.hour, minute=args.minute,)
    delta = (until - now).seconds
    
    while delta <= 0:
        delta += timedelta(days=1).seconds
    
    print(f"{now}: buzzed for {delta} seconds, until {args.hour:02}:{args.minute:02}")
    try:
        subprocess.run(
        [
            "caffeinate",
            # prevent:
            "-d", # display from sleeping
            "-i", # system from idle sleeping
            "-s", # system from sleeping
            # and
            "-u", # declare that user is active
            # for timeout:
            *("-t", str(delta)),
        ]
    )
    except KeyboardInterrupt:
        print(f"{datetime.today()} KeyboardInterrupt!")
    print(f"{datetime.today()}: I'm tired.")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
