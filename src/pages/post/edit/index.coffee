import Registry from "@dashkite/registry"
import * as Fn from "@dashkite/joy/function"
import Kr from "@dashkite/krypton"

import Application from "#application/context"
import Navigate from "#helpers/navigation"
import html from "./html"

pages = await Registry.get "application"

pages.add "/post/{address}",
  name: "post edit",
  aliases: [ "post detail" ]
  apply: Fn.pipe [
    Application.context
    Kr.page html
    Kr.success Navigate.to name: "posts view"
    Kr.show
  ]
