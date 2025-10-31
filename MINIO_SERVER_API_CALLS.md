# MinIO Server API Calls - Vollständige Dokumentation

Diese Dokumentation beschreibt alle direkten API-Calls, die an den **MinIO Server** (`CONSOLE_MINIO_SERVER`) gemacht werden. Dies ist die Grundlage für den Bau einer eigenen Admin Console.

## Wichtig: Token-basierte Authentifizierung

⚠️ **Eigene Admin Consoles benötigen KEINE statischen Access Keys!**

MinIO unterstützt **STS (Security Token Service) AssumeRole**, wodurch Clients sich mit **Username/Password** authentifizieren können und temporäre Credentials (Access Key, Secret Key, Session Token) erhalten.

### Quick Start - STS Authentication Flow

```text
1. User gibt Username + Password ein
   ↓
2. POST https://minio-server:9000/?Action=AssumeRole
   Authorization: AWS4-HMAC-SHA256 (signiert mit username/password)
   ↓
3. MinIO Server antwortet mit temporären Credentials:
   - AccessKeyId: "AKIAIOSFODNN7EXAMPLE"
   - SecretAccessKey: "wJalrXUt..."
   - SessionToken: "FQoGZXIv..."
   - Expiration: 3600 seconds
   ↓
4. Client nutzt temporäre Credentials für alle API-Calls
   (Admin API, S3 API)
```

**Vorteile:**

- ✅ Keine statischen Access Keys im Client
- ✅ Temporäre Credentials mit Ablaufzeit
- ✅ Automatische Token-Rotation möglich
- ✅ Integration mit LDAP/OpenID möglich

## Übersicht

Das MinIO Console Backend (Go) kommuniziert mit zwei MinIO Server APIs:

1. **MinIO Admin API** ([madmin-go](https://github.com/minio/madmin-go)) - Für administrative Operationen
2. **MinIO S3 API** ([minio-go](https://github.com/minio/minio-go)) - Für Bucket- und Object-Operationen

### Quellen

- **MinIO Go Client SDK**: <https://github.com/minio/minio-go>
- **MinIO Admin Go Client**: <https://github.com/minio/madmin-go>
- **MinIO STS Documentation**: <https://min.io/docs/minio/linux/developers/security-token-service.html>

---

## Inhaltsverzeichnis

- [Authentifizierung & Client-Initialisierung](#authentifizierung--client-initialisierung)
- [1. User Management](#1-user-management-admin-api)
- [2. Group Management](#2-group-management-admin-api)
- [3. Policy Management](#3-policy-management-admin-api)
- [4. Service Accounts](#4-service-accounts-admin-api)
- [5. Configuration Management](#5-configuration-management-admin-api)
- [6. Bucket Management](#6-bucket-management-s3-api)
- [7. Bucket Encryption](#7-bucket-encryption-s3-api)
- [8. Bucket Replication](#8-bucket-replication-s3-api)
- [9. Bucket Retention & Locking](#9-bucket-retention--locking-s3-api)
- [10. Bucket Notifications](#10-bucket-notifications-s3-api)
- [11. Object Operations](#11-object-operations-s3-api)
- [12. Object Tags](#12-object-tags-s3-api)
- [13. Object Retention & Legal Hold](#13-object-retention--legal-hold-s3-api)
- [14. Presigned URLs](#14-presigned-urls-s3-api)
- [15. System & Admin Info](#15-system--admin-info-admin-api)
- [16. Profiling & Tracing](#16-profiling--tracing-admin-api)
- [17. Remote Buckets](#17-remote-buckets--replication-admin-api)
- [18. KMS (Key Management Service)](#18-kms-key-management-service-admin-api)
- [19. IDP (Identity Provider)](#19-idp-identity-provider-admin-api)
- [20. Site Replication](#20-site-replication-admin-api)
- [21. Tiers](#21-tiers-admin-api)
- [22. Speedtest](#22-speedtest-admin-api)
- [23. Healing](#23-healing-admin-api)

---

## Authentifizierung & Client-Initialisierung

### Authentifizierungs-Flow

MinIO unterstützt mehrere Authentifizierungsmethoden:

1. **Username/Password → STS Token** (empfohlen für Web-Clients)
2. **Access Key/Secret Key** (für CLI und direkte API-Zugriffe)
3. **LDAP** (für Enterprise-Umgebungen)
4. **OpenID Connect / OAuth2** (für SSO-Integration)

### 1. STS AssumeRole (Username/Password → Token)

**Dies ist die empfohlene Methode für eigene Admin Consoles!**

Der Client sendet **keine Access Keys**, sondern **Username und Password** an den MinIO STS Endpoint. Dieser gibt temporäre Credentials (Access Key, Secret Key, Session Token) zurück.

**API Endpoint:** `POST https://minio-server:9000/?Action=AssumeRole`

**Quelle:** [api/client.go:328-345](api/client.go#L328-L345), [api/user_login.go:86-100](api/user_login.go#L86-L100)

```go
import "github.com/minio/minio-go/v7/pkg/credentials"

// STS AssumeRole mit Username/Password
func GetSTSCredentials(minioURL, username, password string) (*credentials.Credentials, error) {
    opts := credentials.STSAssumeRoleOptions{
        AccessKey:       username,
        SecretKey:       password,
        Location:        "us-east-1",  // Region
        DurationSeconds: 3600,         // Token gültig für 1 Stunde
    }

    stsAssumeRole := &credentials.STSAssumeRole{
        Client:      http.DefaultClient,
        STSEndpoint: minioURL,  // z.B. "https://minio-server:9000"
        Options:     opts,
    }

    return credentials.New(stsAssumeRole), nil
}
```

**HTTP Request (direkter Call):**

```http
POST /?Action=AssumeRole HTTP/1.1
Host: minio-server:9000
Content-Type: application/x-www-form-urlencoded

Action=AssumeRole
&Version=2011-06-15
&DurationSeconds=3600
&Policy=<optional-policy-json>
```

**HTTP Headers für Authorization:**

```http
Authorization: AWS4-HMAC-SHA256 Credential=username/20231201/us-east-1/sts/aws4_request, SignedHeaders=host;x-amz-date, Signature=...
X-Amz-Date: 20231201T120000Z
```

**Response:**

```xml
<AssumeRoleResponse>
  <AssumeRoleResult>
    <Credentials>
      <AccessKeyId>AKIAIOSFODNN7EXAMPLE</AccessKeyId>
      <SecretAccessKey>wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY</SecretAccessKey>
      <SessionToken>FQoGZXIvYXdzEBEaD...</SessionToken>
      <Expiration>2023-12-01T13:00:00Z</Expiration>
    </Credentials>
  </AssumeRoleResult>
</AssumeRoleResponse>
```

**Verwendung der STS Credentials:**

```go
// 1. STS Credentials abrufen
stsCreds, err := GetSTSCredentials("https://minio:9000", "myusername", "mypassword")
if err != nil {
    log.Fatal(err)
}

// 2. Admin Client mit STS Credentials erstellen
adminClient, err := madmin.NewWithOptions("minio:9000", &madmin.Options{
    Creds:  stsCreds,
    Secure: true,
})

// 3. S3 Client mit STS Credentials erstellen
s3Client, err := minio.New("minio:9000", &minio.Options{
    Creds:  stsCreds,
    Secure: true,
    Region: "us-east-1",
})

// 4. Credentials abrufen (für Debug oder Session-Management)
value, err := stsCreds.Get()
if err != nil {
    log.Fatal(err)
}
fmt.Printf("AccessKey: %s\n", value.AccessKeyID)
fmt.Printf("SecretKey: %s\n", value.SecretAccessKey)
fmt.Printf("SessionToken: %s\n", value.SessionToken)
```

### 2. LDAP Authentication (Username/Password → LDAP Token)

**Quelle:** [api/client.go:350-386](api/client.go#L350-L386)

```go
import "github.com/minio/console/pkg/auth"

// LDAP Credentials
func GetLDAPCredentials(minioURL, username, password string) (*credentials.Credentials, error) {
    creds, err := auth.GetCredentialsFromLDAP(
        http.DefaultClient,
        minioURL,
        username,
        password,
    )
    if err != nil {
        return nil, err
    }

    return creds, nil
}
```

**Fallback-Logik (LDAP → STS):**

Das Console Backend versucht zuerst LDAP, falls das fehlschlägt, wird automatisch STS verwendet:

```go
func NewConsoleCredentials(accessKey, secretKey, location string, client *http.Client) (*credentials.Credentials, error) {
    minioURL := getMinIOServer()

    // 1. Versuche LDAP
    if ldap.GetLDAPEnabled() {
        ldapCreds, err := auth.GetCredentialsFromLDAP(client, minioURL, accessKey, secretKey)
        if err != nil {
            return nil, err
        }

        // Teste LDAP Credentials
        _, err = ldapCreds.Get()
        if err != nil && strings.Contains(strings.ToLower(err.Error()), "not found") {
            // 2. Fallback zu STS
            stsCreds, errSTS := stsCredentials(minioURL, accessKey, secretKey, location, client)
            if errSTS != nil {
                return ldapCreds, nil  // Rückgabe LDAP Error
            }
            return stsCreds, nil
        }
        return ldapCreds, nil
    }

    // 3. Standard: STS
    return stsCredentials(minioURL, accessKey, secretKey, location, client)
}
```

### 3. Admin Client erstellen

```go
// Quelle: api/client-admin.go
import "github.com/minio/madmin-go/v3"

// Mit STS Credentials (empfohlen)
adminClient, err := madmin.NewWithOptions(endpoint, &madmin.Options{
    Creds:  stsCreds,
    Secure: true,
})

// Mit Static Credentials (für Service Accounts)
adminClient, err := madmin.NewWithOptions(endpoint, &madmin.Options{
    Creds:  credentials.NewStaticV4(accessKey, secretKey, sessionToken),
    Secure: true,
})
```

### 4. S3 Client erstellen

```go
// Quelle: api/client.go
import "github.com/minio/minio-go/v7"

// Mit STS Credentials (empfohlen)
s3Client, err := minio.New(endpoint, &minio.Options{
    Creds:  stsCreds,
    Secure: true,
    Region: region,
})

// Mit Static Credentials (für Service Accounts)
s3Client, err := minio.New(endpoint, &minio.Options{
    Creds:  credentials.NewStaticV4(accessKey, secretKey, sessionToken),
    Secure: true,
    Region: region,
})
```

### 5. Session Management

**JWT Token für Web-Clients:**

Nach erfolgreicher STS-Authentifizierung erstellt das Console Backend einen verschlüsselten JWT Token:

**Quelle:** [api/user_login.go:86-100](api/user_login.go#L86-L100)

```go
import "github.com/minio/console/pkg/auth"

// Login-Flow
func login(credentials ConsoleCredentialsI, sessionFeatures *auth.SessionFeatures) (*string, error) {
    // 1. STS Credentials abrufen
    tokens, err := credentials.Get()
    if err != nil {
        return nil, err
    }

    // 2. JWT Token mit STS Credentials erstellen
    token, err := auth.NewEncryptedTokenForClient(
        &tokens,
        credentials.GetAccountAccessKey(),
        sessionFeatures,
    )
    if err != nil {
        return nil, err
    }

    return &token, nil
}
```

**Session Cookie:**

```go
// Cookie mit JWT Token setzen
cookie := http.Cookie{
    Name:     "token",
    Value:    jwtToken,
    Path:     "/",
    HttpOnly: true,
    Secure:   true,
    SameSite: http.SameSiteLaxMode,
    MaxAge:   3600,  // 1 Stunde
}
http.SetCookie(w, &cookie)
```

### 6. Credentials aus Session Claims abrufen

**Quelle:** [api/client.go:393-399](api/client.go#L393-L399)

```go
// JWT Token → Credentials
func getConsoleCredentialsFromSession(claims *models.Principal) *credentials.Credentials {
    if claims == nil {
        return credentials.NewStaticV4("", "", "")
    }
    return credentials.NewStaticV4(
        claims.STSAccessKeyID,
        claims.STSSecretAccessKey,
        claims.STSSessionToken,
    )
}
```

---

## 1. USER MANAGEMENT (Admin API)

### 1.1 List Users

**API Call:** `madmin.ListUsers(ctx)`
**Quelle:** [api/client-admin.go:142-144](api/client-admin.go#L142-L144)

```go
userMap, err := adminClient.ListUsers(ctx)
// Returns: map[string]madmin.UserInfo
// UserInfo: {
//     Status: madmin.AccountStatus  // "enabled" | "disabled"
//     PolicyName: string
//     MemberOf: []string  // Groups
// }
```

**Verwendung im Console Backend:** [api/admin_users.go:128-149](api/admin_users.go#L128-L149)

### 1.2 Add User

**API Call:** `madmin.AddUser(ctx, accessKey, secretKey)`
**Quelle:** [api/client-admin.go:147-149](api/client-admin.go#L147-L149)

```go
err := adminClient.AddUser(ctx, accessKey, secretKey)
```

**Verwendung im Console Backend:** [api/admin_users.go:174-178](api/admin_users.go#L174-L178)

### 1.3 Remove User

**API Call:** `madmin.RemoveUser(ctx, accessKey)`
**Quelle:** [api/client-admin.go:152-154](api/client-admin.go#L152-L154)

```go
err := adminClient.RemoveUser(ctx, accessKey)
```

### 1.4 Get User Info

**API Call:** `madmin.GetUserInfo(ctx, accessKey)`
**Quelle:** [api/client-admin.go:157-159](api/client-admin.go#L157-L159)

```go
userInfo, err := adminClient.GetUserInfo(ctx, accessKey)
// Returns: madmin.UserInfo
```

### 1.5 Set User Status

**API Call:** `madmin.SetUserStatus(ctx, accessKey, status)`
**Quelle:** [api/client-admin.go:162-164](api/client-admin.go#L162-L164)

```go
// status: madmin.AccountEnabled | madmin.AccountDisabled
err := adminClient.SetUserStatus(ctx, accessKey, madmin.AccountEnabled)
```

### 1.6 Change Password

**API Call:** `madmin.SetUser(ctx, accessKey, secretKey, status)`
**Quelle:** [api/client-admin.go:137-139](api/client-admin.go#L137-L139)

```go
err := adminClient.SetUser(ctx, accessKey, newSecretKey, madmin.AccountEnabled)
```

---

## 2. GROUP MANAGEMENT (Admin API)

### 2.1 List Groups

**API Call:** `madmin.ListGroups(ctx)`
**Quelle:** [api/client-admin.go:167-169](api/client-admin.go#L167-L169)

```go
groups, err := adminClient.ListGroups(ctx)
// Returns: []string (group names)
```

**Verwendung im Console Backend:** [api/admin_groups.go:84](api/admin_groups.go#L84)

### 2.2 Get Group Description

**API Call:** `madmin.GetGroupDescription(ctx, group)`
**Quelle:** [api/client-admin.go:177-179](api/client-admin.go#L177-L179)

```go
groupDesc, err := adminClient.GetGroupDescription(ctx, groupName)
// Returns: *madmin.GroupDesc {
//     Name: string
//     Status: string  // "enabled" | "disabled"
//     Members: []string
//     Policy: string
// }
```

**Verwendung im Console Backend:** [api/admin_groups.go:99-105](api/admin_groups.go#L99-L105)

### 2.3 Update Group Members (Add/Remove)

**API Call:** `madmin.UpdateGroupMembers(ctx, groupAddRemove)`
**Quelle:** [api/client-admin.go:172-174](api/client-admin.go#L172-L174)

```go
// Add members to group
req := madmin.GroupAddRemove{
    Group:    "mygroup",
    Members:  []string{"user1", "user2"},
    IsRemove: false,  // false = add, true = remove
}
err := adminClient.UpdateGroupMembers(ctx, req)
```

**Verwendung im Console Backend:** [api/admin_groups.go:135-146](api/admin_groups.go#L135-L146)

### 2.4 Set Group Status

**API Call:** `madmin.SetGroupStatus(ctx, group, status)`
**Quelle:** [api/client-admin.go:182-184](api/client-admin.go#L182-L184)

```go
// status: madmin.GroupEnabled | madmin.GroupDisabled
err := adminClient.SetGroupStatus(ctx, groupName, madmin.GroupEnabled)
```

---

## 3. POLICY MANAGEMENT (Admin API)

### 3.1 List Policies

**API Call:** `madmin.ListCannedPolicies(ctx)`
**Quelle:** [api/client-admin.go:187-201](api/client-admin.go#L187-L201)

```go
policyMap, err := adminClient.ListCannedPolicies(ctx)
// Returns: map[string][]byte (policyName -> policyJSON)

// Parse policy JSON
import iampolicy "github.com/minio/pkg/v3/policy"
policy, err := iampolicy.ParseConfig(bytes.NewReader(policyJSON))
```

### 3.2 Get Policy Info

**API Call:** `madmin.InfoCannedPolicyV2(ctx, name)`
**Quelle:** [api/client-admin.go:204-210](api/client-admin.go#L204-L210)

```go
info, err := adminClient.InfoCannedPolicyV2(ctx, policyName)
// Returns: madmin.PolicyInfo {
//     PolicyName: string
//     Policy: []byte  // JSON policy document
// }
```

### 3.3 Add Policy

**API Call:** `madmin.AddCannedPolicy(ctx, name, policy)`
**Quelle:** [api/client-admin.go:218-224](api/client-admin.go#L218-L224)

```go
policyJSON, err := json.Marshal(policyObject)
err = adminClient.AddCannedPolicy(ctx, policyName, policyJSON)
```

### 3.4 Remove Policy

**API Call:** `madmin.RemoveCannedPolicy(ctx, name)`
**Quelle:** [api/client-admin.go:213-215](api/client-admin.go#L213-L215)

```go
err := adminClient.RemoveCannedPolicy(ctx, policyName)
```

### 3.5 Set Policy for User/Group

**API Call:** `madmin.SetPolicy(ctx, policyName, entityName, isGroup)`
**Quelle:** [api/client-admin.go:227-230](api/client-admin.go#L227-L230)

```go
// Assign policy to user
err := adminClient.SetPolicy(ctx, "readwrite", "user1", false)

// Assign policy to group
err := adminClient.SetPolicy(ctx, "readwrite", "group1", true)
```

---

## 4. SERVICE ACCOUNTS (Admin API)

### 4.1 Add Service Account

**API Call:** `madmin.AddServiceAccount(ctx, req)`
**Quelle:** [api/client-admin.go:295-306](api/client-admin.go#L295-L306)

```go
req := madmin.AddServiceAccountReq{
    Policy:      []byte(policyJSON),  // Optional inline policy
    TargetUser:  "parentUser",
    AccessKey:   "customAccessKey",   // Optional
    SecretKey:   "customSecretKey",   // Optional
    Name:        "My SA",
    Description: "Service Account for App",
    Expiration:  &expiryTime,         // Optional *time.Time
    Comment:     "Created by admin",
}
creds, err := adminClient.AddServiceAccount(ctx, req)
// Returns: madmin.Credentials {
//     AccessKey: string
//     SecretKey: string
//     Expiration: time.Time
//     Status: string
// }
```

### 4.2 List Service Accounts

**API Call:** `madmin.ListServiceAccounts(ctx, user)`
**Quelle:** [api/client-admin.go:309-311](api/client-admin.go#L309-L311)

```go
resp, err := adminClient.ListServiceAccounts(ctx, "user1")
// Returns: madmin.ListServiceAccountsResp {
//     Accounts: []string  // Service account access keys
// }
```

### 4.3 Get Service Account Info

**API Call:** `madmin.InfoServiceAccount(ctx, accessKey)`
**Quelle:** [api/client-admin.go:318-320](api/client-admin.go#L318-L320)

```go
info, err := adminClient.InfoServiceAccount(ctx, saAccessKey)
// Returns: madmin.InfoServiceAccountResp {
//     ParentUser: string
//     AccountStatus: string
//     ImpliedPolicy: bool
//     Policy: string  // JSON policy
//     Name: string
//     Description: string
//     Expiration: *time.Time
// }
```

### 4.4 Update Service Account

**API Call:** `madmin.UpdateServiceAccount(ctx, accessKey, opts)`
**Quelle:** [api/client-admin.go:323-325](api/client-admin.go#L323-L325)

```go
opts := madmin.UpdateServiceAccountReq{
    NewPolicy:      []byte(newPolicyJSON),  // Optional
    NewSecretKey:   "newSecret",            // Optional
    NewStatus:      "on",                   // "on" | "off"
    NewName:        "Updated Name",
    NewDescription: "Updated Description",
    NewExpiration:  &newExpiryTime,
}
err := adminClient.UpdateServiceAccount(ctx, saAccessKey, opts)
```

### 4.5 Delete Service Account

**API Call:** `madmin.DeleteServiceAccount(ctx, accessKey)`
**Quelle:** [api/client-admin.go:314-316](api/client-admin.go#L314-L316)

```go
err := adminClient.DeleteServiceAccount(ctx, saAccessKey)
```

---

## 5. CONFIGURATION MANAGEMENT (Admin API)

### 5.1 List Config Keys

**API Call:** `madmin.HelpConfigKV(ctx, subSys, key, envOnly)`
**Quelle:** [api/client-admin.go:238-240](api/client-admin.go#L238-L240)

```go
// List all config subsystems
help, err := adminClient.HelpConfigKV(ctx, "", "", false)
// Returns: madmin.Help {
//     SubSys: string
//     Description: string
//     MultipleTargets: bool
//     KeysHelp: []madmin.HelpKV
// }

// Get help for specific subsystem
help, err := adminClient.HelpConfigKV(ctx, "notify_webhook", "", false)
```

### 5.2 Get Config

**API Call:** `madmin.GetConfigKV(ctx, key)`
**Quelle:** [api/client-admin.go:233-235](api/client-admin.go#L233-L235)

```go
config, err := adminClient.GetConfigKV(ctx, "notify_webhook:primary")
// Returns: []byte (config in key=value format)
```

### 5.3 Set Config

**API Call:** `madmin.SetConfigKV(ctx, kv)`
**Quelle:** [api/client-admin.go:248-250](api/client-admin.go#L248-L250)

```go
// Format: "subsystem:target key1=value1 key2=value2"
kv := "notify_webhook:primary endpoint=https://example.com/hook queue_limit=1000"
restart, err := adminClient.SetConfigKV(ctx, kv)
// restart: bool - indicates if server restart is required
```

### 5.4 Delete Config

**API Call:** `madmin.DelConfigKV(ctx, kv)`
**Quelle:** [api/client-admin.go:253-256](api/client-admin.go#L253-L256)

```go
restart, err := adminClient.DelConfigKV(ctx, "notify_webhook:primary")
// Returns: restart bool
```

### 5.5 Export Config

**API Call:** `madmin.GetConfig(ctx)`

```go
configBytes, err := adminClient.GetConfig(ctx)
// Returns: []byte (full config export)
```

### 5.6 Import Config

**API Call:** `madmin.SetConfig(ctx, config)`

```go
err := adminClient.SetConfig(ctx, configBytes)
```

---

## 6. BUCKET MANAGEMENT (S3 API)

### 6.1 List Buckets

**API Call:** `minio.ListBuckets(ctx)`
**Quelle:** [api/client.go:103-105](api/client.go#L103-L105)

```go
buckets, err := s3Client.ListBuckets(ctx)
// Returns: []minio.BucketInfo {
//     Name: string
//     CreationDate: time.Time
// }
```

### 6.2 Get Account Info (Buckets with stats)

**API Call:** `madmin.AccountInfo(ctx)`

```go
accountInfo, err := adminClient.AccountInfo(ctx)
// Returns: madmin.AccountInfo {
//     AccountName: string
//     Buckets: []madmin.BucketAccessInfo {
//         Name: string
//         Created: time.Time
//         Size: uint64
//         Objects: uint64
//         Details: *madmin.BucketDetails {
//             Versioning: bool
//             VersioningSuspended: bool
//             Replication: bool
//             Locking: bool
//             Quota: *madmin.BucketQuota
//         }
//     }
// }
```

### 6.3 Make Bucket

**API Call:** `minio.MakeBucket(ctx, bucketName, opts)`
**Quelle:** [api/client.go:108-113](api/client.go#L108-L113)

```go
opts := minio.MakeBucketOptions{
    Region:        "us-east-1",
    ObjectLocking: true,  // Enable object locking
}
err := s3Client.MakeBucket(ctx, "mybucket", opts)
```

### 6.4 Delete Bucket

**API Call:** `minio.RemoveBucket(ctx, bucketName)`
**Quelle:** [api/client.go:121-123](api/client.go#L121-L123)

```go
err := s3Client.RemoveBucket(ctx, "mybucket")
```

### 6.5 Get Bucket Policy

**API Call:** `minio.GetBucketPolicy(ctx, bucketName)`
**Quelle:** [api/client.go:131-133](api/client.go#L131-L133)

```go
policyJSON, err := s3Client.GetBucketPolicy(ctx, "mybucket")
// Returns: string (JSON policy document)
```

### 6.6 Set Bucket Policy

**API Call:** `minio.SetBucketPolicy(ctx, bucketName, policy)`
**Quelle:** [api/client.go:116-118](api/client.go#L116-L118)

```go
// policyJSON: JSON string representation of bucket policy
err := s3Client.SetBucketPolicy(ctx, "mybucket", policyJSON)
```

### 6.7 Get Bucket Versioning

**API Call:** `minio.GetBucketVersioning(ctx, bucketName)`
**Quelle:** [api/client.go:136-138](api/client.go#L136-L138)

```go
config, err := s3Client.GetBucketVersioning(ctx, "mybucket")
// Returns: minio.BucketVersioningConfiguration {
//     Status: string  // "Enabled" | "Suspended"
//     MFADelete: string
//     ExcludeFolders: bool
//     ExcludedPrefixes: []minio.ExcludedPrefix
// }
```

### 6.8 Set Bucket Versioning

**API Call:** `minio.SetBucketVersioning(ctx, bucketName, config)`

```go
config := minio.BucketVersioningConfiguration{
    Status: "Enabled",
}
err := s3Client.SetBucketVersioning(ctx, "mybucket", config)
```

### 6.9 Get Bucket Tags

**API Call:** `minio.GetBucketTagging(ctx, bucketName)`
**Quelle:** [api/client.go:90-92](api/client.go#L90-L92)

```go
tags, err := s3Client.GetBucketTagging(ctx, "mybucket")
// Returns: *tags.Tags
// tags.ToMap(): map[string]string
```

### 6.10 Set Bucket Tags

**API Call:** `minio.SetBucketTagging(ctx, bucketName, tags)`
**Quelle:** [api/client.go:94-96](api/client.go#L94-L96)

```go
import "github.com/minio/minio-go/v7/pkg/tags"

tags, err := tags.NewTags(map[string]string{
    "Environment": "Production",
    "Department": "Engineering",
}, true)
err = s3Client.SetBucketTagging(ctx, "mybucket", tags)
```

### 6.11 Remove Bucket Tags

**API Call:** `minio.RemoveBucketTagging(ctx, bucketName)`
**Quelle:** [api/client.go:98-100](api/client.go#L98-L100)

```go
err := s3Client.RemoveBucketTagging(ctx, "mybucket")
```

---

## 7. BUCKET ENCRYPTION (S3 API)

### 7.1 Enable Bucket Encryption

**API Call:** `minio.SetBucketEncryption(ctx, bucketName, config)`
**Quelle:** [api/client.go:175-177](api/client.go#L175-L177)

```go
import "github.com/minio/minio-go/v7/pkg/sse"

// SSE-S3 Encryption
config := sse.NewConfigurationSSES3()
err := s3Client.SetBucketEncryption(ctx, "mybucket", config)

// SSE-KMS Encryption
config := sse.NewConfigurationSSEKMS("my-kms-key-id")
err := s3Client.SetBucketEncryption(ctx, "mybucket", config)
```

### 7.2 Get Bucket Encryption

**API Call:** `minio.GetBucketEncryption(ctx, bucketName)`
**Quelle:** [api/client.go:185-187](api/client.go#L185-L187)

```go
config, err := s3Client.GetBucketEncryption(ctx, "mybucket")
// Returns: *sse.Configuration {
//     Rules: []sse.Rule {
//         ApplySSEByDefault: sse.ApplySSEByDefault {
//             SSEAlgorithm: string  // "AES256" | "aws:kms"
//             KMSMasterKeyID: string
//         }
//     }
// }
```

### 7.3 Remove Bucket Encryption

**API Call:** `minio.RemoveBucketEncryption(ctx, bucketName)`
**Quelle:** [api/client.go:180-182](api/client.go#L180-L182)

```go
err := s3Client.RemoveBucketEncryption(ctx, "mybucket")
```

---

## 8. BUCKET REPLICATION (S3 API)

### 8.1 Get Bucket Replication

**API Call:** `minio.GetBucketReplication(ctx, bucketName)`
**Quelle:** [api/client.go:141-143](api/client.go#L141-L143)

```go
import "github.com/minio/minio-go/v7/pkg/replication"

config, err := s3Client.GetBucketReplication(ctx, "mybucket")
// Returns: replication.Config {
//     Role: string
//     Rules: []replication.Rule {
//         ID: string
//         Status: string  // "Enabled" | "Disabled"
//         Priority: int
//         DeleteMarkerReplication: replication.DeleteMarkerReplication
//         Destination: replication.Destination {
//             Bucket: string
//             StorageClass: string
//         }
//         Filter: replication.Filter
//         ExistingObjectReplication: replication.ExistingObjectReplication
//     }
// }
```

### 8.2 Set Bucket Replication

**API Call:** `minio.SetBucketReplication(ctx, bucketName, config)`

```go
config := replication.Config{
    Role: "arn:aws:iam::ACCOUNT-ID:role/ROLE-NAME",
    Rules: []replication.Rule{
        {
            ID:       "rule-1",
            Status:   "Enabled",
            Priority: 1,
            Destination: replication.Destination{
                Bucket: "arn:aws:s3:::destination-bucket",
            },
        },
    },
}
err := s3Client.SetBucketReplication(ctx, "mybucket", config)
```

### 8.3 Remove Bucket Replication

**API Call:** `minio.RemoveBucketReplication(ctx, bucketName)`

```go
err := s3Client.RemoveBucketReplication(ctx, "mybucket")
```

---

## 9. BUCKET RETENTION & LOCKING (S3 API)

### 9.1 Get Object Lock Config

**API Call:** `minio.GetObjectLockConfig(ctx, bucketName)`

```go
lock, mode, validity, unit, err := s3Client.GetObjectLockConfig(ctx, "mybucket")
// Returns:
// lock: string - "Enabled" | "Disabled"
// mode: *minio.RetentionMode - GOVERNANCE | COMPLIANCE
// validity: *uint - retention duration
// unit: *minio.ValidityUnit - DAYS | YEARS
```

### 9.2 Set Object Lock Config

**API Call:** `minio.SetObjectLockConfig(ctx, bucketName, mode, validity, unit)`
**Quelle:** [api/client.go:197-199](api/client.go#L197-L199)

```go
mode := minio.Governance
validity := uint(30)
unit := minio.Days
err := s3Client.SetObjectLockConfig(ctx, "mybucket", &mode, &validity, &unit)
```

### 9.3 Get Bucket Object Lock Config

**API Call:** `minio.GetBucketObjectLockConfig(ctx, bucketName)`

```go
mode, validity, unit, err := s3Client.GetBucketObjectLockConfig(ctx, "mybucket")
```

---

## 10. BUCKET NOTIFICATIONS (S3 API)

### 10.1 Get Bucket Notification

**API Call:** `minio.GetBucketNotification(ctx, bucketName)`
**Quelle:** [api/client.go:126-128](api/client.go#L126-L128)

```go
import "github.com/minio/minio-go/v7/pkg/notification"

config, err := s3Client.GetBucketNotification(ctx, "mybucket")
// Returns: notification.Configuration {
//     QueueConfigs: []notification.Queue
//     TopicConfigs: []notification.Topic
//     LambdaConfigs: []notification.Lambda
// }
```

### 10.2 Set Bucket Notification

**API Call:** `minio.SetBucketNotification(ctx, bucketName, config)`

```go
config := notification.Configuration{
    QueueConfigs: []notification.Queue{
        {
            ID:    "1",
            Arn:   notification.NewArn("minio", "sqs", "", "", "primary"),
            Events: []notification.EventType{
                notification.ObjectCreatedAll,
            },
            Filter: notification.Filter{
                S3Key: notification.S3Key{
                    FilterRules: []notification.FilterRule{
                        {
                            Name:  "prefix",
                            Value: "images/",
                        },
                    },
                },
            },
        },
    },
}
err := s3Client.SetBucketNotification(ctx, "mybucket", config)
```

### 10.3 Remove All Bucket Notifications

**API Call:** `minio.RemoveAllBucketNotification(ctx, bucketName)`

```go
err := s3Client.RemoveAllBucketNotification(ctx, "mybucket")
```

---

## 11. OBJECT OPERATIONS (S3 API)

### 11.1 List Objects

**API Call:** `minio.ListObjects(ctx, bucket, opts)`
**Quelle:** [api/client.go:146-148](api/client.go#L146-L148)

```go
opts := minio.ListObjectsOptions{
    Prefix:       "folder/",
    Recursive:    true,
    WithVersions: false,
    WithMetadata: true,
    MaxKeys:      1000,
}

objectsCh := s3Client.ListObjects(ctx, "mybucket", opts)
for object := range objectsCh {
    if object.Err != nil {
        // Handle error
        continue
    }
    // object.Key, object.Size, object.LastModified, etc.
}
```

### 11.2 Stat Object (Get Object Metadata)

**API Call:** `minio.StatObject(ctx, bucketName, objectName, opts)`
**Quelle:** [api/client.go:170-172](api/client.go#L170-L172)

```go
opts := minio.GetObjectOptions{
    VersionID: "version-id",  // Optional
}
info, err := s3Client.StatObject(ctx, "mybucket", "file.txt", opts)
// Returns: minio.ObjectInfo {
//     Key: string
//     Size: int64
//     ETag: string
//     ContentType: string
//     LastModified: time.Time
//     UserMetadata: map[string]string
//     UserTags: map[string]string
//     VersionID: string
//     IsDeleteMarker: bool
//     Metadata: http.Header
// }
```

### 11.3 Get Object

**API Call:** `minio.GetObject(ctx, bucketName, objectName, opts)`

```go
opts := minio.GetObjectOptions{
    VersionID: "version-id",
}
object, err := s3Client.GetObject(ctx, "mybucket", "file.txt", opts)
defer object.Close()

// Read object data
data, err := io.ReadAll(object)
```

### 11.4 Put Object (Upload)

**API Call:** `minio.PutObject(ctx, bucketName, objectName, reader, size, opts)`
**Quelle:** [api/client.go:158-160](api/client.go#L158-L160)

```go
file, err := os.Open("local-file.txt")
defer file.Close()

stat, err := file.Stat()

opts := minio.PutObjectOptions{
    ContentType: "text/plain",
    UserMetadata: map[string]string{
        "x-amz-meta-custom": "value",
    },
    UserTags: map[string]string{
        "Tag1": "Value1",
    },
}

info, err := s3Client.PutObject(ctx, "mybucket", "file.txt", file, stat.Size(), opts)
// Returns: minio.UploadInfo {
//     Bucket: string
//     Key: string
//     ETag: string
//     Size: int64
//     VersionID: string
// }
```

### 11.5 Remove Object

**API Call:** `minio.RemoveObject(ctx, bucketName, objectName, opts)`

```go
opts := minio.RemoveObjectOptions{
    VersionID: "version-id",  // Optional
    GovernanceBypass: true,    // Bypass GOVERNANCE retention
}
err := s3Client.RemoveObject(ctx, "mybucket", "file.txt", opts)
```

### 11.6 Remove Objects (Multiple)

**API Call:** `minio.RemoveObjects(ctx, bucketName, objectsCh, opts)`

```go
objectsCh := make(chan minio.ObjectInfo)

go func() {
    defer close(objectsCh)
    objectsCh <- minio.ObjectInfo{Key: "file1.txt"}
    objectsCh <- minio.ObjectInfo{Key: "file2.txt"}
}()

opts := minio.RemoveObjectsOptions{
    GovernanceBypass: true,
}

errorCh := s3Client.RemoveObjects(ctx, "mybucket", objectsCh, opts)
for err := range errorCh {
    log.Printf("Error: %s", err.Err)
}
```

### 11.7 Copy Object

**API Call:** `minio.CopyObject(ctx, dst, src)`
**Quelle:** [api/client.go:76](api/client.go#L76)

```go
src := minio.CopySrcOptions{
    Bucket:    "source-bucket",
    Object:    "source-file.txt",
    VersionID: "version-id",  // Optional
}

dst := minio.CopyDestOptions{
    Bucket: "dest-bucket",
    Object: "dest-file.txt",
}

info, err := s3Client.CopyObject(ctx, dst, src)
```

---

## 12. OBJECT TAGS (S3 API)

### 12.1 Get Object Tags

**API Call:** `minio.GetObjectTagging(ctx, bucketName, objectName, opts)`
**Quelle:** [api/client.go:193-195](api/client.go#L193-L195)

```go
opts := minio.GetObjectTaggingOptions{
    VersionID: "version-id",
}
tags, err := s3Client.GetObjectTagging(ctx, "mybucket", "file.txt", opts)
// tags.ToMap(): map[string]string
```

### 12.2 Put Object Tags

**API Call:** `minio.PutObjectTagging(ctx, bucketName, objectName, tags, opts)`
**Quelle:** [api/client.go:189-191](api/client.go#L189-L191)

```go
tags, err := tags.NewTags(map[string]string{
    "Project": "Alpha",
    "Status": "Active",
}, true)

opts := minio.PutObjectTaggingOptions{
    VersionID: "version-id",
}

err = s3Client.PutObjectTagging(ctx, "mybucket", "file.txt", tags, opts)
```

### 12.3 Remove Object Tags

**API Call:** `minio.RemoveObjectTagging(ctx, bucketName, objectName, opts)`

```go
opts := minio.RemoveObjectTaggingOptions{
    VersionID: "version-id",
}
err := s3Client.RemoveObjectTagging(ctx, "mybucket", "file.txt", opts)
```

---

## 13. OBJECT RETENTION & LEGAL HOLD (S3 API)

### 13.1 Get Object Retention

**API Call:** `minio.GetObjectRetention(ctx, bucketName, objectName, versionID)`
**Quelle:** [api/client.go:150-152](api/client.go#L150-L152)

```go
mode, retainUntil, err := s3Client.GetObjectRetention(ctx, "mybucket", "file.txt", "version-id")
// mode: *minio.RetentionMode - GOVERNANCE | COMPLIANCE
// retainUntil: *time.Time
```

### 13.2 Put Object Retention

**API Call:** `minio.PutObjectRetention(ctx, bucketName, objectName, opts)`
**Quelle:** [api/client.go:166-168](api/client.go#L166-L168)

```go
retainUntil := time.Now().Add(30 * 24 * time.Hour)
opts := minio.PutObjectRetentionOptions{
    VersionID:        "version-id",
    Mode:             &minio.Governance,
    RetainUntilDate:  &retainUntil,
    GovernanceBypass: false,
}
err := s3Client.PutObjectRetention(ctx, "mybucket", "file.txt", opts)
```

### 13.3 Get Object Legal Hold

**API Call:** `minio.GetObjectLegalHold(ctx, bucketName, objectName, opts)`
**Quelle:** [api/client.go:154-156](api/client.go#L154-L156)

```go
opts := minio.GetObjectLegalHoldOptions{
    VersionID: "version-id",
}
status, err := s3Client.GetObjectLegalHold(ctx, "mybucket", "file.txt", opts)
// status: *minio.LegalHoldStatus - ON | OFF
```

### 13.4 Put Object Legal Hold

**API Call:** `minio.PutObjectLegalHold(ctx, bucketName, objectName, opts)`
**Quelle:** [api/client.go:162-164](api/client.go#L162-L164)

```go
status := minio.LegalHoldEnabled
opts := minio.PutObjectLegalHoldOptions{
    VersionID: "version-id",
    Status:    &status,
}
err := s3Client.PutObjectLegalHold(ctx, "mybucket", "file.txt", opts)
```

---

## 14. PRESIGNED URLs (S3 API)

### 14.1 Presigned Get Object

**API Call:** `minio.PresignedGetObject(ctx, bucketName, objectName, expires, params)`

```go
import "net/url"

expires := 7 * 24 * time.Hour  // 7 days

params := url.Values{}
params.Set("response-content-type", "application/json")

url, err := s3Client.PresignedGetObject(ctx, "mybucket", "file.txt", expires, params)
// Returns: *url.URL
```

### 14.2 Presigned Put Object

**API Call:** `minio.PresignedPutObject(ctx, bucketName, objectName, expires)`

```go
expires := 1 * time.Hour
url, err := s3Client.PresignedPutObject(ctx, "mybucket", "file.txt", expires)
// Returns: *url.URL for upload
```

### 14.3 Presigned Post Policy

**API Call:** `minio.PresignedPostPolicy(ctx, policy)`

```go
policy := minio.NewPostPolicy()
policy.SetBucket("mybucket")
policy.SetKey("file.txt")
policy.SetExpires(time.Now().Add(24 * time.Hour))
policy.SetContentLengthRange(1024, 10*1024*1024)  // 1KB - 10MB

url, formData, err := s3Client.PresignedPostPolicy(ctx, policy)
// Returns: url (string), formData (map[string]string)
```

---

## 15. SYSTEM & ADMIN INFO (Admin API)

### 15.1 Server Info

**API Call:** `madmin.ServerInfo(ctx)`
**Quelle:** [api/client-admin.go:264-266](api/client-admin.go#L264-L266)

```go
info, err := adminClient.ServerInfo(ctx)
// Returns: madmin.InfoMessage {
//     Mode: string  // "fs" | "erasure"
//     Region: string
//     Sqinfo: []madmin.ServerProperties {
//         State: string
//         Endpoint: string
//         Uptime: int64
//         Version: string
//         CommitID: string
//         Network: map[string]string
//         Drives: []madmin.Disk {
//             Endpoint: string
//             State: string
//             UUID: string
//             Model: string
//             TotalSpace: uint64
//             UsedSpace: uint64
//         }
//     }
// }
```

### 15.2 Account Info

**API Call:** `madmin.AccountInfo(ctx)`

```go
info, err := adminClient.AccountInfo(ctx)
// See section 6.2 for full structure
```

### 15.3 Service Restart

**API Call:** `madmin.ServiceRestartV2(ctx)`
**Quelle:** [api/client-admin.go:259-261](api/client-admin.go#L259-L261)

```go
err := adminClient.ServiceRestartV2(ctx)
```

### 15.4 Server Health Info

**API Call:** `madmin.ServerHealthInfo(ctx, types, deadline, "")`

```go
healthDataTypes := []madmin.HealthDataType{
    madmin.HealthDataTypePerfDrive,
    madmin.HealthDataTypePerfNet,
    madmin.HealthDataTypeMinioInfo,
    madmin.HealthDataTypeSysCPU,
    madmin.HealthDataTypeSysDriveHw,
    madmin.HealthDataTypeSysMem,
    madmin.HealthDataTypeSysNet,
}

deadline := 10 * time.Second
healthInfo, err := adminClient.ServerHealthInfo(ctx, healthDataTypes, deadline, "")
```

---

## 16. PROFILING & TRACING (Admin API)

### 16.1 Start Profiling

**API Call:** `madmin.Profile(ctx, profilerType, duration)`
**Quelle:** [api/client-admin.go:269-271](api/client-admin.go#L269-L271)

```go
// Profiler types: CPU, MEM, BLOCK, MUTEX, GOROUTINE, TRACE
profiler := madmin.ProfilerCPU
duration := 30 * time.Second

reader, err := adminClient.Profile(ctx, profiler, duration)
defer reader.Close()

// Save profile data
data, err := io.ReadAll(reader)
os.WriteFile("profile.pprof", data, 0644)
```

### 16.2 Service Trace

**API Call:** `madmin.ServiceTrace(ctx, opts)`
**Quelle:** [api/client-admin.go:274-287](api/client-admin.go#L274-L287)

```go
opts := madmin.ServiceTraceOpts{
    S3:         true,      // Trace S3 API calls
    OnlyErrors: false,     // Include all calls or only errors
    Internal:   true,      // Include internal API calls
    Storage:    true,      // Include storage API calls
    OS:         true,      // Include OS calls
    Threshold:  100 * time.Millisecond,  // Only trace calls > threshold
}

traceCh := adminClient.ServiceTrace(ctx, opts)
for trace := range traceCh {
    fmt.Printf("[%s] %s %s - %d\n",
        trace.Time, trace.FuncName, trace.Path, trace.HTTP.RespInfo.StatusCode)
}
```

### 16.3 Get Logs

**API Call:** `madmin.GetLogs(ctx, node, lineCnt, logKind)`
**Quelle:** [api/client-admin.go:290-292](api/client-admin.go#L290-L292)

```go
// node: "" for all nodes or specific node name
// logKind: "minio" | "application" | "all"
logsCh := adminClient.GetLogs(ctx, "", 100, "all")
for logInfo := range logsCh {
    if logInfo.Err != nil {
        log.Printf("Error: %s", logInfo.Err)
        continue
    }
    fmt.Printf("[%s] %s: %s\n", logInfo.Time, logInfo.NodeName, logInfo.Msg)
}
```

---

## 17. REMOTE BUCKETS & REPLICATION (Admin API)

### 17.1 List Remote Buckets

**API Call:** `madmin.ListRemoteTargets(ctx, bucketName, arnType)`

```go
// arnType: "" for all, or specific type like "replication"
targets, err := adminClient.ListRemoteTargets(ctx, "mybucket", "")
// Returns: []madmin.BucketTarget {
//     SourceBucket: string
//     Endpoint: string
//     Credentials: *madmin.Credentials
//     TargetBucket: string
//     Secure: bool
//     API: string
//     Arn: string
//     Type: madmin.ServiceType
//     Region: string
//     BandwidthLimit: int64
// }
```

### 17.2 Get Remote Bucket

**API Call:** `madmin.GetRemoteTarget(ctx, bucketName, arn)`

```go
target, err := adminClient.GetRemoteTarget(ctx, "mybucket", "arn:minio:replication::...")
```

### 17.3 Add Remote Bucket

**API Call:** `madmin.SetRemoteTarget(ctx, bucketName, target)`

```go
target := &madmin.BucketTarget{
    SourceBucket: "mybucket",
    Endpoint:     "https://remote-minio:9000",
    Credentials: &madmin.Credentials{
        AccessKey: "remoteAccessKey",
        SecretKey: "remoteSecretKey",
    },
    TargetBucket:   "remote-bucket",
    Secure:         true,
    API:            "s3v4",
    Type:           madmin.ReplicationService,
    Region:         "us-west-1",
    BandwidthLimit: 100 * 1024 * 1024,  // 100 MB/s
}

arn, err := adminClient.SetRemoteTarget(ctx, "mybucket", target)
// Returns: string (ARN of the remote target)
```

### 17.4 Remove Remote Bucket

**API Call:** `madmin.RemoveRemoteTarget(ctx, bucketName, arn)`

```go
err := adminClient.RemoveRemoteTarget(ctx, "mybucket", "arn:minio:replication::...")
```

---

## 18. KMS (Key Management Service) (Admin API)

### 18.1 KMS Status

**API Call:** `madmin.KMSStatus(ctx)`

```go
status, err := adminClient.KMSStatus(ctx)
// Returns: madmin.KMSStatus {
//     Name: string
//     DefaultKeyID: string
//     Endpoints: []string
// }
```

### 18.2 KMS Metrics

**API Call:** `madmin.KMSMetrics(ctx)`

```go
metrics, err := adminClient.KMSMetrics(ctx)
// Returns: *madmin.KMSMetrics
```

### 18.3 KMS APIs

**API Call:** `madmin.KMSAPIs(ctx)`

```go
apis, err := adminClient.KMSAPIs(ctx)
// Returns: []madmin.KMSAPI
```

### 18.4 KMS Version

**API Call:** `madmin.KMSVersion(ctx)`

```go
version, err := adminClient.KMSVersion(ctx)
// Returns: *madmin.KMSVersion {
//     Version: string
// }
```

### 18.5 Create KMS Key

**API Call:** `madmin.CreateKey(ctx, keyID)`

```go
err := adminClient.CreateKey(ctx, "my-encryption-key")
```

### 18.6 List KMS Keys

**API Call:** `madmin.ListKeys(ctx, pattern)`

```go
keys, err := adminClient.ListKeys(ctx, "*")
// Returns: []madmin.KMSKeyInfo {
//     CreatedAt: string
//     CreatedBy: string
//     Name: string
// }
```

### 18.7 Key Status

**API Call:** `madmin.KeyStatus(ctx, keyID)`

```go
status, err := adminClient.KeyStatus(ctx, "my-encryption-key")
// Returns: *madmin.KMSKeyStatus {
//     KeyID: string
//     EncryptionErr: string
//     DecryptionErr: string
// }
```

---

## 19. IDP (Identity Provider) (Admin API)

### 19.1 List IDP Configurations

**API Call:** `madmin.ListIDPConfig(ctx, idpType)`

```go
// idpType: "openid" | "ldap"
configs, err := adminClient.ListIDPConfig(ctx, "openid")
// Returns: []madmin.IDPListItem {
//     Type: string
//     Name: string
//     Enabled: bool
//     RoleARN: string
// }
```

### 19.2 Get IDP Configuration

**API Call:** `madmin.GetIDPConfig(ctx, idpType, cfgName)`

```go
config, err := adminClient.GetIDPConfig(ctx, "openid", "my-idp")
// Returns: madmin.IDPConfig {
//     Type: string
//     Name: string
//     Info: map[string]interface{}
// }
```

### 19.3 Add/Update IDP Configuration

**API Call:** `madmin.AddOrUpdateIDPConfig(ctx, idpType, cfgName, cfgData, update)`

```go
cfgData := `client_id=myclient client_secret=mysecret config_url=https://idp.example.com/.well-known/openid-configuration`
restart, err := adminClient.AddOrUpdateIDPConfig(ctx, "openid", "my-idp", cfgData, false)
// restart: bool - indicates if restart required
```

### 19.4 Delete IDP Configuration

**API Call:** `madmin.DeleteIDPConfig(ctx, idpType, cfgName)`

```go
restart, err := adminClient.DeleteIDPConfig(ctx, "openid", "my-idp")
```

### 19.5 Get LDAP Policy Entities

**API Call:** `madmin.GetLDAPPolicyEntities(ctx, query)`

```go
query := madmin.PolicyEntitiesQuery{
    Users:  []string{"cn=user1,ou=users,dc=example,dc=com"},
    Groups: []string{"cn=admins,ou=groups,dc=example,dc=com"},
    Policy: []string{"readwrite"},
}

result, err := adminClient.GetLDAPPolicyEntities(ctx, query)
// Returns: madmin.PolicyEntitiesResult
```

---

## 20. SITE REPLICATION (Admin API)

### 20.1 Get Site Replication Info

**API Call:** `madmin.SiteReplicationInfo(ctx)`

```go
info, err := adminClient.SiteReplicationInfo(ctx)
// Returns: *madmin.SiteReplicationInfo {
//     Enabled: bool
//     Name: string
//     Sites: []madmin.PeerInfo
//     ServiceAccountAccessKey: string
// }
```

### 20.2 Add Site Replication

**API Call:** `madmin.SiteReplicationAdd(ctx, sites, opts)`

```go
sites := []madmin.PeerSite{
    {
        Name:      "site1",
        Endpoint:  "https://minio1.example.com",
        AccessKey: "accesskey1",
        SecretKey: "secretkey1",
    },
    {
        Name:      "site2",
        Endpoint:  "https://minio2.example.com",
        AccessKey: "accesskey2",
        SecretKey: "secretkey2",
    },
}

opts := madmin.SRAddOptions{}
status, err := adminClient.SiteReplicationAdd(ctx, sites, opts)
// Returns: *madmin.ReplicateAddStatus
```

### 20.3 Edit Site Replication

**API Call:** `madmin.SiteReplicationEdit(ctx, site, opts)`

```go
site := madmin.PeerInfo{
    Endpoint:  "https://minio-updated.example.com",
    Name:      "site1",
    AccessKey: "newkey",
    SecretKey: "newsecret",
}

opts := madmin.SREditOptions{}
status, err := adminClient.SiteReplicationEdit(ctx, site, opts)
```

### 20.4 Get Site Replication Status

**API Call:** `madmin.SRStatusInfo(ctx, params)`

```go
params := madmin.SRStatusOptions{
    Users:   true,
    Groups:  true,
    Policies: true,
    Buckets: true,
}

status, err := adminClient.SRStatusInfo(ctx, params)
// Returns: *madmin.SRStatusInfo
```

### 20.5 Remove Site Replication

**API Call:** `madmin.SiteReplicationRemove(ctx, removeReq)`

```go
removeReq := madmin.SRRemoveReq{
    SiteNames: []string{"site2"},
}

status, err := adminClient.SiteReplicationRemove(ctx, removeReq)
```

---

## 21. TIERS (Admin API)

### 21.1 List Tiers

**API Call:** `madmin.ListTiers(ctx)`

```go
tiers, err := adminClient.ListTiers(ctx)
// Returns: []*madmin.TierConfig
```

### 21.2 Add Tier

**API Call:** `madmin.AddTier(ctx, tier)`

```go
tier := &madmin.TierConfig{
    Name: "S3TIER",
    Type: madmin.S3,
    S3: &madmin.TierS3{
        Endpoint:  "s3.amazonaws.com",
        AccessKey: "accesskey",
        SecretKey: "secretkey",
        Bucket:    "tiering-bucket",
        Prefix:    "minio-tier/",
        Region:    "us-east-1",
    },
}

err := adminClient.AddTier(ctx, tier)
```

### 21.3 Tier Stats

**API Call:** `madmin.TierStats(ctx)`

```go
stats, err := adminClient.TierStats(ctx)
// Returns: []madmin.TierInfo
```

### 21.4 Edit Tier Credentials

**API Call:** `madmin.EditTierCreds(ctx, tierName, creds)`

```go
creds := madmin.TierCreds{
    AccessKey: "newAccessKey",
    SecretKey: "newSecretKey",
}

err := adminClient.EditTierCreds(ctx, "S3TIER", creds)
```

### 21.5 Verify Tier Status

**API Call:** `madmin.VerifyTier(ctx, tierName)`

```go
err := adminClient.VerifyTier(ctx, "S3TIER")
```

### 21.6 Remove Tier

**API Call:** `madmin.RemoveTier(ctx, tierName)`

```go
err := adminClient.RemoveTier(ctx, "S3TIER")
```

---

## 22. SPEEDTEST (Admin API)

### 22.1 Run Speedtest

**API Call:** `madmin.Speedtest(ctx, opts)`

```go
opts := madmin.SpeedtestOpts{
    Size:        64 * 1024 * 1024,  // 64 MB
    Duration:    10 * time.Second,
    Concurrency: 32,
    Autotune:    true,
}

resultsCh, err := adminClient.Speedtest(ctx, opts)
for result := range resultsCh {
    if result.Error != "" {
        log.Printf("Error: %s", result.Error)
        continue
    }
    fmt.Printf("Throughput: %.2f MB/s\n", float64(result.Throughput)/(1024*1024))
}
```

---

## 23. HEALING (Admin API)

### 23.1 Heal Bucket/Objects

**API Call:** `madmin.Heal(ctx, bucket, prefix, opts, dryRun, remove, recreate, scan)`

```go
opts := madmin.HealOpts{
    Recursive: true,
    DryRun:    false,
    Remove:    false,    // Remove dangling objects
    Recreate:  false,    // Recreate missing objects
    ScanMode:  madmin.HealNormalScan,
}

// Start healing
healStart, healTask, err := adminClient.Heal(ctx, "mybucket", "", opts, "", false, false)

// Check heal status
for {
    _, status, err := adminClient.Heal(ctx, "mybucket", "", opts, healStart.ClientToken, false, false)
    if err != nil {
        break
    }

    if status.Summary == "finished" {
        fmt.Printf("Healing complete: %d objects healed\n", status.ItemsHealed)
        break
    }

    time.Sleep(5 * time.Second)
}
```

---

## Verwendete Go-Bibliotheken

### Imports

```go
import (
    // Admin API Client
    "github.com/minio/madmin-go/v3"

    // S3 API Client
    "github.com/minio/minio-go/v7"

    // S3 API Sub-Packages
    "github.com/minio/minio-go/v7/pkg/credentials"
    "github.com/minio/minio-go/v7/pkg/sse"
    "github.com/minio/minio-go/v7/pkg/tags"
    "github.com/minio/minio-go/v7/pkg/notification"
    "github.com/minio/minio-go/v7/pkg/replication"
    "github.com/minio/minio-go/v7/pkg/policy"

    // IAM Policy
    iampolicy "github.com/minio/pkg/v3/policy"
)
```

### Installation

```bash
# Admin API Client
go get github.com/minio/madmin-go/v3

# S3 API Client
go get github.com/minio/minio-go/v7

# IAM Policy
go get github.com/minio/pkg/v3/policy
```

---

## Fehlerbehandlung

Alle API-Calls geben einen `error` zurück, der geprüft werden sollte:

```go
if err != nil {
    // Handle MinIO S3 error
    if minioErr, ok := err.(minio.ErrorResponse); ok {
        fmt.Printf("Code: %s, Message: %s\n", minioErr.Code, minioErr.Message)
    }

    // Handle MinIO Admin error
    if adminErr, ok := err.(madmin.ErrorResponse); ok {
        fmt.Printf("Code: %d, Message: %s\n", adminErr.StatusCode, adminErr.Message)
    }
}
```

---

## Environment Variables

Das MinIO Console Backend benötigt folgende Umgebungsvariablen:

```bash
# MinIO Server Endpoint (erforderlich)
CONSOLE_MINIO_SERVER=https://minio-server:9000

# MinIO Region (erforderlich)
CONSOLE_MINIO_REGION=us-east-1

# Session Encryption (erforderlich für Produktionsumgebung)
CONSOLE_PBKDF_PASSPHRASE=my-secret-passphrase
CONSOLE_PBKDF_SALT=my-secret-salt

# Console Port (optional, Standard: 9090)
CONSOLE_PORT=9090
```

---

## Zusammenfassung

Diese Dokumentation enthält alle **100+ API-Calls**, die an den MinIO Server gemacht werden können:

### Admin API (madmin-go)
- **User Management**: 6 Calls
- **Group Management**: 4 Calls
- **Policy Management**: 5 Calls
- **Service Accounts**: 5 Calls
- **Configuration**: 6 Calls
- **System Info**: 4 Calls
- **Profiling & Tracing**: 3 Calls
- **Remote Buckets**: 4 Calls
- **KMS**: 7 Calls
- **IDP**: 5 Calls
- **Site Replication**: 5 Calls
- **Tiers**: 6 Calls
- **Speedtest**: 1 Call
- **Healing**: 1 Call

### S3 API (minio-go)
- **Bucket Management**: 11 Calls
- **Bucket Encryption**: 3 Calls
- **Bucket Replication**: 3 Calls
- **Bucket Retention**: 3 Calls
- **Bucket Notifications**: 3 Calls
- **Object Operations**: 7 Calls
- **Object Tags**: 3 Calls
- **Object Retention**: 4 Calls
- **Presigned URLs**: 3 Calls

---

## Referenzen

- **MinIO Go Client SDK**: https://github.com/minio/minio-go
- **MinIO Admin Go Client**: https://github.com/minio/madmin-go
- **MinIO Console Backend (dieses Projekt)**: https://github.com/karlspace/MinIO-UI
- **MinIO Documentation**: https://min.io/docs/minio/linux/developers/go/API.html
- **MinIO Command Line Tool (mc)**: https://github.com/minio/mc
