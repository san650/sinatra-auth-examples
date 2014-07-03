# OmniAuth examples

1. Using developer strategy
   `bundle ex ruby developer.rb`
   Visit `http://localhost:4567/auth/developer`

2. Using github strategy
   Create a github app (https://github.com/settings/applications/new)
   `GITHUB_KEY=17c...f4 GITHUB_SECRET=703e...36149 bundle ex ruby github.rb`
   Visit `http://localhost:4567/auth/github`
