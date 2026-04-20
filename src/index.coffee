import Topic from "@dashkite/reactive/topic"
import Registry from "@dashkite/registry"
import Messages from "@dashkite/messages"
import Pages from "@dashkite/monterey"
import Router from "@dashkite/cordoba"
import * as It from "@dashkite/joy/iterable"

import "@dashkite/vellum"
import "@dashkite/brooklyn"

import { Controllers } from "@dashkite/astoria"
import Providers from "@dashkite/belmont/providers"
import Lakeshore from "@dashkite/lakeshore"
import Halstead from "@dashkite/halstead"
import Broadway from "@dashkite/broadway"

Providers.add "mock", Lakeshore
Providers.add "local", Halstead
Providers.add "https", Broadway

import * as Stylist from "@dashkite/stylist"
import { forms } from "@dashkite/posh"
Stylist.add document, [ forms ]

import "./theming"
import messages from "./messages"

unresolved = ( text ) ->
  [ ignore..., text ] = text.split " :: "
  text

Registry.set "messages",
  Messages
    .make { unresolved }
    .add messages

Registry.set "message bar inbox", Topic.make()

Registry.set "application", Pages.make()

connectedProfile = null

authorized = ( page ) -> 
  return true if page.url.pathname == "/connect"
  return true if connectedProfile?
  
  email = localStorage.getItem "connection"
  if email? && email != "null" && email != ""
    # We must start listening BEFORE resolving to capture the initial value.
    controller = Controllers.Profile.make()
    
    promise = do ->
      # Safety timeout
      timeout = setTimeout ( -> throw new Error "Authorized: timeout waiting for profile [ #{email} ]" ), 5000
      try
        for await event from controller.listen()
          if event.name == "value"
            connectedProfile = event.value.profile
            return true
          if event.name == "not found"
            return false
      finally
        clearTimeout timeout

    await controller.resolve profile: bindings: { email }
    await promise
  else
    false

do ->
  await import("./pages")
  Router.run ( page ) ->
    if page.changed
      ( authorized page )
        .then ( ok ) ->
          if ok
            # Inject profile into context
            page.profile = connectedProfile
            page.data.apply page
          else
            navigation.navigate "/connect"
        .catch ( error ) ->
          console.error "Authorization failed:", error
          navigation.navigate "/connect"
