# AgenticOps — marketing site (`agenticop.io`)

**Brand:** AgenticOps · **Canonical domain:** **agenticop.io** (see `DOMAIN_DECISION_CHECKLIST.md` for optional `agenticops.io` migration).

Static multi-page site: verification-backed migrations and agent-led modernization; **Chrysalis** source is **https://github.com/4GEngineer/chrysalis** (early); pilots described as private alpha.

## Where this folder lives

- **WISP-Management monorepo:** `brand/agenticops-web/` — kept separate from `landing/` (wisptools.io), `Module_Manager/`, and backend code.
- **Private GitHub repo:** Copy this directory to a private repository root when you want billing/access isolation; see **`docs/PRIVATE_REPOSITORY.md`**.

## AI / contributor onboarding

- **`AGENTS.md`** — concise rules and file map for Cursor (and similar).
- **`docs/AI_CONTEXT.md`** — full operator intent, domain strategy, and constraints for future development sessions.

## Layout

Multi-page site (no catch-all rewrite to `index.html` for `.html` routes).

- `index.html` — home, hero, **Explore** hub
- `services.html`, `method.html`, `proof.html`, `trust.html`, `about.html`, `contact.html`
- `ao-layout.js` — shared nav + footer (`data-ao-page` on `<body>`)
- `agenticops.css` — theme
- `logo.svg`, `404.html`, `robots.txt`, `sitemap.xml`, `humans.txt`

## Deploy (Firebase)

Dedicated Firebase project: **`agenticops-io-web`**. Default Hosting site ID matches the project ID → **`https://agenticops-io-web.web.app`**.

From **this directory** (not the monorepo root):

**Dedicated project (default Firebase URL):**

```bash
cd brand/agenticops-web   # from monorepo root
firebase deploy --only hosting --project agenticops-io-web
```

**Custom domain still on `wisptools-production` / site `agenticops-production`:** deploy the same files there so **`https://agenticop.io`** matches **`agenticops-io-web`** once Console/DNS point at the right place — or run this whenever the apex domain is still mapped to that site:

```powershell
.\scripts\deploy-custom-domain-hosting.ps1
```

Always pass **`--project agenticops-io-web`** for the dedicated project so the CLI never picks the monorepo root default (**`wisptools-production`**).

**Monorepo root** `firebase.json` does not deploy this site; deploy AgenticOps only from here.

**Custom domain:** Prefer attaching **`agenticop.io`** to **`agenticops-io-web`** in Console and updating DNS per **`DNS_SETUP.md`**. Until then, keep **`agenticops-production`** in sync with the script above if that site still owns the domain.

## Brand architecture (short)

- **AgenticOps** — this site.
- **Chrysalis** — https://github.com/4GEngineer/chrysalis
- **wisptools.io** — public MIT WISP stack; proof point; links from this site are intentional.

## SEO

Pages include canonical, Open Graph, Twitter Card, JSON-LD. Prefer a **1200×630** social PNG for `og:image` when available.

## DNS & domains

See **`DNS_SETUP.md`** (Firebase custom domains, GoDaddy-style records, removing mistaken domains).
