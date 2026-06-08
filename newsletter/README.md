# Newsletter-System (listmonk)

Self-hosted Newsletter-Sammlung & -Versand für die Jola-Vell-Seite. Volle Datenhoheit,
DSGVO-Double-Opt-In, kein Drittanbieter, der die Liste besitzt.

Deployt auf Coolify (`apps.weller.cc`) als **Docker-Compose-App aus diesem Repo**
(`build-pack: dockercompose`, `base-directory: /newsletter`, Branch `main`) unter der Domain
**https://newsletter.weller.cc**.

Das Anmeldeformular der Website (`index.html`, Sektion „Der innere Zirkel") spricht die
öffentliche listmonk-API an:

```
POST https://newsletter.weller.cc/api/public/subscription
Content-Type: application/json
{ "email": "leser@example.de", "name": "", "list_uuids": ["<LISTEN-UUID>"] }
```

## Secrets
Stehen NICHT im Repo. Coolify generiert sie über die `SERVICE_*`-Magic-Variablen im Compose:
- `SERVICE_PASSWORD_ADMIN` → listmonk-Admin-Passwort (User: `admin`)
- `SERVICE_USER/PASSWORD_POSTGRES` → DB-Zugang

Die generierten Werte stehen in Coolify unter dem Service → **Environment Variables**
(oder via CLI: `coolify service env list <uuid> -s`).

## Noch manuell zu erledigen (einmalig)

1. **SMTP** (Pflicht für Double-Opt-In-Mails): listmonk-Admin → Settings → SMTP. Absender
   pseudonym (z. B. `newsletter@weller.cc`). Ohne SMTP werden keine Bestätigungsmails versendet.
2. **Liste** mit **Double-Opt-In** anlegen (falls noch nicht via API geschehen) und deren
   **UUID** in `index.html` (`NEWSLETTER.listUuid`) eintragen.
3. **CORS:** Das Formular ruft die API cross-origin von `www.jolavell.com` auf. listmonk sendet
   standardmäßig keine CORS-Header → entweder via Reverse-Proxy same-origin betreiben oder die
   Anbindung auf den klassischen `POST /subscription/form` (Hidden-iFrame, CORS-frei) umstellen.
   Siehe `NEWSLETTER`-Config-Kommentar in `index.html`.

## Liste exportieren
listmonk → **Subscribers → Export** (CSV). Jederzeit, gehört vollständig euch.

## Doku
listmonk: https://listmonk.app/docs/
