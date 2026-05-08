# GoDaddy DNS + Google Workspace: multiple domains, primary switch, `admin@` labels

This is the checklist to apply **in your accounts**. No automation here can log into GoDaddy or the Admin console for you.

## Prerequisites

- [Google Workspace](https://workspace.google.com/) (not consumer Gmail) if you want real `@yourbrand.tld` mailboxes on your domains.
- Domains registered or DNS-hosted at GoDaddy.
- Admin access: GoDaddy + Google Admin (`admin.google.com`).

Confirm Google’s current MX and setup steps here (values can change):  
[Set up MX records for Google Workspace](https://support.google.com/a/answer/174125).

---

## Part A — DNS at GoDaddy (repeat per domain that should receive mail)

GoDaddy paths vary slightly by UI version; use the closest match.

1. Sign in at [https://dcc.godaddy.com/](https://dcc.godaddy.com/) (Domain portfolio).
2. Open the domain → **DNS** or **Manage DNS** (sometimes **Domain** → **DNS**).
3. **Remove or pause** other MX providers on that domain (only one mail provider should own MX).

### A1. Workspace domain verification (TXT)

Google Admin → **Account** → **Domains** → **Manage domains** → add/verify domain. Google shows a **TXT** record (often something like `google-site-verification=...`).

In GoDaddy **Records**:

| Type | Name / Host | Value |
|------|----------------|--------|
| TXT | `@` (or blank / domain root — GoDaddy’s label for apex) | paste verification string |

TTL: default or 1 hour.

### A2. MX records (Google Workspace)

Add **five** MX rows as Google documents for Workspace (priorities and hostnames from the official article above). Typical pattern:

| Type | Name / Host | Priority | Value |
|------|-------------|----------|--------|
| MX | `@` | 1 | `ASPMX.L.GOOGLE.COM` |
| MX | `@` | 5 | `ALT1.ASPMX.L.GOOGLE.COM` |
| MX | `@` | 5 | `ALT2.ASPMX.L.GOOGLE.COM` |
| MX | `@` | 10 | `ALT3.ASPMX.L.GOOGLE.COM` |
| MX | `@` | 10 | `ALT4.ASPMX.L.GOOGLE.COM` |

Remove old MX rows pointing at GoDaddy forwarding, Microsoft, etc.

### A3. SPF (TXT)

One SPF TXT at apex (adjust if Google’s wizard gives a different recommended string):

| Type | Name | Value |
|------|------|--------|
| TXT | `@` | `v=spf1 include:_spf.google.com ~all` |

If you already have SPF, **merge** includes — do not create duplicate SPF TXT records.

### A4. DKIM

Admin console → **Apps** → **Google Workspace** → **Gmail** → **Authenticate email** → generate DKIM. Google gives a **TXT** (or CNAME in some flows) — create exactly that record in GoDaddy.

### A5. Verify from your PC

```powershell
nslookup -type=MX yourdomain.com 1.1.1.1
nslookup -type=TXT yourdomain.com 1.1.1.1
```

Repeat for each domain that sends/receives Google mail (`wisptools…`, `agenticop…`, third domain).

---

## Part B — Change which domain is “main” (Workspace primary domain)

This is **only** in Google Admin, not GoDaddy. Full official steps and restrictions:

[Change your primary domain for Google Workspace](https://support.google.com/a/answer/7009324)

Summary:

1. Add the future primary as a **secondary domain** (if it exists today only as a **domain alias**, Google may require removing it and re-adding as secondary first — see Google’s “Before you begin” on that page).
2. Verify domain + MX on the **new** domain.
3. **Account** → **Domains** → **Change primary domain**.
4. Rename **users** and **groups** to the new `@domain` as Google describes.
5. Optionally keep the old primary as a **domain alias** so old addresses still work.

GoDaddy’s role is **only** DNS (verification, MX, SPF, DKIM) for each attached domain.

---

## Part C — `admin@` for WISPTools vs AgenticOp → Gmail labels

1. **Admin console** → **Directory** → **Users** → open your admin user (or create `admin` if that’s the mailbox you use).
2. Under **User information** → **Alternate email addresses** (aliases), add:

   - `admin@<your-wisptools-domain>`
   - `admin@<your-agentic-domain>`

   Both domains must already be in **Manage domains** with correct MX.

3. In **Gmail** (signed in as that user):

   - **Settings** (gear) → **See all settings** → **Filters and Blocked Addresses** → **Create a new filter**.
   - Filter **To**: `admin@<your-wisptools-domain>` → **Create filter** → **Apply the label:** e.g. `WISPTools` (create label if needed). Optionally **Skip the Inbox**.
   - Repeat for **To**: `admin@<your-agentic-domain>` → label e.g. `AgenticOp`.

Gmail help: [Create rules to filter email](https://support.google.com/mail/answer/6579).

---

## Part D — Chrome Enterprise Core API (optional automation)

If you use **cloud-managed Chrome browsers** (Chrome Enterprise Core) and call Google’s **Directory API** for browser devices from a script or backend, follow Google’s setup guide:

[Use the Chrome Enterprise Core API](https://support.google.com/chrome/a/answer/9681204?ref_topic=9301744)

That doc covers:

1. **Enable the Admin SDK API** in Google Cloud Console for the project you use for automation (API library: [Admin SDK API](https://console.cloud.google.com/apis/library/admin.googleapis.com)).
2. **OAuth scopes** for Chrome browser inventory — use one of:
   - `https://www.googleapis.com/auth/admin.directory.device.chromebrowsers.readonly`
   - `https://www.googleapis.com/auth/admin.directory.device.chromebrowsers`
3. **Domain-wide delegation** (service account impersonating an admin): Admin console → **Security** → **Access and data control** → **API controls** → **Domain-wide delegation** → add your service account **Client ID** and the scope(s) above.

Allowlisting note: clients reaching `https://www.googleapis.com/...` need outbound HTTPS to Google APIs (often `*.googleapis.com`), not the Help Center URL. The support article is for humans reading setup steps.

Primary-domain changes: some **Chrome Enterprise / Education** license scenarios require **Google support** before switching primary domain — see the restrictions list in [Change your primary domain for Google Workspace](https://support.google.com/a/answer/7009324).

---

## Quick troubleshooting

| Symptom | Check |
|--------|--------|
| “Domain already used” in Workspace | Domain tied to another Google account — release or use a different Google Cloud org flow per Google’s troubleshooting. |
| Mail not arriving | MX only on one provider; propagation can take hours; wrong host (`@` vs `www`). |
| Verification fails | TXT at apex; no typos; wait for TTL. |
| Can’t click “Change primary domain” | See “You can’t change your primary domain if…” in Google’s article (trial, reseller, legacy free, etc.). |
| Chrome Enterprise Core API returns 403 / unauthorized | [Chrome Enterprise Core API](https://support.google.com/chrome/a/answer/9681204?ref_topic=9301744): Admin SDK enabled, correct scopes, domain-wide delegation Client ID + scopes, impersonated user is a Workspace admin. |

---

## Placeholders to replace

Replace these with your real names before you work:

- `<your-wisptools-domain>` — e.g. `wisptools.io`
- `<your-agentic-domain>` — e.g. `agenticop.io`
- Third domain — decide primary vs alias vs secondary before cutting over.
