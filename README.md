## Installers Hub

This repository hosts **public installers and release binaries** for my apps.
Source code lives in separate (often private) repositories.

### Security model
- Install scripts download **versioned release assets** (EXE files).
- Each EXE has a matching **SHA256** file.
- The installer verifies the SHA256 before installing.

---

## VIZA (Windows)

### Install (PowerShell one-liner)
