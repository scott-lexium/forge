# forge

> Automated, interactive VPS setup & security hardening CLI for Ubuntu 20.04 / 22.04 / 24.04 LTS.  
> Covers everything from first login to production-ready server in one command.

---

## Install

### Stable (Recommended)
```bash
curl -fsSL https://raw.githubusercontent.com/scott-lexium/forge/stable/install.sh | sudo bash
```

### Canary (Experimental)
```bash
curl -fsSL https://raw.githubusercontent.com/scott-lexium/forge/canary/install.sh | sudo bash -- --canary
```

### From a local clone

```bash
git clone https://github.com/scott-lexium/forge.git
cd forge
sudo bash install.sh
```

Once installed, `forge` is available globally on the server.

---

## Usage

```
sudo forge [command]
```

| Command | Description |
|---|---|
| `sudo forge` | Run the full interactive wizard *(default)* |
| `sudo forge run` | Same as above |
| `sudo forge phase <1-18>` | Run a single phase only |
| `sudo forge status` | Show live hardening status of the server |
| `sudo forge shell [user]` | Manage user shells (Switch Bash/Zsh) |
| `sudo forge heal` | Run manual system health check |
| `sudo forge reset` | Reset server configuration (revert SSH, UFW, users) |
| `sudo forge logs` | Browse past setup logs |
| `sudo forge update` | Update to the latest version in current channel |
| `sudo forge update --canary` | Switch to the Canary channel |
| `sudo forge update --stable` | Switch to the Stable channel |
| `sudo forge uninstall` | Remove forge from the system |
| `sudo forge version` | Show installed version |
| `sudo forge help` | Show help |

---

## Phases

| # | Phase | What it does |
|---|---|---|
| 1 | System update | `apt upgrade`, hostname, timezone |
| 2 | Admin user | Creates non-root sudo user |
| 3 | SSH hardening | Custom port, key-only auth, disable root login, session limits |
| 4 | UFW firewall | Deny-all default, allow SSH/HTTP/HTTPS + custom ports |
| 5 | Fail2ban | 3 failed attempts → 1hr IP ban |
| 6 | Kernel hardening | sysctl: SYN cookies, no redirects, rp_filter, log martians |
| 7 | Rootkit detection | rkhunter + chkrootkit |
| 8 | Auto updates | Unattended security upgrades |
| 9 | Docker | Official Docker CE from docker.com repo |
| 10 | CapRover | App deployment platform + DNS guidance |
| 11 | Monitoring | htop, iotop, nethogs, ncdu, logwatch |
| 12 | Lynis audit | Full security audit with recommendations |
| 13 | Backup | Config archive of all hardened files |
| 14 | Swap file | Automated creation and optimization (2G-4G) |
| 15 | Zsh Shell | Zsh + Oh-My-Zsh + Plugins (autosuggestions, syntax highlighting) |
| 16 | Notifications | Webhook alerts for Slack, Discord, and Telegram |
| 17 | WireGuard VPN | Secure VPN server with automatic client config & QR codes |
| 18 | Automated Heal | Background monitoring and auto-restart for failed services |

---

## Examples

```bash
# Fresh VPS — run everything
sudo forge

# Only add fail2ban to an existing server
sudo forge phase 5

# Reset server configuration back to default
sudo forge reset

# Check what's hardened right now
sudo forge status

# Update to latest version
sudo forge update
```

---

## Requirements

- Ubuntu 20.04 / 22.04 / 24.04 LTS
- Root or sudo access
- Internet connection (for installs)
- SSH public key ready on your local machine

---

## Logs

All wizard runs are logged to `/var/log/forge/`. View them with:

```bash
sudo forge logs
# or directly
sudo ls /var/log/forge/
```

---

## Self-Update

```bash
sudo forge update
```

Pulls the latest `forge` binary from GitHub and replaces the current install.  
No re-running the installer needed.

---

## Uninstall

```bash
sudo forge uninstall
```

Removes `/usr/local/bin/forge`. Logs in `/var/log/forge/` are kept unless you manually remove them.

---

## Based on

The hardening steps follow the [Scott Lexium VPS setup guide](https://scottlexium.substack.com/p/how-to-properly-set-up-a-vps-server).
