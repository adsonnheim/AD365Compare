# AD365Compare
Powershell script to compare users in Active Directory and Microsoft 365 to determine inconsistencies between them.
Only returns users from Active Directory that are Enabled.

How to use:
    1. Create a copy of .env.example and rename it to .env.local
    2. Fill out parameters in newly created .env.local file of where your users are located in your domain
        2.1. e.g., SEARCH_BASE=OU=users,DC=domain,DC=my
    3. Run script
    4. A window will open prompting you to login to your Microsoft account
    5. View results in terminal