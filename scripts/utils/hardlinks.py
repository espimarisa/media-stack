from os.path import splitdrive, split as dirsplit, basename, isdir
import sys
import shlex
import subprocess
from time import sleep
path = sys.argv[1]
category = sys.argv[2]

allowed_categories = [
  "anime",
  "anime-movies",
  "audiobooks"
  "books",
  "comics",
  "isos",
  "manga",
  "movies",
  "music",
  "roms",
  "software",
  "tv",
]

if category not in allowed_categories:
    exit()

allowed_folders = [
  "anime",
  "anime-movies",
  "audiobooks"
  "books",
  "comics",
  "isos",
  "manga",
  "movies",
  "music",
  "roms",
  "software",
  "tv",
]

dest_folders = [
  "/storage/medialibrary/anime",
  "/storage/medialibrary/anime-movies",
  "/storage/medialibrary/audiobooks",
  "/storage/medialibrary/books",
  "/storage/medialibrary/comics",
  "/storage/isos",
  "/storage/medialibrary/manga",
  "/storage/medialibrary/movies",
  "/storage/medialibrary/music",
  "/storage/medialibrary/roms",
  "/storage/medialibrary/software",
  "/storage/medialibrary/tv"
]

# Creates some hardlinks
drive = splitdrive(path)[0]
folder = dirsplit(path)[0].split("/")[-1]
base = basename(path)
print(folder)
for x in zip(allowed_folders, dest_folders):
    if folder in x[0]:
        print(f"this should go to: {x[1]}")
        print(f"folder: {folder}")
        command = "cp -lRf "
        command += f'"{path}" "{x[1]}"'
        subprocess.run(shlex.split(command))
        print(f"is this correct? {command}")
