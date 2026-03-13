# Changelog

All notable changes to this project will be documented in this file.

## [1.4.0](https://github.com/scott-lexium/forge/compare/v1.3.0...v1.4.0) (2026-03-13)


### Features

* added Phase 15 (Zsh shell customization) and shell management command ([f52029e](https://github.com/scott-lexium/forge/commit/f52029e39db9fade0ffd5306aa5f219106d1d843))
* added Phase 16 (Webhook Notifications) for Slack, Discord, and Telegram ([2572b14](https://github.com/scott-lexium/forge/commit/2572b1453cbd010d57842bc4210d4a083228e9c2))
* added Phase 17 (WireGuard VPN) with QR code and auto-config ([6dbc35c](https://github.com/scott-lexium/forge/commit/6dbc35c5bb3066a381415815ea275cb8c970949d))
* added Phase 18 (Automated Heal System) and bumped version to 1.1.0-canary ([4859112](https://github.com/scott-lexium/forge/commit/4859112ca19aa325a393b99b0f57d7460e2715d1))
* added stability channel support (stable/canary) ([567bd52](https://github.com/scott-lexium/forge/commit/567bd5291ced3440e6bf2ce355e414ccd4367ab1))
* **ci:** automate canary promotion to main ([cf98472](https://github.com/scott-lexium/forge/commit/cf984729685e631fb6e7bca882ac411e74a69345))
* initial release of forge v1.0.0 ([b75f4dc](https://github.com/scott-lexium/forge/commit/b75f4dc638bc1842ad585f1a30caf5d6fe111e11))


### Bug Fixes

* **ci:** create promotion PR via GitHub API ([f638ff6](https://github.com/scott-lexium/forge/commit/f638ff6cb1fefb174ac4d9ef0fcf47fb8c1c37db))
* **cli:** restore forge parsing and single-phase dispatch ([e3ae918](https://github.com/scott-lexium/forge/commit/e3ae9183a6df13eb2b06a32e3bdd6d236e82ae1e))

## [1.2.0](https://github.com/scott-lexium/forge/compare/v1.1.0...v1.2.0) (2026-03-10)


### Features

* added Phase 15 (Zsh shell customization) and shell management command ([f52029e](https://github.com/scott-lexium/forge/commit/f52029e39db9fade0ffd5306aa5f219106d1d843))
* added stability channel support (stable/canary) ([567bd52](https://github.com/scott-lexium/forge/commit/567bd5291ced3440e6bf2ce355e414ccd4367ab1))

## [1.1.0](https://github.com/scott-lexium/forge/compare/v1.0.0...v1.1.0) (2026-03-10)


### Features

* initial release of forge v1.0.0 ([b75f4dc](https://github.com/scott-lexium/forge/commit/b75f4dc638bc1842ad585f1a30caf5d6fe111e11))

## [1.0.0] - 2026-03-10

### Features

- Automated VPS Setup Wizard (Ubuntu 22.04 LTS)
- SSH Hardening (Custom Port, Key-Only Auth, Root Login Disabled)
- UFW Firewall Configuration
- Fail2ban Brute-Force Protection
- Kernel & Network Stack Hardening
- Rootkit Detection (rkhunter + chkrootkit)
- Automatic Security Updates
- Docker CE & CapRover Integration
- System Monitoring Tools
- Security Auditing with Lynis
- Server Status Reporting
- **New: Phase 14 - Automated Swap File Creation**
- **New: Reset Command to Restore Original Configuration**
