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

import loadPages from "./pages"
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
profile = undefined
destination = undefined

do ->
  presence = await Registry.get "presence"
  application = await Registry.get "application"
  for await event from presence.subscribe()
    switch event.name
      when "connect"
        profile = event.data
        application.navigate destination || { name: "posts view" }
      when "disconnect"
        profile = undefined

before = ( source ) ->
  application = await Registry.get "application"
  for await context from source
    { data, bindings, url } = context
    if !( profile? || ( data.public ? false ))
      destination = { name: data.name, bindings }
      application.navigate name: "connect"
    else
      yield { context..., profile }

do ->
  await loadPages()
  Router.run { before }
