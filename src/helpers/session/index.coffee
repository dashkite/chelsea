import Registry from "@dashkite/registry"

Session =

  connect: ( event ) ->
    presence = await Registry.get "presence"
    presence.publish 
      name: "connect"
      scope: "application"
      data: event.detail

export default Session
