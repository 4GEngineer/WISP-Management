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
- **`CONFIG.whitepaperUrl`** / **`CONFIG.whitepaperLabel`** — must stay in sync with the **canonical technical doc** (today: Chrysalis repo **`docs/AGENTICOP.md`**). If the doc moves or renames, update here and every **public** link (see below).

## Canonical technical whitepaper (public site + repo)

- **URL:** `https://github.com/4GEngineer/chrysalis/blob/main/docs/AGENTICOP.md`  
- **Meaning:** Long-form technical / practice narrative for AgenticOps + Chrysalis (lives in the **Chrysalis** repository, not in this marketing tree).

When the whitepaper path or repo changes, update:

1. `docs/linkedin-new-project-post.html` → `CONFIG.whitepaperUrl` (and label if needed)  
2. `index.html` → hero / Explore whitepaper link  
3. `proof.html` → Chrysalis status list link  
4. This file (above URL) and **`AGENTS.md`** (whitepaper line)

## Brand row logo

The preview uses **`https://agenticop.io/logo.svg`** so the mark loads when opening the file from `file://`. If the apex domain or asset path changes, update the `<img src>` in the HTML.
