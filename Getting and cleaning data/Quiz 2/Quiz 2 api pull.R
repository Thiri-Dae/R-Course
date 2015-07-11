
library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at at
#    https://github.com/settings/applications. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
GitApiPull <- oauth_app("github",
                   key = "6e5482fb2c8f400b3f50",
                   secret = "a650e27ff2a6dd91a1b578e89341535ac3da2b4a")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), GitApiPull)

# OR:
gtoken <- config(token = github_token)
req <- with_config(gtoken, GET("https://api.github.com/rate_limit"))
stop_for_status(req)
content(req)