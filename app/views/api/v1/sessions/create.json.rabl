object :@resource, root: 'user'

attributes :auth_token, :email
node(:success) { 'true' }