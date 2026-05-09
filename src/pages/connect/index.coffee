import Registry from "@dashkite/registry"
import { tee, pipe } from "@dashkite/joy/function"
import Kr from "@dashkite/krypton"

import Application from "#application/context"
import Navigate from "#helpers/navigation"
import Session from "#helpers/session"
import html from "./html"

pages = await Registry.get "application"

pages.add "/connect",
  name: "connect",
  public: true,
  apply: pipe [
    Application.context
    Kr.page html
    Kr.success Session.connect
    Kr.failure -> console.warn "failure!"
    Kr.show
  ]
