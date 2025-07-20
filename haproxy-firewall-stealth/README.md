# 🔒 HAProxy Stealth Firewall Rules (Ubuntu 22.04)

This project contains example scripts to make your HAProxy server **invisible to ping and traceroute** while keeping web access available.

## 📜 Contents

- `iptables.sh` → Script to apply stealth rules using `iptables`
- `ufw.sh` → Alternative method using `ufw` (Uncomplicated Firewall)

## 🚀 How to Use

### Option 1: IPTables (Recommended for fine control)

```bash
sudo bash iptables.sh
```

### Option 2: UFW (If you already use UFW)

```bash
sudo bash ufw.sh
```

## ✅ What It Does

- ❌ Blocks ping (ICMP echo requests)
- ❌ Blocks traceroute attempts (UDP 33434–33534)
- ✅ Keeps HAProxy (HTTP/port 80) working
- ✅ Keeps SSH (port 22) working

## 📌 Tested On

- Ubuntu 22.04 LTS
- HAProxy behind Docker or directly installed

## ⚠️ Warning

- If SSH port is blocked by mistake, you might get locked out!
- Test locally or with console access before applying on production server.
