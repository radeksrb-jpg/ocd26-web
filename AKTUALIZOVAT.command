#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
 echo "Nejprve spust NASTAVIT_JEDNOU.command"; read -r -p "Enter..."; exit 1
fi
# Never overwrite the reviewed site with an older local copy.
git add site .github README.md
if git diff --cached --quiet; then
 echo "Zadne nove zmeny k publikovani."
else
 git commit -m "O.C.D.26 update $(date '+%Y-%m-%d %H:%M')"
 git push origin main
 echo "Odeslano. GitHub Pages automaticky nasadi novou verzi."
fi
read -r -p "Enter pro zavreni..."
