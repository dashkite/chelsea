import Registry from "@dashkite/registry"
import * as Fn from "@dashkite/joy/function"
import Kr from "@dashkite/krypton"

import Application from "#application/context"
import html from "./html"

pages = await Registry.get "application"

pages.add "/blog/edit",
  name: "blog edit",
  apply: Fn.pipe [
    Application.context
    Kr.page html
    Kr.show
  ]
