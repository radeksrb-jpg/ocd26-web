# O.C.D.26 — Command Deck / sjednocená revize

## Co obsahuje
- Novou hlavní stránku jako barevný navigační palubní panel, šest klikacích monitorů.
- Přístup k původním detailům: živá měření, světový radar, prognózy, výzkum a příběh projektu.
- Češtinu a angličtinu, responzivní rozložení.
- Napojení čísel z existujících měřicích modulů do hlavních karet, pokud jsou dostupná.
- Zachované původní datové skripty a zdroje. Není přidáno žádné falešné měření.

## Důležité omezení
Statické GitHub Pages nedokážou samy provozovat lokální IMAP synchronizaci nebo serverové API.
Karty bez dat zobrazují neutrální text; stav „neobvyklé“ zatím nevyhodnocujeme bez historické základny.

## Nasazení
1. Rozbal složku OCD26_AUTO_PUBLISH_FINAL na Plochu.
2. Spusť NASTAVIT_JEDNOU.command (vyžaduje GitHub CLI a přihlášení).
3. Před potvrzením veřejného repozitáře zkontroluj, že zveřejňuješ jen tento balíček.
4. GitHub Pages v repozitáři: Settings > Pages > Source: GitHub Actions.
5. Další změny publikuj přes AKTUALIZOVAT.command, který nevrací staré lokální verze.

Změny webu se publikují po git push. Samovolné generování nového kódu bez schválení tento balíček neprovádí.
