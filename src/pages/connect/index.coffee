import Registry from "@dashkite/registry"
import * as Fn from "@dashkite/joy/function"
import Kr from "@dashkite/krypton"

import Application from "#application/context"
import Navigate from "#helpers/navigation"
import html from "./html"

pages = Registry.sync.get "application"

pages.add "/connect",
  name: "connect",
  aliases: [ "connect via email" ]
  apply: Fn.pipe [
    Application.context
    Kr.page html
    Kr.success Navigate.to name: "posts view"
    Kr.failure -> console.warn "failure!"
    Kr.show
  ]
