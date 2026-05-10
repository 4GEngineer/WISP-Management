# LinkedIn post helper — `linkedin-new-project-post.html`

Local-only tool (lives under `docs/`; **Firebase Hosting ignores `docs/**`**, so this file is not part of the public site bundle). Open in a browser from disk to preview copy and use **Copy to clipboard** for LinkedIn.

## What must stay the same (or the page breaks)

These **element `id` values** are wired in the script at the bottom of `linkedin-new-project-post.html`. Do **not** rename or remove them unless you update the script in the same edit:

| `id` | Role |
|------|------|
| `preview-title` | H1 gradient span (title) |
| `preview-open` | Lead paragraph (HTML from `openingLine`) |
| `preview-mid` | Body blocks (HTML from `teaserLine`) |
| `preview-quote` | Pull quote |
| `preview-close` | Closing line before URL |
| `preview-url` | Pill link (`url` / `urlDisplay`) |
| `preview-whitepaper` | Optional whitepaper link row |
| `li-text` | Plain-text `<textarea>` for copy |
| `copy-btn` | Copy button |
| `open-li` | Open LinkedIn button |
| `toast` | Copy confirmation |

The **`CONFIG`** object keys are read by that script only. Safe to edit **values**; if you add new keys, extend the script yourself.

## What you should change for each campaign

- **`CONFIG.projectName`** — short headline fragment inside the H1.
- **`CONFIG.openingLine`**, **`CONFIG.teaserLine`** — use `**bold**` sparingly; script strips to plain text for LinkedIn.
- **`CONFIG.quoteLine`**, **`CONFIG.closingLine`**, **`CONFIG.url`**, **`CONFIG.urlDisplay`**, **`CONFIG.hashtags`**.
- **`CONFIG.whitepaperUrl`** / **`CONFIG.whitepaperLabel`** — public URL is **`https://agenticop.io/AGENTICOP.md`** (mirrored markdown at site root). Keep in sync with **`AGENTICOP.md`** in this folder and with the in-repo source in Chrysalis (`docs/AGENTICOP.md`).

## Canonical technical whitepaper

- **Public URL (what you link in posts and on pages):** `https://agenticop.io/AGENTICOP.md` — served from **`brand/agenticops-web/AGENTICOP.md`** (Firebase does not deploy `docs/**`; this file lives at **site root**).
- **Source of truth (engineering):** Chrysalis repository `docs/AGENTICOP.md` (may be private on GitHub). Refresh the mirror after substantive edits:

```powershell
cd brand/agenticops-web
$b64 = gh api repos/4GEngineer/chrysalis/contents/docs/AGENTICOP.md -q .content
[IO.File]::WriteAllBytes("$PWD\AGENTICOP.md", [Convert]::FromBase64String($b64))
# Re-apply the short "Public copy" blockquote at the top if the upstream file replaced it.
```

When the **public path** or filename changes, update:

1. `docs/linkedin-new-project-post.html` → `CONFIG.whitepaperUrl`  
2. `index.html` → `/AGENTICOP.md` links  
3. `proof.html` → `/AGENTICOP.md` link  
4. This file, **`AGENTS.md`**, **`docs/AI_CONTEXT.md`**, and **`sitemap.xml`** if listed

## Brand row logo

The preview uses **`https://agenticop.io/logo.svg`** so the mark loads when opening the file from `file://`. If the apex domain or asset path changes, update the `<img src>` in the HTML.
