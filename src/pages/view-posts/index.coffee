import Registry from "@dashkite/registry"
import * as Fn from "@dashkite/joy/function"
import Kr from "@dashkite/krypton"

import Application from "#application/context"
import html from "./html"

pages = Registry.sync.get "application"

pages.add "/",
  name: "view posts",
  apply: Fn.pipe [
    Application.context
    Kr.page html
    Kr.show
  ]
