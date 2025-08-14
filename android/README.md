# Commands

1. EXPORT GPG KEY to gradle.properties
```
gpg --armor --export-secret-keys [KEY_ID] \
    | awk 'NR == 1 { print "GPG_SIGNING_KEY=" } 1' ORS='\\n' \
    >> gradle.properties
```


2. UPLOAD KEY TO KEYSERVER

```
gpg --keyserver keyserver.ubuntu.com --send-keys [KEY_ID]
```

3. VERIFY KEY

```
gpg --keyserver keyserver.ubuntu.com --recv-keys [KEY_ID]
```

4. PUBLISH (Takes between 10-30 minutes to update)

```
./gradlew clean publishToMavenCentral
```