## 1.0.0 (2026-02-11)

### 🚀 Features

* add Docker configuration for MinIO Console with entrypoint script and environment setup ([a970e68](https://github.com/karlspace/MinIO-UI/commit/a970e688fb8bbafdd773ba1607b6e0fed2a5a0be))
* add minio-setup init container for dev environment ([1e6358a](https://github.com/karlspace/MinIO-UI/commit/1e6358a12f48feac08612b50ddf1f0acee5fde92))
* Aktualisierung der Login-Seitenbeschreibung und -links zur besseren Benutzerführung ([af9d579](https://github.com/karlspace/MinIO-UI/commit/af9d579dcffad93f73c0396f168e587d4a6c6bcb))
* Aktualisierung des Dockerfiles zur Installation von Git und Optimierung des Frontend-Bauprozesses ([93a1855](https://github.com/karlspace/MinIO-UI/commit/93a18555eb10143ab4e8a551ee38dd74724a637d))
* Anpassung der CopyToClipboard-Komponente zur Verwendung von React.Fragment in mehreren Dateien ([a1f44ee](https://github.com/karlspace/MinIO-UI/commit/a1f44ee71d460a53e619b46cf8f6b923c2fcf53f))
* auto release workflow ([ec32008](https://github.com/karlspace/MinIO-UI/commit/ec320082e45fd17502e1aa8af92d7ef9a058bb91))
* docker labels ([9fd2418](https://github.com/karlspace/MinIO-UI/commit/9fd2418f59c0d7ec7131c86ca17ec8fe5093c63b))
* download multiple object selection as zip ignoring any deleted objects selected ([#2965](https://github.com/karlspace/MinIO-UI/issues/2965)) ([b968cc2](https://github.com/karlspace/MinIO-UI/commit/b968cc25add0854847cd377a4f78aa58ae54427f))
* Einführung des obligatorischen Parameters CONSOLE_MINIO_REGION und Validierung in der Einstiegsskript ([53ef4ee](https://github.com/karlspace/MinIO-UI/commit/53ef4ee4f82f9f47314e6c72ce4f92cb43857ffd))
* hinzufügen einer Analyse der entfernten Funktionalitäten in MinIO Console v2.0.0 ([5f19f8a](https://github.com/karlspace/MinIO-UI/commit/5f19f8a4cd9fb4d0e969b89efc9233d034c684c9))
* hinzufügen von Sicherheitsupdates und Wiederherstellungsplan für Full Admin-Funktionalität ([5e3aead](https://github.com/karlspace/MinIO-UI/commit/5e3aeadff65385c087b4a6bcfefa39501b25ea36))
* Replace logo.svg with a new design featuring a gradient background and a storage/database icon, along with an admin/console symbol represented as a gear. ([daf1cec](https://github.com/karlspace/MinIO-UI/commit/daf1cec7d4d65efc036674226f2fdb5f7f2c85b6))
* restructure Docker setup and rewrite README ([ffdee75](https://github.com/karlspace/MinIO-UI/commit/ffdee758326e5745892bed5c69694ff415d39a7e))
* subpath support using reverse proxy ([#2174](https://github.com/karlspace/MinIO-UI/issues/2174)) ([c71f084](https://github.com/karlspace/MinIO-UI/commit/c71f0845318d59a45a0e37280d5395c631f26e0f))
* Support dynamic redirect_uris based on incoming requests ([#1227](https://github.com/karlspace/MinIO-UI/issues/1227)) ([373bfbf](https://github.com/karlspace/MinIO-UI/commit/373bfbfe3f16e6f7d376fb9765a4610d76cf15a2))
* umfassende Überarbeitung der Projektdokumentation und Rebranding zum 'Admin Console for MinIO®' ([1534817](https://github.com/karlspace/MinIO-UI/commit/15348174be8c952788c0095212c5c364452d4825))

### 🐛 Bug Fixes

* access audit for bucket ([#1270](https://github.com/karlspace/MinIO-UI/issues/1270)) ([b29fc09](https://github.com/karlspace/MinIO-UI/commit/b29fc0993b145fb607c0f7f805e6e5aad6223279))
* add CRLF handling to Dockerfile entrypoint and document deployment readiness ([9e032f3](https://github.com/karlspace/MinIO-UI/commit/9e032f33235811bf711296ab43b7e3327b03b0d9))
* add new dashboard metrics ([#2952](https://github.com/karlspace/MinIO-UI/issues/2952)) ([6cec113](https://github.com/karlspace/MinIO-UI/commit/6cec11330489d1661a45c91daeef8617eee2fa76))
* add support for userInfo endpoint ([#1048](https://github.com/karlspace/MinIO-UI/issues/1048)) ([b6f818b](https://github.com/karlspace/MinIO-UI/commit/b6f818bdd3772ef23114c46991374e6eb637c52a))
* Aktualisierung des Titels und der Version im Swagger-Dokument für die Admin-Konsole ([aa0980f](https://github.com/karlspace/MinIO-UI/commit/aa0980f37cfe3062c69ebbc8bfe417b98461ec6e))
* allow TLS access on multiple SNI certs ([#812](https://github.com/karlspace/MinIO-UI/issues/812)) ([55531d6](https://github.com/karlspace/MinIO-UI/commit/55531d605b5a291dd8b3cefc2809c702bb7dc530))
* assets build missing entries in index.html ([b79c228](https://github.com/karlspace/MinIO-UI/commit/b79c2288906ee3f1919fcbd541e947a0631cdd63))
* avoid versioning list per objects ([bfedc14](https://github.com/karlspace/MinIO-UI/commit/bfedc1449791edf4dc9c77f9b4905b79cc9e466e))
* Behebung von TypeScript-Inkompatibilitäten in mehreren Komponenten und Anpassung des WebSocket-Typs ([4160447](https://github.com/karlspace/MinIO-UI/commit/4160447d6a69b865e6c8a5ce5fa8f00625cf724d))
* broken STS Sessions with large policies ([#1096](https://github.com/karlspace/MinIO-UI/issues/1096)) ([1b225e0](https://github.com/karlspace/MinIO-UI/commit/1b225e090139f08d07e656c7c4cf3ca8cc7107b4))
* buckets browse button was not clickable ([#2249](https://github.com/karlspace/MinIO-UI/issues/2249)) ([697910c](https://github.com/karlspace/MinIO-UI/commit/697910c7b213c5bb054a1d32e2ed412afe9b0ca4))
* buld references ([38e9437](https://github.com/karlspace/MinIO-UI/commit/38e9437902b262d94ace84b78dbf026710ae9b2e))
* cache clientIP in GetConsoleHTTPClient ([#3056](https://github.com/karlspace/MinIO-UI/issues/3056)) ([4018add](https://github.com/karlspace/MinIO-UI/commit/4018addd792d4360e9b589df21ed5fed8563fa89))
* capacity reported usage value ([#2028](https://github.com/karlspace/MinIO-UI/issues/2028)) ([48119ac](https://github.com/karlspace/MinIO-UI/commit/48119acc72be983599c56b87fe85d655241b2d09))
* change password is implicit ([#861](https://github.com/karlspace/MinIO-UI/issues/861)) ([445c0be](https://github.com/karlspace/MinIO-UI/commit/445c0be5b1cf4a6ea1d9ee9d7bb418734d01a634))
* Check if console is deployed with external certs for metrics proxy ([#999](https://github.com/karlspace/MinIO-UI/issues/999)) ([96e9bce](https://github.com/karlspace/MinIO-UI/commit/96e9bce33190c60417c060e0429fb104e156eaf8))
* client secret is optional in implicit flow ([#840](https://github.com/karlspace/MinIO-UI/issues/840)) ([9ec7326](https://github.com/karlspace/MinIO-UI/commit/9ec73260c9fcc7f61579cba88f80c9ee73b5381c))
* compress health diagnostics file when download ([#1821](https://github.com/karlspace/MinIO-UI/issues/1821)) ([68f9019](https://github.com/karlspace/MinIO-UI/commit/68f9019d0e09a9e475239bab88f2362d865c9e21))
* console should trust itself with its own public.crt ([#827](https://github.com/karlspace/MinIO-UI/issues/827)) ([fd86e65](https://github.com/karlspace/MinIO-UI/commit/fd86e65e5ed9e34311c0f124ca23272fa67a06b8))
* correct metric endpoint from minio_cluster_drive_free_inodes ([#3296](https://github.com/karlspace/MinIO-UI/issues/3296)) ([0557514](https://github.com/karlspace/MinIO-UI/commit/0557514cb4e1f50b3cad70b57949645569c95ba3)), closes [minio/console#3295](https://github.com/minio/console/issues/3295)
* crash in operator console for missing fsGroup ([#2211](https://github.com/karlspace/MinIO-UI/issues/2211)) ([cb6cda7](https://github.com/karlspace/MinIO-UI/commit/cb6cda7265fb55940674573309580132c7617677))
* crosscompile windows build ([#2391](https://github.com/karlspace/MinIO-UI/issues/2391)) ([c316532](https://github.com/karlspace/MinIO-UI/commit/c316532fe9a5e81d8d41f689899eb0d8cd704d93))
* dateTime usage only available in go1.20 ([#2982](https://github.com/karlspace/MinIO-UI/issues/2982)) ([fed5aa1](https://github.com/karlspace/MinIO-UI/commit/fed5aa1599e4ece2025387968bb870a9aa4ba752))
* default secrets ([a5dabe9](https://github.com/karlspace/MinIO-UI/commit/a5dabe95a6e3799766e3fdc9ac5680cb73455b5e))
* derivedKey should not be a global variable ([#862](https://github.com/karlspace/MinIO-UI/issues/862)) ([54dfcbd](https://github.com/karlspace/MinIO-UI/commit/54dfcbd378d295edc8d557ea589ff1bf933b9924))
* do not use var to define global sets ([#818](https://github.com/karlspace/MinIO-UI/issues/818)) ([13f9f6c](https://github.com/karlspace/MinIO-UI/commit/13f9f6c848d0c90b63ce7cc81d494c67c4b4a8b1))
* docker compose example ([a0e4a62](https://github.com/karlspace/MinIO-UI/commit/a0e4a622787d383238a8e7dc65ca7e61bbf16d2d))
* download objects and delete tags for object browser ([#1118](https://github.com/karlspace/MinIO-UI/issues/1118)) ([7c82306](https://github.com/karlspace/MinIO-UI/commit/7c82306cc0dde8426fee7ab23df56c9fcde66327))
* Entfernen von MinIO-Logos und Ersetzen durch markenrechtlich unbedenkliche Icons; Einführung des obligatorischen Parameters CONSOLE_MINIO_REGION ([bf8c348](https://github.com/karlspace/MinIO-UI/commit/bf8c348b79f4a0e52c1bfa2f105741ea8f345add))
* Entfernen von Screenshots mit MinIO-Branding zur Wahrung der rechtlichen Compliance ([058f679](https://github.com/karlspace/MinIO-UI/commit/058f67902040aaf219d1d03e0a71188066709106))
* GetAllCertificatesAndCAs shouldn't fail internally ([#810](https://github.com/karlspace/MinIO-UI/issues/810)) ([f208ce5](https://github.com/karlspace/MinIO-UI/commit/f208ce5382055d0ce990f5577d74ceb546132114))
* getTimeFromTimestamp() incorrect padding for days ([#2029](https://github.com/karlspace/MinIO-UI/issues/2029)) ([175b87c](https://github.com/karlspace/MinIO-UI/commit/175b87c3558f275591b0e2829f35cd4172440a7b))
* gitignore fuer .env, web-app/build und coverage ([7610645](https://github.com/karlspace/MinIO-UI/commit/7610645f25e2fadb17440a710cc30fbe087587db))
* go mod tidy -compat=1.17 ([b8f024a](https://github.com/karlspace/MinIO-UI/commit/b8f024aa394326d640e47b33e07c391d26f07e21))
* handle crash in error handling of access keys page ([#3051](https://github.com/karlspace/MinIO-UI/issues/3051)) ([e7993c2](https://github.com/karlspace/MinIO-UI/commit/e7993c2d1b8bfa775ea1a9fac71e75d8db0631ab))
* handle crash in retention handler for object locked buckets ([#936](https://github.com/karlspace/MinIO-UI/issues/936)) ([79a4767](https://github.com/karlspace/MinIO-UI/commit/79a476712ff83403bf053435d714ed0dc65c801e))
* handling of no inline policy for service acc. ([#3221](https://github.com/karlspace/MinIO-UI/issues/3221)) ([0afea63](https://github.com/karlspace/MinIO-UI/commit/0afea639940920f5124369132faa1cb4efef195d))
* hard regression in console login from v0.19.2 release ([255cf0b](https://github.com/karlspace/MinIO-UI/commit/255cf0bc8524685d80543c65c8b02b495ddbc099)), closes [#2197](https://github.com/karlspace/MinIO-UI/issues/2197)
* hardcode healthcheck port (port mapping is external) ([9bb88e4](https://github.com/karlspace/MinIO-UI/commit/9bb88e41d149cc3439a6bbaaf0562e97cf911036))
* Hinzufügen von .claude/ zum .gitignore ([2d61ccb](https://github.com/karlspace/MinIO-UI/commit/2d61ccb5a6ca5a3edcf8fe2501428476f469024d))
* incorrect IP and bucket regexes ([#2469](https://github.com/karlspace/MinIO-UI/issues/2469)) ([0f35369](https://github.com/karlspace/MinIO-UI/commit/0f353692921004268b12bf2b9c1209e705f9f34c))
* install corepack separately for Node 24 ([2306241](https://github.com/karlspace/MinIO-UI/commit/2306241063c1edaa4fcbb94bd6d06a3df05000df))
* Labels for Node Selector in Pod Placement ([#2320](https://github.com/karlspace/MinIO-UI/issues/2320)) ([d84062b](https://github.com/karlspace/MinIO-UI/commit/d84062b1b21e669ab5d6afbd612eef840e1a3bca))
* lazily interpret environment values ([#826](https://github.com/karlspace/MinIO-UI/issues/826)) ([14604e0](https://github.com/karlspace/MinIO-UI/commit/14604e0cba695da39c1d4f2f5c3a74209b04a633))
* leaking fd's large object uploads ([#1026](https://github.com/karlspace/MinIO-UI/issues/1026)) ([c269285](https://github.com/karlspace/MinIO-UI/commit/c26928516d2dc6e4b1c3bccc4dc8597e938d0173))
* log search URL, token environment variables ([b10c4f5](https://github.com/karlspace/MinIO-UI/commit/b10c4f51b1ef224d215b898a88bf32f7f23a57b5))
* login function was returning fixed error ([#2308](https://github.com/karlspace/MinIO-UI/issues/2308)) ([cc581c6](https://github.com/karlspace/MinIO-UI/commit/cc581c6a9e8668dcca8f2f118c02c044429b67a0))
* more fixes related to object name encoding ([#1128](https://github.com/karlspace/MinIO-UI/issues/1128)) ([95f622a](https://github.com/karlspace/MinIO-UI/commit/95f622a597f57eabfeccf2a98f4759bbbee367db))
* objectManager implementation avoid racy goroutines ([#3392](https://github.com/karlspace/MinIO-UI/issues/3392)) ([22176f4](https://github.com/karlspace/MinIO-UI/commit/22176f4e0f855944a3ad05351ac886a39c5d5d73)), closes [#3391](https://github.com/karlspace/MinIO-UI/issues/3391)
* parseTenantCertificates was ignoring cert-manager secrets ([#1929](https://github.com/karlspace/MinIO-UI/issues/1929)) ([0622cc6](https://github.com/karlspace/MinIO-UI/commit/0622cc658b674da02d0ee412140427900e703e13))
* pass original http response code to proxy response ([#1772](https://github.com/karlspace/MinIO-UI/issues/1772)) ([ceeacd2](https://github.com/karlspace/MinIO-UI/commit/ceeacd2167540096996fc3ab3c8d79231aa91b59))
* passing correct httpClient, do not use DefaultClients ([#3319](https://github.com/karlspace/MinIO-UI/issues/3319)) ([e68a74b](https://github.com/karlspace/MinIO-UI/commit/e68a74ba488f38ec5be481cc358ecb68642a387a))
* policy handling with dynamic policy variables ([#1226](https://github.com/karlspace/MinIO-UI/issues/1226)) ([b8417fb](https://github.com/karlspace/MinIO-UI/commit/b8417fb7a0323af780344f20d3a77c46f31fb235))
* possible nil deref in admin_info ([#3500](https://github.com/karlspace/MinIO-UI/issues/3500)) ([115de8e](https://github.com/karlspace/MinIO-UI/commit/115de8ee25393ca2e47bdb373ee076e4eab2f2d3))
* probe content-type before upload ([#968](https://github.com/karlspace/MinIO-UI/issues/968)) ([e05c724](https://github.com/karlspace/MinIO-UI/commit/e05c724553491fd5f6996b6dbe7d6e0be88225da))
* properly support FS/Gateway mode ([#874](https://github.com/karlspace/MinIO-UI/issues/874)) ([2a6a6ca](https://github.com/karlspace/MinIO-UI/commit/2a6a6cab245a2725edb7da3e1aeeca1df7e0c55f))
* proxy has to read credentials from configuration secret ([#929](https://github.com/karlspace/MinIO-UI/issues/929)) ([d357ef9](https://github.com/karlspace/MinIO-UI/commit/d357ef9bcb473ce2f53627fd7806edb64f0d66dd))
* race Condition on Object Browser via Websocket ([#2492](https://github.com/karlspace/MinIO-UI/issues/2492)) ([bee98e1](https://github.com/karlspace/MinIO-UI/commit/bee98e1ba05d675018a8f108b04b684c1b8b13a4))
* remove non-existent .yarn directory from Dockerfile COPY ([8be46f1](https://github.com/karlspace/MinIO-UI/commit/8be46f1a9f66e9b6b351611c611ee37b3cc70849))
* remove response timeouts for console ([#864](https://github.com/karlspace/MinIO-UI/issues/864)) ([7bd6d73](https://github.com/karlspace/MinIO-UI/commit/7bd6d736638951a8a7af31ebff5424ddb33350a2))
* remove TLS/HTTPS support (Traefik handles TLS) ([5cf267b](https://github.com/karlspace/MinIO-UI/commit/5cf267bfdc43c7bb806ae2fdc15c927d31eb6180))
* remove unnecessary PBKDF env vars from dev compose ([ccdb892](https://github.com/karlspace/MinIO-UI/commit/ccdb892162e434ddb4414e4a7e228a84609ca1cc))
* rename mcS3Client to mcClient ([#214](https://github.com/karlspace/MinIO-UI/issues/214)) ([af8eb9a](https://github.com/karlspace/MinIO-UI/commit/af8eb9a147daa1cf7ec8e49712bb59d9b20e0ed2))
* script errors ([edbdcb0](https://github.com/karlspace/MinIO-UI/commit/edbdcb05d584c317a96f473075a30d9f9b70cc0b))
* streamline entrypoint script permissions and certificate directory setup ([8a872e5](https://github.com/karlspace/MinIO-UI/commit/8a872e52682e99ff972848e56a403037db73bb5f))
* subnet health triggering OOM, infinite loop ([#887](https://github.com/karlspace/MinIO-UI/issues/887)) ([87416b1](https://github.com/karlspace/MinIO-UI/commit/87416b1feef423bb798dc949d4133857d3891805))
* TLS issues with console ([#1043](https://github.com/karlspace/MinIO-UI/issues/1043)) ([9067e85](https://github.com/karlspace/MinIO-UI/commit/9067e85b55a1fdf7298b70d30aa65c42585be56b))
* turn-off TLS redirects if configured ([#574](https://github.com/karlspace/MinIO-UI/issues/574)) ([365778e](https://github.com/karlspace/MinIO-UI/commit/365778eecb3cbd0f880d5a69b6e238b393556203)), closes [#573](https://github.com/karlspace/MinIO-UI/issues/573)
* typo in queue-dir and queue-limit for notification targets ([#2403](https://github.com/karlspace/MinIO-UI/issues/2403)) ([2e8ad92](https://github.com/karlspace/MinIO-UI/commit/2e8ad9281dd2e16d3f84cff14bf658062139b263)), closes [#2402](https://github.com/karlspace/MinIO-UI/issues/2402)
* update assets refresh ([1ab37e0](https://github.com/karlspace/MinIO-UI/commit/1ab37e0b00db570c45fb57b43f4d634344cb1708))
* update goreleaser and docker ([e7f220b](https://github.com/karlspace/MinIO-UI/commit/e7f220b0699a502fa3be092085884ce73a0f10bb))
* update to Node 24 LTS and Go 1.26 ([11e7291](https://github.com/karlspace/MinIO-UI/commit/11e7291574d44ce01c25ebfc5e2b5c7623e39807))
* update yarn install flag from --frozen-lockfile to --immutable ([8437b72](https://github.com/karlspace/MinIO-UI/commit/8437b72966422838f15ffcabb6f17eaf15d5004c))
* upgrade to latest UBI 8.4 ([#848](https://github.com/karlspace/MinIO-UI/issues/848)) ([b19852a](https://github.com/karlspace/MinIO-UI/commit/b19852a75adb90d33c1f030cb64786e53cda1a60))
* Use STS env variable to increase the IDP token expiration ([#3132](https://github.com/karlspace/MinIO-UI/issues/3132)) ([7484861](https://github.com/karlspace/MinIO-UI/commit/748486160f4924b2a76ab41f7ea5803631bfd52e))
* websockets goroutine leak for object list UI ([#2805](https://github.com/karlspace/MinIO-UI/issues/2805)) ([1eba599](https://github.com/karlspace/MinIO-UI/commit/1eba59954d4fde0ca8a64925c52e8c91155dcfce))
* yarn build ([363a77c](https://github.com/karlspace/MinIO-UI/commit/363a77c25ecdb29cb927c6e16d1e5a1b4cd497c4))

### ⏪ Reverts

* Revert "Tiers & lifecycle implementation ([#615](https://github.com/karlspace/MinIO-UI/issues/615))" ([#636](https://github.com/karlspace/MinIO-UI/issues/636)) ([6f98ecc](https://github.com/karlspace/MinIO-UI/commit/6f98ecc59f39f98d829585b82c97a27b4e0ed760))

### ♻️ Refactoring

* Entfernen von Lizenzinformationen und -benachrichtigungen aus MenuWrapper und validRoutes ([a9e84ab](https://github.com/karlspace/MinIO-UI/commit/a9e84ab4e2ad2c8039e0ea5c1b22bf4fb3ff2837))
* replace deprecated String.prototype.substr() ([#1800](https://github.com/karlspace/MinIO-UI/issues/1800)) ([731501b](https://github.com/karlspace/MinIO-UI/commit/731501ba278229f428d562b84af2d57bb0b7ef65))

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
