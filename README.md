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

VirusTotal
Hybrid-Analysis
Shodan
IBM X-Force
URLScan
PassiveTotal
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
