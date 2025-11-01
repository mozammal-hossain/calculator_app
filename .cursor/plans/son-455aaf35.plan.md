<!-- 455aaf35-b521-46e9-aafe-63993fa4d477 6c122463-ad72-445f-b07c-020c45920a54 -->
# SonarQube (Community) + GitHub Actions for Flutter

## 1) Server prerequisites (one-time)

- Install a community Flutter/Dart plugin on your SonarQube server, then restart the server.
                                                                                                                                                                                                                                                                - Example plugin: “sonar-flutter” (community). Upload the JAR to the server’s `extensions/plugins/` directory and restart.
- Confirm plugin is active in Administration → Marketplace/Plugins.

## 2) Create project + generate token (one-time)

- In SonarQube UI: Projects → Create project → Manually
                                                                                                                                                                                                                                                                - Project key: use your repo name (e.g., `calculator_app`)
                                                                                                                                                                                                                                                                - Project name: `calculator_app`
- In user profile (top-right) → My Account → Security → Generate Token
                                                                                                                                                                                                                                                                - Copy token (you won’t see it again)

## 3) Add GitHub Secrets (one-time)

- In your GitHub repo → Settings → Secrets and variables → Actions → New repository secret
                                                                                                                                                                                                                                                                - `SONAR_HOST_URL` → e.g., `https://your.sonar.server` (no trailing slash)
                                                                                                                                                                                                                                                                - `SONAR_TOKEN` → token you created above

## 4) Configure project file(s)

- Update/create `sonar-project.properties` at repo root. Minimal example for Flutter:
```ini
sonar.projectKey=calculator_app
sonar.projectName=calculator_app
sonar.host.url=${env.SONAR_HOST_URL}
sonar.sources=lib
sonar.tests=test
sonar.exclusions=**/*.g.dart,**/*.freezed.dart
sonar.coverage.exclusions=**/*.g.dart,**/*.freezed.dart
# For community Flutter plugin
sonar.flutter.projectType=flutter
sonar.dart.lcov.reportPaths=coverage/lcov.info
```

- Notes:
                                                                                                                                                                                                                                                                - Keep `sonar.projectKey` exactly matching the key you created on the server.
                                                                                                                                                                                                                                                                - If your server/plugin uses different property names, adapt accordingly.

## 5) Add GitHub Actions workflow

- Create `.github/workflows/sonar.yml` with:
```yaml
name: SonarQube

on:
  push:
    branches: [ main, feat/** ]
  pull_request:
    branches: [ main ]

jobs:
  sonar:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Set up Java
        uses: actions/setup-java@v4
        with:
          distribution: temurin
          java-version: '17'

      - name: Set up Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.x'
          channel: 'stable'

      - name: Flutter pub get
        run: flutter pub get

      - name: Analyze (optional but recommended)
        run: flutter analyze || true

      - name: Run tests with coverage
        run: flutter test --coverage

      - name: Download SonarScanner
        uses: warchant/setup-sonar-scanner@v7

      - name: SonarQube Scan
        env:
          SONAR_HOST_URL: ${{ secrets.SONAR_HOST_URL }}
          SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}
        run: |
          sonar-scanner \
            -Dsonar.login=${SONAR_TOKEN}
```

- Optional: Add a quality gate wait step (requires appropriate server configuration):
```yaml
      - name: Wait for Quality Gate
        env:
          SONAR_HOST_URL: ${{ secrets.SONAR_HOST_URL }}
          SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}
        run: |
          # Requires Community plugin support or alternative action; otherwise skip
          echo "Skipping quality gate wait on Community if unsupported"
```


## 6) Local run (optional)

- Install SonarScanner locally and run from project root:
```bash
sonar-scanner \
  -Dsonar.host.url=https://your.sonar.server \
  -Dsonar.login=YOUR_TOKEN
```

- Ensure you’ve generated `coverage/lcov.info` first: `flutter test --coverage`.

## 7) Verify

- Open the project page in SonarQube after the first CI run.
- Confirm:
                                                                                                                                                                                                                                                                - Sources are recognized (`lib/`), tests (`test/`)
                                                                                                                                                                                                                                                                - Coverage from `coverage/lcov.info` is shown
                                                                                                                                                                                                                                                                - Exclusions applied (`*.g.dart`, `*.freezed.dart`)

## Notes on Community Edition

- Official Dart/Flutter support is not bundled in Community; using a community plugin is required.
- If coverage does not display, confirm the plugin supports `sonar.dart.lcov.reportPaths` and property names match the plugin’s documentation.

### To-dos

- [ ] Install community Flutter/Dart plugin on SonarQube server and restart
- [ ] Create SonarQube project and generate user token
- [ ] Add SONAR_HOST_URL and SONAR_TOKEN as GitHub Actions secrets
- [ ] Update sonar-project.properties with key, sources, tests, coverage paths
- [ ] Add GitHub Actions workflow to run tests, coverage, and sonar-scanner
- [ ] Verify analysis, measures, and coverage appear in SonarQube UI