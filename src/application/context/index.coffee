import Registry from "@dashkite/registry"
import navbar from "./navbar"

application = undefined

Application =

  context: ( context ) ->
    application ?= await Registry.get "application"
    { bindings, profile } = context
    # Use profile from context if available
    address = profile?.blog?.address
    
    Object.assign context, 
      address: address
      sections: do ->
        _navbar = structuredClone navbar
        for section in _navbar
          for subsection in section.sections
            for link in subsection.links
              if ( application.query { name: link.name })?
                try # bindings may not align, but that's okay
                  link.url = application.link { name: link.name, bindings }
                catch error
                  # console.warn "Context: unable to generate link for [ #{link.name} ]", error.message
                  continue
        _navbar

export default Application
