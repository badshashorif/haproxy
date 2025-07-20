**HAProxy** এর একটি সাধারণ `haproxy.cfg` কনফিগারেশন ফাইল। নিচে ব্যাখ্যা করছি অংশ ধরে ধরে এবং শেষে বলছি কীভাবে এটি কাজ করে ও চালাতে হয়।

---

## 🔍 ব্যাখ্যা অংশে অংশে:

### ✅ `global` section:

```bash
global
    log /dev/log local0
    log /dev/log local1 notice
    chroot /var/lib/haproxy
    stats socket /var/lib/haproxy/stat
    user haproxy
    group haproxy
    daemon
```

* **log**: লগিং সিস্টেমে কোন facility দিয়ে লগ যাবে
* **chroot**: security জন্য, `/var/lib/haproxy` এর বাইরে access নেই
* **stats socket**: HAProxy স্ট্যাটাস সোকেট
* **user/group**: কোন user দিয়ে রান করবে
* **daemon**: ব্যাকগ্রাউন্ডে চলবে

---

### ✅ `defaults` section:

```bash
defaults
    log     global
    mode    http
    option  httplog
    option  dontlognull
    timeout connect 5000
    timeout client 50000
    timeout server 50000
```

* **mode http**: HTTP প্রোটোকল মোডে কাজ করবে
* **timeout**: কনেকশন টাইমআউট মান

---

### ✅ `frontend` definition:

```bash
frontend http_front
    bind *:80
    stats uri /haproxy?stats
    default_backend http_back
```

* \**bind *:80**: সব IP address থেকে 80 নম্বর পোর্টে listen করবে
* **stats uri**: স্ট্যাটাস দেখার জন্য URL: `http://your_ip/haproxy?stats`
* **default\_backend**: সব রিকোয়েস্ট যাবে `http_back` নামে backend-এ

---

### ✅ `backend` definition:

```bash
backend http_back
    balance roundrobin
    server server10 154.85.74.10:80 check
    server server14 154.85.74.11:80 check
    server server22 154.85.74.22:80 check
```

* **balance roundrobin**: লোড ব্যালান্সিং রাউন্ড-রবিন পদ্ধতিতে হবে
* **server ... check**: সার্ভার গুলোতে হেলথ চেক চালু থাকবে

---

## ⚙️ কাজ করার ধরণ:

1. ইউজার যখন ব্রাউজারে `http://your_ip` এ ঢুকবে →
2. HAProxy সেই রিকোয়েস্ট `http_front`-এ নেবে →
3. তারপর `http_back` backend-এ রিকোয়েস্ট পাঠাবে রাউন্ড-রবিন পদ্ধতিতে (load balancing)
4. `/haproxy?stats` ইউআরএল-এ গেলে HAProxy এর স্ট্যাটাস দেখা যাবে

---

## 🚀 কিভাবে চালাবেন:

### 🔹 Step 1: কনফিগ ফাইল সেভ করুন `/etc/haproxy/haproxy.cfg`

### 🔹 Step 2: config syntax চেক করুন:

```bash
haproxy -c -f /etc/haproxy/haproxy.cfg
```

### 🔹 Step 3: সার্ভিস চালু করুন:

```bash
systemctl start haproxy
systemctl enable haproxy
```

### 🔹 Step 4: ফায়ারওয়াল খুলে দিন (যদি দরকার হয়):

```bash
ufw allow 80/tcp
```

---

## 📊 HAProxy Stats Webpage Access:

URL এ যান:

```
http://your-server-ip/haproxy?stats
```

এই পেজে দেখতে পাবেন সব backend সার্ভারের status.

---


