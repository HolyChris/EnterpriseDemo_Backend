object :current_user, root: 'user'

attributes :auth_token, :email
node(:fullname) {|usr| usr.fullname}