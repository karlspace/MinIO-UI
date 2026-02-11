## [1.8.0](https://github.com/karlspace/MinIO-UI/compare/v1.7.6...v1.8.0) (2026-02-11)

### 🚀 Features

* add Docker configuration for MinIO Console with entrypoint script and environment setup ([a970e68](https://github.com/karlspace/MinIO-UI/commit/a970e688fb8bbafdd773ba1607b6e0fed2a5a0be))
* add minio-setup init container for dev environment ([1e6358a](https://github.com/karlspace/MinIO-UI/commit/1e6358a12f48feac08612b50ddf1f0acee5fde92))
* Aktualisierung der Login-Seitenbeschreibung und -links zur besseren Benutzerführung ([af9d579](https://github.com/karlspace/MinIO-UI/commit/af9d579dcffad93f73c0396f168e587d4a6c6bcb))
* Aktualisierung des Dockerfiles zur Installation von Git und Optimierung des Frontend-Bauprozesses ([93a1855](https://github.com/karlspace/MinIO-UI/commit/93a18555eb10143ab4e8a551ee38dd74724a637d))
* Anpassung der CopyToClipboard-Komponente zur Verwendung von React.Fragment in mehreren Dateien ([a1f44ee](https://github.com/karlspace/MinIO-UI/commit/a1f44ee71d460a53e619b46cf8f6b923c2fcf53f))
* auto release workflow ([ec32008](https://github.com/karlspace/MinIO-UI/commit/ec320082e45fd17502e1aa8af92d7ef9a058bb91))
* Einführung des obligatorischen Parameters CONSOLE_MINIO_REGION und Validierung in der Einstiegsskript ([53ef4ee](https://github.com/karlspace/MinIO-UI/commit/53ef4ee4f82f9f47314e6c72ce4f92cb43857ffd))
* hinzufügen einer Analyse der entfernten Funktionalitäten in MinIO Console v2.0.0 ([5f19f8a](https://github.com/karlspace/MinIO-UI/commit/5f19f8a4cd9fb4d0e969b89efc9233d034c684c9))
* hinzufügen von Sicherheitsupdates und Wiederherstellungsplan für Full Admin-Funktionalität ([5e3aead](https://github.com/karlspace/MinIO-UI/commit/5e3aeadff65385c087b4a6bcfefa39501b25ea36))
* Replace logo.svg with a new design featuring a gradient background and a storage/database icon, along with an admin/console symbol represented as a gear. ([daf1cec](https://github.com/karlspace/MinIO-UI/commit/daf1cec7d4d65efc036674226f2fdb5f7f2c85b6))
* restructure Docker setup and rewrite README ([ffdee75](https://github.com/karlspace/MinIO-UI/commit/ffdee758326e5745892bed5c69694ff415d39a7e))
* umfassende Überarbeitung der Projektdokumentation und Rebranding zum 'Admin Console for MinIO®' ([1534817](https://github.com/karlspace/MinIO-UI/commit/15348174be8c952788c0095212c5c364452d4825))

### 🐛 Bug Fixes

* add CRLF handling to Dockerfile entrypoint and document deployment readiness ([9e032f3](https://github.com/karlspace/MinIO-UI/commit/9e032f33235811bf711296ab43b7e3327b03b0d9))
* Aktualisierung des Titels und der Version im Swagger-Dokument für die Admin-Konsole ([aa0980f](https://github.com/karlspace/MinIO-UI/commit/aa0980f37cfe3062c69ebbc8bfe417b98461ec6e))
* Behebung von TypeScript-Inkompatibilitäten in mehreren Komponenten und Anpassung des WebSocket-Typs ([4160447](https://github.com/karlspace/MinIO-UI/commit/4160447d6a69b865e6c8a5ce5fa8f00625cf724d))
* buld references ([38e9437](https://github.com/karlspace/MinIO-UI/commit/38e9437902b262d94ace84b78dbf026710ae9b2e))
* default secrets ([a5dabe9](https://github.com/karlspace/MinIO-UI/commit/a5dabe95a6e3799766e3fdc9ac5680cb73455b5e))
* Entfernen von MinIO-Logos und Ersetzen durch markenrechtlich unbedenkliche Icons; Einführung des obligatorischen Parameters CONSOLE_MINIO_REGION ([bf8c348](https://github.com/karlspace/MinIO-UI/commit/bf8c348b79f4a0e52c1bfa2f105741ea8f345add))
* Entfernen von Screenshots mit MinIO-Branding zur Wahrung der rechtlichen Compliance ([058f679](https://github.com/karlspace/MinIO-UI/commit/058f67902040aaf219d1d03e0a71188066709106))
* gitignore fuer .env, web-app/build und coverage ([7610645](https://github.com/karlspace/MinIO-UI/commit/7610645f25e2fadb17440a710cc30fbe087587db))
* hardcode healthcheck port (port mapping is external) ([9bb88e4](https://github.com/karlspace/MinIO-UI/commit/9bb88e41d149cc3439a6bbaaf0562e97cf911036))
* Hinzufügen von .claude/ zum .gitignore ([2d61ccb](https://github.com/karlspace/MinIO-UI/commit/2d61ccb5a6ca5a3edcf8fe2501428476f469024d))
* install corepack separately for Node 24 ([2306241](https://github.com/karlspace/MinIO-UI/commit/2306241063c1edaa4fcbb94bd6d06a3df05000df))
* remove non-existent .yarn directory from Dockerfile COPY ([8be46f1](https://github.com/karlspace/MinIO-UI/commit/8be46f1a9f66e9b6b351611c611ee37b3cc70849))
* remove TLS/HTTPS support (Traefik handles TLS) ([5cf267b](https://github.com/karlspace/MinIO-UI/commit/5cf267bfdc43c7bb806ae2fdc15c927d31eb6180))
* remove unnecessary PBKDF env vars from dev compose ([ccdb892](https://github.com/karlspace/MinIO-UI/commit/ccdb892162e434ddb4414e4a7e228a84609ca1cc))
* script errors ([edbdcb0](https://github.com/karlspace/MinIO-UI/commit/edbdcb05d584c317a96f473075a30d9f9b70cc0b))
* streamline entrypoint script permissions and certificate directory setup ([8a872e5](https://github.com/karlspace/MinIO-UI/commit/8a872e52682e99ff972848e56a403037db73bb5f))
* update to Node 24 LTS and Go 1.26 ([11e7291](https://github.com/karlspace/MinIO-UI/commit/11e7291574d44ce01c25ebfc5e2b5c7623e39807))
* update yarn install flag from --frozen-lockfile to --immutable ([8437b72](https://github.com/karlspace/MinIO-UI/commit/8437b72966422838f15ffcabb6f17eaf15d5004c))
* yarn build ([363a77c](https://github.com/karlspace/MinIO-UI/commit/363a77c25ecdb29cb927c6e16d1e5a1b4cd497c4))

### ♻️ Refactoring

* Entfernen von Lizenzinformationen und -benachrichtigungen aus MenuWrapper und validRoutes ([a9e84ab](https://github.com/karlspace/MinIO-UI/commit/a9e84ab4e2ad2c8039e0ea5c1b22bf4fb3ff2837))

# Changelog - Admin Console for MinIO®

> **Disclaimer:** MinIO® is a registered trademark of MinIO, Inc. This project is an independent, third-party administrative interface and is not affiliated with MinIO, Inc.

## Release v1.7.6-extended (This Fork)

Based on MinIO Console v1.7.6 with security updates from v2.0.0-v2.0.4 applied:
- Go 1.23.8 (latest)
- Security patches for Go dependencies (crypto v0.36.0, net v0.38.0, oauth2 v0.28.0)
- Security patches for npm packages (http-proxy-middleware, formidable)
- Full administrative functionality preserved
- Docker deployment optimized
- Project rebranded with proper disclaimers

---

## Release v1.7.6 (Upstream)

Bug Fix:

- Fix null pointer exception in Admin Info
- Ignore leading or trailing spaces in login request
- Fix file path on drag and drop
- Fix typo in User DN Search Filter example

## Release v1.7.5

Bug Fix:

- Fixed leaks during ZIP multiobject downloads
- Allow spaces in Policy names

## Release v1.7.4

Deprecations:

- Deprecated support tools User Interface in favor of mc admin commands. Please refer to the [MinIO SUBNET Registration page](https://min.io/docs/minio/linux/administration/console/subnet-registration.html#subnet) for more information.
- Deprecated Site replication User Interface in favor of mc admin commands. Please refer to the [MinIO Site Replication page](https://min.io/docs/minio/linux/operations/install-deploy-manage/multi-site-replication.html) for more information.
- Deprecated Lifecycle & Tiers User Interface in favor of mc admin commands. Please refer to the [MinIO Tiers page](https://min.io/docs/minio/linux/reference/minio-mc/mc-ilm-tier.html) for more information.

Bug Fix:

- Avoid loading unpkg.com call when login animation is off

## Release v1.7.3

Bug Fix:

- Use a fixed public license verification key
- Show non-expiring access keys as `no-expiry` instead of Jan 1, 1970
- Use "join Slack" button for non-commercial edition instead of "Signup"
- Fix setting policies on groups that have spaces

## Release v1.7.2

Bug Fix:

- Fixed issue in Server Health Info
- Fixed Security vulnerability in dependencies
- Fixed client string in trace message

Additional Changes:

- Remove live logs in Call Home Page
- Update License page

## Release v1.7.1

Bug Fix:

- Fixed issue that could cause a failure when attempting to view deleted files in the object browser
- Return network error when logging in and the network connection fails

Additional Changes:

- Added debug logging for console HTTP request (see [PR #3440](https://github.com/minio/console/pull/3440) for more detailed information)

## Release v1.7.0

Bug Fix:

- Fixed directory listing
- Fix MinIO videos link

Additional Changes:

- Removed deprecated KES functionality

## Release v1.6.3

Additional Changes:

- Updated go.mod version

## Release v1.6.2

Bug Fix:

- Fixed minor user session issues
- Updated project dependencies

Additional Changes:

- Improved Drives List visualization
- Improved WS request logic
- Updated License page with current MinIO plans.

## Release v1.6.1

Bug Fix:

- Fixed objectManager issues under certain conditions
- Fixed Security vulnerability in dependencies

Additional Changes:

- Improved Share Link behavior

## Release v1.6.0

Bug Fix:

- Fixed share link encoding
- Fixed Edit Lifecycle Storage Class
- Added Tiers Improvements for Bucket Lifecycle management

Additional Changes:

- Vulnerability updates
- Update Logo logic

## Release v1.5.0

Features:

- Added remove Tier functionality

Bug Fix:

- Fixed ILM rule tags not being shown
- Fixed race condition Object Browser websocket
- Fixed Encryption page crashing on empty response
- Fixed Replication Delete Marker comparisons

Additional Changes:

- Use automatic URI encoding for APIs
- Vulnerability updates

## Release v1.4.0

Features:

- Added VersionID support to metadata details
- Improved Websockets handlers

Bug Fix:

- Fixed vulnerabilities and updated dependencies
- Fixed an issue with Download URL decoding
- Fixed leak in Object Browser Websocket
- Minor UX fixes

## Release v1.3.0

Features:

- Adds ExpireDeleteMarker status to BucketLifecycleRule UI

Bug Fix:

- Fixed vulnerability
- Used URL-safe base64 enconding for Share API
- Made Prefix field optional when Adding Tier
- Added Console user agent in MinIO Admin Client

## Release v1.2.0

Features:

- Updated file share logic to work as Proxy

Bug Fix:

- Updated project dependencies
- Fixed Key Permissions UX
- Added permissions validation to rewind button
- Fixed Health report upload to SUBNET
- Misc Cosmetic fixes

## Release v1.1.1

Bug Fix:

- Fixed folder download issue

## Release v1.1.0

Features:

- Added Set Expired object all versions selector

Bug Fix:

- Updated Go Dependencies

## Release v1.0.0

Features:

- Updated Preview message alert

Bug Fix:

- Updated Websocket API
- Fixed issues with download manager
- Fixed policies issues

## Release v0.46.0

Features:

- Added latest help content to forms

Bug Fix:

- Disabled Create User button in certain policy cases
- Fixed an issue with Logout request
- Upgraded project dependencies

## Release v0.45.0

Deprecated:

- Deprecated Heal / Drives page

Features:

- Updated tines on menus & pages

Bug Fix:

- Upgraded project dependencies

## Release v0.44.0

Bug Fix:

- Upgraded project dependencies
- Fixed events icons not loading in subpaths

## Release v0.43.1

Bug Fix:

- Update Share Object UI to reflect maximum expiration time in UI

## Release v0.43.0

Features:

- Updated PDF preview method

Bug Fix:

- Fixed vulnerabilities
- Prevented non-necessary metadata calls in object browser

## Release v0.42.2

Bug Fix:

- Hidden Prometheus metrics if URL is empty

## Release v0.42.1

Bug Fix:

- Reset go version to 1.19

## Release v0.42.0

Features:

- Introducing Dark Mode

Bug Fix:

- Fixed vulnerabilities
- Changes on Upload and Delete object urls
- Fixed blocking subpath creation if not enough permissions
- Removed share object option at prefix level
- Updated allowed actions for a deleted object

## Release v0.41.0

Features:

- Updated pages to use mds components
- support for resolving IPv4/IPv6

Bug Fix:

- Remove cache for ClientIP
- Fixed override environment variables display in settings page
- Fixed daylight savings time support in share modal

## Release v0.40.0

Features:

- Updated OpenID page
- Added New bucket event types support

Bug Fix:

- Fixed crash in access keys page
- Fixed AuditLog filters issue
- Fixed multiple issues with Object Browser

## Release v0.39.0

Features:

- Migrated metrics page to mds
- Migrated Register page to mds

Bug Fix:

- Fixed LDAP configuration page issues
- Load available certificates in logout
- Updated dependencies & go version
- Fixed delete objects functionality

## Release v0.38.0

Features:

- Added extra information to Service Accounts page
- Updated Tiers, Site Replication, Speedtest, Heal & Watch pages components

Bug Fix:

- Fixed IDP expiry time errors
- Updated project Dependencies

## Release v0.37.0

Features:

- Updated Trace and Logs page components
- Updated Prometheus metrics

Bug Fix:

- Disabled input fields for Subscription features if MinIO is not registered

## Release v0.36.0

Features:

- Updated Settings page components

Bug Fix:

- Show LDAP Enabled value LDAP configuration
- Download multiple objects in same path as they were selected

## Release v0.35.1

Bug Fix:

- Change timestamp format for zip creation

## Release v0.35.0

Features:

- Add Exclude Folders and Exclude Prefixes during bucket creation
- Download multiple selected objects as zip and ignore deleted objects
- Updated Call Home, Inspet, Profile and Health components

Bug Fix:

- Remove extra white spaces for configuration strings
- Allow Create New Path in bucket view when having right permissions

## Release v0.34.0

Features:

- Updated Buckets components

Bug Fix:

- Fixed SUBNET Health report upload
- Updated Download Handler
- Fixes issue with rewind
- Avoid 1 hour expiration for IDP credentials

---

## Release v0.33.0

Features:

- Updated OpenID, LDAP components

Bug Fix:

- Fixed security issues
- Fixed navigation issues in Object Browser
- Fixed Dashboard metrics

---

## Release v0.32.0

Features:

- Updated Users and Groups components
- Added placeholder image for Help Menu

Bug Fix:

- Fixed memory leak in WebSocket API for Object Browser

---

## Release v0.31.0

**Breaking Changes:**

- **Removed support for Standalone Deployments**

Features:

- Updated way files are displayed in uploading component
- Updated Audit Logs and Policies components

Bug Fix:

- Fixed Download folders issue in Object Browser
- Added missing Notification Events (ILM & REPLICA) in Events Notification Page
- Fixed Security Vulnerability for `semver` dependency

---

## Release v0.30.0

Features:

- Added MinIO Console Help Menu
- Updated UI Menu components

Bug Fix:

- Disable the Upload button on Object Browser if the user is not allowed
- Fixed security vulnerability for `lestrrat-go/jwx` and `fast-xml-parser`
- Fixed bug on sub-paths for Object Browser
- Reduce the number of calls to `/session` API endpoint to improve performance
- Rolled back the previous change for the Share File feature to no longer ask for Service Account access keys
