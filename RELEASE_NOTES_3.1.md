# RenTracker 3.1

## English

### Highlights
This update fixes several tracking bugs, improves in game performance, and adds an options panel plus a global progress summary. The slash command has also been renamed to `/rt`.

### Bug fixes
- Fixed the automatic zone tracking that never refreshed the open window. Entering a known zone now updates the display immediately.
- Zone tracking now actually selects the matching faction inside the addon, not just the default Blizzard reputation bar.
- Fixed a mismatch between the Renown bar color and its rank label. Color and text now always agree (Neutre, Familier, Aimable, Honore, Revere, Exalte).
- Reduced UI stutter: rapid game events (reputation and quest updates) are now grouped into a single refresh instead of rebuilding the whole window on every tick.

### New features
- Options panel, opened with `/rt config` or the new "Options" button in the window. Three settings, saved between sessions:
  - Automatic tracking by zone (on/off)
  - Login message in chat (on/off)
  - Sound on Renown level up (on/off)
- Global progress summary at the top of the window: total factions maxed across all expansions, plus the reputation achievement count for the active expansion.
- Reputation achievement data is now loaded and available in the addon.

### Changes
- Slash command renamed: `/trt` and `/tibirep` are replaced by a single command, `/rt`.
  - `/rt` opens or closes the window.
  - `/rt config` opens the options panel.

### Under the hood
- Removed unused legacy code and duplicated helpers for a lighter, cleaner file.
- Full Lua syntax validation on every data file.

---

## Francais

### En bref
Cette mise a jour corrige plusieurs bugs de suivi, ameliore les performances en jeu, et ajoute un panneau d'options ainsi qu'un recapitulatif global de progression. La commande slash devient `/rt`.

### Corrections de bugs
- Correction du suivi automatique par zone qui ne rafraichissait jamais la fenetre ouverte. Entrer dans une zone connue met desormais l'affichage a jour immediatement.
- Le suivi par zone selectionne maintenant reellement la faction correspondante dans l'addon, et plus seulement la barre de reputation Blizzard.
- Correction du desaccord entre la couleur de la barre de Renown et son rang. La couleur et le texte sont toujours coherents (Neutre, Familier, Aimable, Honore, Revere, Exalte).
- Moins de saccades : les evenements en rafale (mises a jour de reputation et de quetes) sont regroupes en un seul rafraichissement au lieu de tout reconstruire a chaque tick.

### Nouveautes
- Panneau d'options, ouvert via `/rt config` ou le nouveau bouton "Options" dans la fenetre. Trois reglages, conserves entre les sessions :
  - Suivi automatique par zone (activer/desactiver)
  - Message de connexion dans le chat (activer/desactiver)
  - Son au passage de niveau de Renown (activer/desactiver)
- Recapitulatif global en haut de la fenetre : total de factions au maximum toutes extensions confondues, plus le compte de hauts faits de reputation de l'extension active.
- Les donnees de hauts faits de reputation sont desormais chargees et disponibles dans l'addon.

### Changements
- Commande slash renommee : `/trt` et `/tibirep` sont remplacees par une seule commande, `/rt`.
  - `/rt` ouvre ou ferme la fenetre.
  - `/rt config` ouvre le panneau d'options.

### Cote technique
- Suppression de code obsolete inutilise et de doublons pour un fichier plus leger et plus propre.
- Validation complete de la syntaxe Lua sur chaque fichier de donnees.
