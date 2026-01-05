# GYMMY

Gymmy is a minimalistic **mobile-friendly** gym tracking app.

Gymmy allows you to set a yearly goal for gym attendance.

Gymmy tracks your workouts (timestamp, type) against the set yearly goal.

Gymmy tracks your bodyweight over time.

Gymmy allows you to set your target bodyweight.

## Layout 

├─ bin/ → Compiled binary executables (ignored by Git).
├─ infra/ → Terraform files for infrastructure deployment.
├─ scripts/ → Bash script for building, testing, and deploying the app and its infrastructure. **TO BE USED BY DEVELOPERS, AI AGENTS, AND IN PIPELINES**
├─ .env → **SENSITIVE!** Environment variable for local runtime (ignored by Git).
├─ .env.example → Example of what goes into `.env`. Not sensitive.
├─ AGENTS.md → Additional context and instructions for AI Agents.

## Architecture

Gymmy is a Web Application written in [Flask](https://flask.palletsprojects.com/en/stable/).

Gymmy serves its own GUI.

Gymmy uses [Auth0](https://auth0.com/docs/quickstart/backend/python) to authenticate users.

Gymmy validates authentication tokens using JWKS as well as `iss`, `aud`, `exp`, and `sub` claims.

Gymmy uses Google Sheet to store **non-sensitive** user data (e.g. goals, gym attendance, etc.). In a nutshell Gymmy is nothing more than a purpose-built GUI to a beautiful Google Sheet.

Gymmy maintains Google Sheet OAuth tokens on the backend and never leaks those to GUI.

Gymmy is deployed on Azure.

Gymmy uses [Azure Table Storage](https://learn.microsoft.com/en-us/azure/storage/tables/table-storage-overview) to store **sensitive** user data (e.g. tokens). 

Gymmy envelope-encrypts any **sensitive** user data (e.g. tokens) with ephemeral AES-256-GCM data-encryption keys (DEKs); each DEK is _wrapped_ by a Key Encryption Key (KEK) stored in [Azure Key Vault](https://learn.microsoft.com/en-us/azure/key-vault/general/overview) (AKV).

Being a simple web application, Gymmy is deployed on [Azure App Service](https://learn.microsoft.com/en-us/azure/app-service/overview).

## Development Tools

- [Poetry](https://python-poetry.org/docs/) for dependency management.
- [OpenTofu](https://opentofu.org/docs/intro/) for infra deployment.