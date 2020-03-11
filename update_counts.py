#!/usr/bin/env python3

import os
import sys
import argparse
import re

EVENT_REGEX = re.compile(r"\n- ")
COMPANY_COUNT_REGEX = re.compile(r"\n## Companies - \d+")
EVENT_COUNT_REGEX = re.compile(r"\n## Events - \d+")


def parse_args():
    parser = argparse.ArgumentParser(
        formatter_class=argparse.ArgumentDefaultsHelpFormatter
    )
    parser.add_argument(
        "file", help="File to modify", default="README.md", type=str, nargs="?"
    )
    parser.add_argument(
        "--check",
        help="Check file without overwriting",
        action="store_true",
        default=False,
    )
    return parser.parse_args()


def check_file(file_path, check_only=False):
    """Count all the events and companies in the table.

    Currently uses a fairly naive approach:
    - looks for table rows that start with | to get the company count
    - looks for lines that start with - and counts them up
    """
    with open(file_path) as infile:
        input_data = infile.read()

    # using a regex here wasn't working as expected, but this works well enough
    company_count = sum(
        int(line.startswith("| ") and not line.startswith(("| Company |", "| --")))
        for line in input_data.split("\n")
    )
    event_count = len(EVENT_REGEX.findall(input_data))
    if check_only:
        company_count_line = COMPANY_COUNT_REGEX.search(input_data).group()
        existing_company_count = int(company_count_line.split("-")[1].strip())
        event_count_line = EVENT_COUNT_REGEX.search(input_data).group()
        existing_event_count = int(event_count_line.split("-")[1].strip())
        if (
            existing_company_count == company_count
            and existing_event_count == existing_event_count
        ):
            return True
        if existing_event_count != event_count:
            print(
                f"Found {existing_event_count} events in file, expected {event_count}"
            )
        if existing_company_count != company_count:
            print(
                f"Found {existing_company_count} companies in file, expected {company_count}"
            )
        raise CountMismatchError("Counts mismatch")

    output_data = EVENT_COUNT_REGEX.sub(f"\n## Events - {event_count}", input_data)
    output_data = COMPANY_COUNT_REGEX.sub(
        f"\n## Companies - {company_count}", output_data
    )
    with open(file_path, "w") as outfile:
        outfile.write(output_data)


class CountMismatchError(Exception):
    pass

def main():
    args = parse_args()
    try:
        check_file(args.file, args.check)
    except CountMismatchError:
        sys.exit(1)


if __name__ == "__main__":
    main()
