## Indigo IAM Docker Deployment

This repository provides a Docker-based deployment solution for the Indigo IAM service, accessible at [https://indigo-iam.github.io/v/v1.8.3/docs/overview/](https://indigo-iam.github.io/v/v1.8.3/docs/overview/).

**Prerequisites:**

* Docker and Docker Compose installed on your deployment machine.
* A registered hostname for your deployment, e.g., `myhost.jlab.org`.
* A host certificate and a JSON web key generated as described below.

**Deployment Steps:**

1. **Configure Environment Variables:**

   Edit  `.env` file in the project root directory with the following content, replacing placeholders with your actual values:

           - IAM_HOST=myhost.jlab.org
           - IAM_BASE_URL=https://myhost.jlab.org
           - IAM_ISSUER=https://myhost.jlab.org

    Edit:  `config/nginx.conf` file, replace `vulcan.jlab.org` to `myhost.jlab.org`
    
2. **Generate Certificates and JSON Web Key:**

- Generate a host certificate for your deployment hostname (`myhost.jlab.org`) and place the following files in the `certs` directory:
  - `hostcert.pem`
  - `hostkey.pem`
  - `ca.pem`

- Follow the instructions at [https://indigo-iam.github.io/v/v1.8.3/docs/getting-started/jwk/](https://indigo-iam.github.io/v/v1.8.3/docs/getting-started/jwk/) to generate a JSON web key and save it as `iam-keystore.jwks` in the `keystore` directory.

3. Generate a JSON web key. Follow the doc https://indigo-iam.github.io/v/v1.8.3/docs/getting-started/jwk/ and put the file name as, `iam-keystore.jwks` inside `keystore` directory.
5. Password related.
   -  Edit  `.env` file in the project root directory 
        - MARIADB_ROOT_PASSWORD=change_me
   -  Edit `dbs_and_user.sql` file (change `secret` to `your_password`) . Put the same in
          .env file : `IAM_DB_PASSWORD=your_password`

3. **Configure Logging:**

- Ensure the `/var/log/iam` directory exists on your host machine.

4. **Register with CILogon:**

- Visit [https://cilogon.org/oauth2/register](https://cilogon.org/oauth2/register) and provide the following information:
  - **Client Name:** Your IAM application name. (IAM-EIC-RUCIO)
  - **Redirect URI(s):** `https://myhost.jlab.org/openid_connect_login`
  - **Scopes:** Select all scopes (org.cilogon.userinfo, profile, email, openid)
- Obtain the `clientId` and `clientSecret` provided by CILogon. Add them to your `.env` file:

  ```
  IAM_CILOGON_CLIENT_ID=<clientId>
  IAM_CILOGON_CLIENT_SECRET=<clientSecret>
  ```
        
          
5. **Run the Deployment:**

- Navigate to the project directory in your terminal.
- Run the following command to start the IAM service in detached mode:

  ```bash
  docker-compose --env-file .env -f docker-compose.yml --profile iam up -d
  ```

**Additional Notes:**

- Replace `myhost.jlab.org` with your actual deployment hostname throughout the process.
- Ensure you have obtained the necessary permissions to create directories and manage files on the host machine.
- Refer to the official Indigo IAM documentation ([https://indigo-iam.github.io/v/v1.8.3/docs/](https://indigo-iam.github.io/v/v1.8.3/docs/)) for further details and configuration options.


           
