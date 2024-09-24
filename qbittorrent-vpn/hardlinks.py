from os.path import splitdrive, split as dirsplit, basename, isdir
import sys
import shlex
import subprocess
from time import sleep
path = sys.argv[1]
category = sys.argv[2]

allowed_categories = ["anime", "anime-movies", "tv", "movies", "manga", "comics", "music", "roms", "isos", "software"] # Categories to create hardlinks for

if category not in allowed_categories:
    exit()

dest_folders = [
  "/storage/medialibrary/anime" # Internal container path to your anime library
  "/storage/medialibrary/anime-movies" # Internal container path to your anime movies library
  "/storage/medialibrary/tv" # Internal container path to your tv library
  "/storage/medialibrary/movies" # Internal container path to your movies library
  "/storage/medialibrary/manga" # Internal container path to your manga library
  "/storage/medialibrary/comics" # Internal container path to your comics library
  "/storage/medialibrary/music" # Internal container path to your music library
  "/storage/roms", # Internal container path to your roms library
  "/storage/isos", # Internal container path to your isos library
  "/storage/software" # Internal container path to your software library
]

# Creates some hardlinks
drive = splitdrive(path)[0]
folder = dirsplit(path)[0].split("/")[-1]
base = basename(path)
print(folder)
for x in zip(allowed_categories, dest_folders):
    if folder in x[0]:
        print(f"this should go to: {x[1]}")
        print(f"folder: {folder}")
        command = "cp -lRf "
        command += f'"{path}" "{x[1]}"'
        subprocess.run(shlex.split(command))
        print(f"is this correct? {command}")
