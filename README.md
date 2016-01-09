ERS_MVP_Backend
===
**Backend code that iOS and web applications will interface with**

##Setup
  - create secrets.yml from secrets.yml.example
  - create database.yml from database.example.yml (update for your local mysql server as needed)
  - bundle exec rake db:create
  - bundle exec rake db:migrate
  - bundle exec rake db:seed

###Test ERS repo
## Auth Token:
Send auth token with each request in header for user.

name: *X-Auth-Token*

value: user token (for staging admin: **D2EdWKgbs8cq9PHyLhrA**)

Ideally, when a user's sign in request is successful then this token is sent in response to live for that session.

This token will change whenever a user tries to

1. sign in
2. update/reset password
3. after 3 weeks of last auth token change via any of the above two methods.

Above scenarios will result in only one session per user at a time i.e. a user cannot sign in via multiple devices as the token will change and will no longer be valid for old sessions.

If we are done with login/signin pages then this is not a problem as we can get this token in login/signin response.
Else, we have created a default api user (having admin role) on staging with token, **D2EdWKgbs8cq9PHyLhrA**, and can be used untill we are done with login pages.
