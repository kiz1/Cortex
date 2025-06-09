# 🧠 Cortex — Dockerized Automation Platform for Threat Intelligence

> **Cortex** is a Docker-ready automation platform for running analyzers and responders used in threat intelligence, incident response, and digital forensics workflows. This project provides an automated deployment setup using GitLab CI/CD with support for custom/private modules.


---

## 📁 Project Structure

```
Cortex/
├── gitlab-ci.yml # CI/CD pipeline definition
├── Dockerfile # Custom Docker image build instructions
├── docker-compose.yml # Service orchestration (Cortex + ES)
├── application.conf # File configuration
└── README.md # This documentation file
```

⚙️ Analyzers & Responders
This project includes a mechanism to install/update both public and private analyzers/responders automatically during Docker image build.

```
✅ Public Modules (from TheHive-Project)
These are standard modules maintained by TheHive Project:

- VirusTotal
- Hybrid-Analysis
- Shodan
- IBM X-Force
- URLScan
- PassiveTotal
And many more...
```
They can be found in the official repo:
https://github.com/TheHive-Project/Cortex-Analyzers

🔒 Private Modules
You can add your own private/internal analyzers/responders into the image by modifying the Dockerfile, e.g.:

```
RUN git clone https://your-private-repo.com/analyzers  /opt/cortex/analyzer && \
    cd /opt/cortex/analyzer && \
    pip install -r requirements.txt
```

Just make sure you have access configured properly (SSH keys, tokens, etc.).


🐳 Docker Image Features
This Docker image is based on the official thehiveproject/cortex:3.1.8-withdeps and includes several enhancements to make Cortex more usable in production environments.

🔧 Installed Dependencies
The image comes with a wide set of tools and libraries required by most analyzers:

```
- Python 3 + pip
- Libraries: ssdeep, libfuzzy-dev, libimage-exiftool-perl, libmagic1
- Build tools: build-essential, python3-dev, git, libssl-dev
- Utilities: curl, wget, unzip, iputils-ping, gnupg, tshark (Wireshark CLI)
- Locale support: locales
```
🌐 Google Chrome + Chromedriver (Selenium)
```
To support analyzers that require browser automation or JavaScript execution, the following are installed:

- Google Chrome Stable
- Chromedriver matching the Chrome version
```
