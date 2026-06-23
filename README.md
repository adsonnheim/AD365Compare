# AD365Compare
Powershell script to compare users in Active Directory and Microsoft 365 to determine inconsistencies between them.
Only returns users from Active Directory that are Enabled.

How to use:
- Create a copy of `.env.example` and rename it to `.env.local`
- Fill out parameters in newly created .env.local file of where your users are located in your domain, e.g.:
    - `SEARCH_BASE=OU=users,DC=domain,DC=my`
- Run `AD365Compare.ps1`
- A window will open prompting you to login to your Microsoft account
- View results in terminal