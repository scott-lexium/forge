# Changelog

All notable changes to this project will be documented in this file.

## [1.1.0] - 2026-03-11

### Features

- **Phase 16: Webhook Notifications**: Real-time alerts for Slack, Discord, and Telegram.
- **Phase 17: WireGuard VPN**: Automated setup of a secure VPN server with mobile-ready QR codes.
- **Phase 18: Automated Heal System**: Background monitoring and auto-restart for failed services.
- **Manual Heal Command**: `sudo forge heal` to trigger a system health check.
- **Stability Channels**: Support for `stable` and `canary` tracks.

### Improvements & Fixes

- **Phase 15**: Zsh + Oh-My-Zsh shell customization.
- **Phase 14**: Automated Swap file creation.
- **SSH Hardening**: Added support for `ssh.socket` masking on modern Ubuntu.
- **Reset Command**: Robust system restoration and user removal.
- **Status Command**: Detailed reporting for SSH, UFW, Swap, VPN, and Heal system.

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
