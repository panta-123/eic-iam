This repo is to deploy https://indigo-iam.github.io/v/v1.8.3/docs/overview/ .
Here we docker-compose for docker based deployment.
Things in docker-compose:
a. nginx
b. mariadb
c. IAM

# Changes to be made according to deployment:
1. Get the Hostname of your deployment macchine, lets say `myhost.jlab.org`. And add the hostname to following:
    - .env file:

           - IAM_HOST=myhost.jlab.org
           - IAM_BASE_URL=https://myhost.jlab.org
           - IAM_ISSUER=https://myhost.jlab.org
    - config/nginx.conf file, replace `vulcan.jlab.org` to `myhost.jlab.org`
2. Generate Host certificate for  `myhost.jlab.org` and put it in certs directory. It should contain `hostcert.pem`, `hostkey.pem`, `ca.pem` .
3. Generate a JSON web key. Follow the doc https://indigo-iam.github.io/v/v1.8.3/docs/getting-started/jwk/ and put the file name as : `iam-keystore.jwks` inside `keystore` directory.
4. Password related.
   - .env file:
        - MARIADB_ROOT_PASSWORD=change_me
        - Whatever you put as password for user `indigoiam` in `dbs_and_user.sql` (change `secret` to `your_password`) . Put the same in
          .env file : `IAM_DB_PASSWORD=secret`
# For logging
   Make sure you `/var/log/iam` diectory on you host.
    
# ADD CILOGON 
  Once you have your hostname , register the IAM to CLILOGON:
  
   a. Go to https://cilogon.org/oauth2/register and among other info put following for:
      ```
      Callbacks: https://myhost.jlab.org/openid_connect_login
      ```
     And tick the boxes of scopes for all  `org.cilogon.userinfo, profile, email, openid`

  b. You will get the `clientId`  and `clientSecret` from CILOGON. The make the following changes:
     - .env file  :
           - IAM_CILOGON_CLIENT_ID=<clientId>
           - IAM_CILOGON_CLIENT_SECRET<clientSecret>
        
          


           
