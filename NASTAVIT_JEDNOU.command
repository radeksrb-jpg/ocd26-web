#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"
if ! command -v git >/dev/null; then echo "Nainstaluj Git (xcode-select --install)."; exit 1; fi
if ! command -v gh >/dev/null; then
 echo "Chybi GitHub CLI. Na Macu s Homebrew spust: brew install gh"
 echo "Pokud Homebrew nemas, instalace: https://cli.github.com/"
 read -r -p "Enter..."; exit 1
fi
if ! gh auth status >/dev/null 2>&1; then
 echo "Prihlaseni do GitHubu v prohlizeci:"; gh auth login -h github.com -p https -w
fi
if [ ! -d .git ]; then git init -b main; fi
if ! git config user.name >/dev/null; then git config user.name "OCD26 Publisher"; fi
if ! git config user.email >/dev/null; then
 EMAIL=$(gh api user --jq '.id')
 git config user.email "${EMAIL}+ocd26@users.noreply.github.com"
fi
# Publish only the reviewed files included in this package.
git add .github site README.md AKTUALIZOVAT.command NASTAVIT_JEDNOU.command
if ! git diff --cached --quiet; then git commit -m "Initial O.C.D.26 web"; fi
if ! git remote get-url origin >/dev/null 2>&1; then
 echo "Vytvarim soukromy repozitar. GitHub Pages u soukromych repozitaru muze vyzadovat placeny plan."
 echo "Pro bezplatny GitHub Pages je zpravidla potreba verejny repozitar; zdrojovy kod webu bude verejny."
 read -r -p "Souhlasis s VEREJNYM repozitarem ocd26-web? (ano/ne): " OK
 if [ "$OK" != "ano" ]; then echo "Zastaveno bez vytvoreni repozitare."; exit 0; fi
 gh repo create ocd26-web --public --source=. --remote=origin --push
else
 git push -u origin main
fi
REPO=$(gh repo view --json nameWithOwner --jq '.nameWithOwner')
# Configure Pages deployment to GitHub Actions; may take a moment to initialize.
if ! gh api -X POST "repos/$REPO/pages" -f 'build_type=workflow' >/dev/null 2>&1; then
 gh api -X PUT "repos/$REPO/pages" -f 'build_type=workflow' >/dev/null 2>&1 || true
fi
gh workflow run publish.yml || true
printf '\nRepozitar: https://github.com/%s\n' "$REPO"
echo "Na GitHubu otevri Settings > Pages a nastav Source: GitHub Actions, pokud neni automaticky."
read -r -p "Enter pro zavreni..."
