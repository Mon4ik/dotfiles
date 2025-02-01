#!/usr/bin/env python3

# (c) 2025 idkncc (Dmitry B.)
# This code in licensed under MIT License (see LICENSE for details)

from pathlib import PosixPath
import argparse
import os


class AnsiCodes:
    Reset = "\033[0m"

    Bold = "\033[1m"

    Black = "\033[0;30m"
    Red = "\033[0;31m"
    Green = "\033[0;32m"
    Yellow = "\033[0;33m"
    Blue = "\033[0;34m"
    Magenta = "\033[0;35m"
    Cyan = "\033[0;36m"
    White = "\033[0;37m"
    Default = "\033[0;39m"

    BrightBlack = "\033[0;90m"


def create_symlink(linkPath: PosixPath, targetPath: PosixPath):
    """
    Internal usage only!
    Make all necessary checks before!
    """

    relativeTargetPath= os.path.relpath(targetPath, linkPath.parent)

    os.symlink(relativeTargetPath,
               linkPath)


def make_link(linkPath: PosixPath, targetPath: PosixPath) -> str:
    relativeTargetPath= os.path.relpath(targetPath, linkPath.parent)
    
    if linkPath.exists():
        # TODO: ask to override

        if not linkPath.is_symlink():
            print(
                f"{AnsiCodes.Magenta}{AnsiCodes.Bold}{link}{AnsiCodes.Magenta} isn't a symlink.{AnsiCodes.Reset}")

            action = ""
            while True:
                action = input(
                    "Actions: [b]ackup and override, [o]verride, [s]kip: ")
                if action == "b" or action == "o" or action == "s":
                    break

            if action == "b":
                # add .bak suffix for old file
                os.rename(linkPath.as_posix(),
                          linkPath.parent / (linkPath.name + ".bak"))

                create_symlink(linkPath, targetPath)

                return f"{AnsiCodes.Green}Renamed and linked{AnsiCodes.Reset}"
            elif action == "o":
                os.remove(linkPath.as_posix())

                create_symlink(linkPath, targetPath)
 
                return f"{AnsiCodes.Red}Overriden{AnsiCodes.Reset}"
            elif action == "s":
                return f"{AnsiCodes.Red}Skipped{AnsiCodes.Reset}"
            else:
                print("unreachable")
                exit(1)
        if os.readlink(linkPath.as_posix()) == relativeTargetPath:
            return f"{AnsiCodes.Yellow}Skipped (exists, but has same target){AnsiCodes.Reset}"

        print(f"{AnsiCodes.Magenta}Looks like {AnsiCodes.Bold}{link}{AnsiCodes.Magenta} already exists{AnsiCodes.Reset}")
        print(f" * Currently links to {os.readlink(linkPath.as_posix())}")
        print(f" * Should link to     {relativeTargetPath}")

        action = ""
        while True:
            action = input("Actions: [o]verride, [s]kip: ")
            if action == "o" or action == "s":
                break

        if action == "o":
            os.unlink(linkPath)
            
            create_symlink(linkPath, targetPath)

            return f"{AnsiCodes.Green}Overriden{AnsiCodes.Reset}"
        elif action == "s":
            return f"{AnsiCodes.Yellow}Skipped{AnsiCodes.Reset}"
        else:
            print("unreachable")
            exit(1)
    else:
        # create new link

        create_symlink(linkPath, targetPath)
        
        return f"{AnsiCodes.Green}Linked{AnsiCodes.Reset}"

parser = argparse.ArgumentParser(description='Creates dotfiles linking')
parser.add_argument(
    'manifest',
    type=argparse.FileType('r', encoding='UTF-8'),
    help='.manifest file'
)

args = parser.parse_args()

manifest: str = args.manifest.read()

entries = filter(
    lambda entry: not entry.startswith("#") and len(entry.split(">")) == 2,
    manifest.splitlines())
for entry in entries:
    link, target = map(lambda a: a.strip(), entry.split(">"))

    linkPath = PosixPath(link).expanduser()
    targetPath = PosixPath(target).expanduser().resolve()

    status = make_link(linkPath, targetPath)

    print(f"{AnsiCodes.Cyan}{link} > {target}{AnsiCodes.Reset}: {status}")
