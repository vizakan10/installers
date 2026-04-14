# 📦 App Installers

> Official installers for all my tools. Source code lives in separate private repos — this repo only contains install scripts and release assets.

---

## 🗂️ Available Apps

| App | Description | Version | Install |
|-----|-------------|---------|---------|
| [**VIZA CLI**](./apps/viza/) | AI-powered CLI tool. Fast native EXE, no Python needed. | v1.0.2 | [→ Install](./apps/viza/) |

*More apps coming soon.*

---

## 🚀 How Releases Work

Each app has its own **release tag** in this repo (e.g. `viza-v1.0.2`).  
The actual installer EXE is attached as a **release asset** — never committed to Git history.

**To install any app:** navigate to its folder above and follow the README.

---

## 📁 Repo Structure

```
Installers/                ← You are here (App Catalog)
├── README.md               
└── viza/
        ├── README.md       ← VIZA install instructions & download links
        ├── install.bat     ← Optional: auto-download & install helper
        └── uninstall.bat   ← Optional: finds and runs the uninstaller
```

---

## ❓ Issues

Found a bug with an installer? [Open an issue](../../issues) and mention the app name.