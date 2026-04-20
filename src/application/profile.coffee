import Resource from "@dashkite/belmont"
import Storage from "@dashkite/storage"

Profile =

  load: -> Storage.get "profile"

  save: ( data ) -> Storage.set "profile", data

export default Profile
