#!/bin/python3

from pathlib import PosixPath
import argparse
import os
from re import I


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

def make_link(linkPath: PosixPath, targetPath: PosixPath) -> str:
    if linkPath.exists():
        # TODO: ask to override

        if os.readlink(linkPath.as_posix()) == targetPath.as_posix():
            return f"{AnsiCodes.Yellow}Skipped (exists, but has same target){AnsiCodes.Reset}"
        
        if not linkPath.is_symlink():
            return f"{AnsiCodes.Red}Skipped (link path isn't a symbolic link){AnsiCodes.Reset}"

        print(f"{AnsiCodes.Magenta}Looks like {AnsiCodes.Bold}{link}{AnsiCodes.Magenta} already exists{AnsiCodes.Reset}")
        print(f" * Currently links to {os.readlink(linkPath.as_posix())}")
        print(f" * Should link to     {targetPath.as_posix()}")

        action = ""
        while True:
            action = input("Actions: [o]verride, [s]kip: ")
            if action == "o" or action == "s": break

        if action == "o":
            os.unlink(linkPath)
            os.symlink(targetPath.as_posix(), linkPath.as_posix(), targetPath.is_dir())

            return f"{AnsiCodes.Green}Overriden{AnsiCodes.Reset}"
        elif action == "s":
            return f"{AnsiCodes.Yellow}Skipped{AnsiCodes.Reset}"
    else:
        # create new link

        os.symlink(targetPath.as_posix(), linkPath.as_posix(), targetPath.is_dir())
        return f"{AnsiCodes.Green}Linked{AnsiCodes.Reset}"

    return f"{AnsiCodes.BrightBlack}Unknown{AnsiCodes.Reset}"

    


parser = argparse.ArgumentParser(description='Creates dotfiles linking')
parser.add_argument(
    'manifest',
    type=argparse.FileType('r', encoding='UTF-8'),
    help='.manifest file'
)

args = parser.parse_args()

manifest: str = args.manifest.read()

for entry in filter(lambda entry: not entry.startswith("#") and len(entry.split(">")) == 2, manifest.splitlines()):
    link, target = map(lambda a: a.strip(), entry.split(">"))

    linkPath = PosixPath(link).expanduser()
    targetPath = PosixPath(target).expanduser().resolve()

    status = make_link(linkPath, targetPath)
    
    print(f"{AnsiCodes.Cyan}{link} > {target}{AnsiCodes.Reset}: {status}")
