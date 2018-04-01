# Maven settings.xml and pom.xml

This folder includes a complete settings.xml file and a partial pom.xml file,
each with environment variable placeholders to support usage of Maven with a
private Artifactory server.

| Name                             | Example                                       | Description                   | Required by
|----------------------------------|-----------------------------------------------|-------------------------------|---------------------------
| `MAVEN_REPO_URL`                 | `https://artifactory.example.com/artifactory` | Maven repository URL          | All
| `MAVEN_REPO_RELEASES_KEY`        | `libs-release`                                | Public releases cache repo ID | All
| `MAVEN_REPO_SNAPSHOTS_KEY`       | `libs-snapshot`                               | Public snapshot cache repo ID | All (if using snapshots)
| `MAVEN_SETTINGS_PROFILE`         | `artifactory`                                 | Profile name                  | All
| `MAVEN_REPO_READER_USERNAME`     | `me`                                          | Developer's username          | Developer
| `MAVEN_REPO_READER_PASSWORD`     | `swordfish`                                   | Developer's password          | Developer
| `MAVEN_REPO_PUBLISHER_USERNAME`  | `cicd`                                        | Publisher's username          | CI/CD
| `MAVEN_REPO_PUBLISHER_PASSWORD`  | `super-secret`                                | Publisher's password          | CI/CD
| `MAVEN_REPO_RELEASES_LOCAL_KEY`  | `libs-release-local`                          | Private releases repo ID      | CI/CD
| `MAVEN_REPO_SNAPSHOTS_LOCAL_KEY` | `libs-release-snapshot`                       | Private snapshot repo ID      | CI/CD (if using snapshots)

**Note:** Usage of snapshots is not recommended. If you don't use snapshots,
you don't need to provide snapshot-related environment variables and you can
remove everything related to snapshots from the provided settings.xml file.
