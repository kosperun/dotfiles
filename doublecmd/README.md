# Double Commander Config

Good news: unlike iTerm2, Double Commander stores its config as plain
XML/JSON/INI files in a normal folder, so this is a direct copy — no
plist/preset conversion needed.

Live config lives at:
```
~/Library/Preferences/doublecmd/
```

Files copied here (actual settings, incl. custom colors in `colors.json`):

| File | Contains |
|---|---|
| `doublecmd.xml` | Main config: toolbars, panels, layout, general options |
| `colors.json` | Custom color scheme |
| `doublecmd.cfg` | Dark mode / splash flags |
| `highlighters.xml` | File-type syntax/color highlighting rules |
| `shortcuts.scf` | Keyboard shortcuts |
| `multiarc.ini` | Archiver (zip/rar/7z) integration config |
| `extassoc.xml` | File extension associations |
| `pixmaps.txt` | Icon associations |

**Deliberately excluded** (session state, not settings — would just add noise
or restore stale data): `history.xml` (recent paths), `tabs.xml` (open tabs),
`session.ini` (window position), `doublecmd.err` (error log).

## Restoring on a new machine

**Option A — symlink (recommended):** keeps it in sync with the repo going
forward; edits in the app write straight back into your dotfiles.

```bash
# quit Double Commander first
mkdir -p ~/Library/Preferences/doublecmd
for f in doublecmd.xml doublecmd.cfg colors.json highlighters.xml \
         shortcuts.scf multiarc.ini extassoc.xml pixmaps.txt; do
  ln -sf ~/GitHubRepos/dotfiles/doublecmd/$f ~/Library/Preferences/doublecmd/$f
done
```

**Option B — one-time copy:** simpler, but future changes won't flow back
into the repo unless you re-copy manually.

```bash
mkdir -p ~/Library/Preferences/doublecmd
cp ~/GitHubRepos/dotfiles/doublecmd/* ~/Library/Preferences/doublecmd/
```

Then launch Double Commander — it picks up the config on start.
