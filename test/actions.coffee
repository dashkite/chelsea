import assert from "@dashkite/assert"
import { pipe, tee } from "@dashkite/joy/function"
import * as K from "@dashkite/katana"
import Mimic from "@dashkite/mimic"
import { view } from "./helpers"
import configuration from "./configuration"

connecting = ( email ) -> pipe [
  Mimic.goto configuration.url
  Mimic.wait()
  view "connect"
  tee pipe [
    Mimic.waitFor "email-connector"
    Mimic.select "email-connector"
    Mimic.waitForShadow
    Mimic.shadow

    tee pipe [
      Mimic.waitFor "form-field"
      Mimic.select "form-field"
      Mimic.waitForShadow
      Mimic.shadow
      Mimic.waitFor "input"
      Mimic.select "input"
      Mimic.type email
    ]

    Mimic.waitFor "button"
    Mimic.select "button"
    Mimic.click
  ]
  Mimic.wait()
]

export default actions =

  "connecting (new creator)": pipe [
    connecting "test@example.com"
    view "posts view"
  ]

  "connecting (returning creator)": pipe [
    connecting "test@example.com"
    view "posts view"
  ]

  "editing the blog": pipe [
    tee pipe [
      Mimic.waitFor "a#nav-main-blog-edit"
      Mimic.select "a#nav-main-blog-edit"
      Mimic.click
    ]
    view "blog edit"
    tee pipe [
      Mimic.waitFor "blog-editor"
      Mimic.select "blog-editor"
      Mimic.waitForShadow
      Mimic.shadow
      tee pipe [
        Mimic.waitFor "form-field[name='title']"
        Mimic.select "form-field[name='title']"
        Mimic.waitForShadow
        Mimic.shadow
        Mimic.waitFor "input"
        Mimic.select "input"
        Mimic.type "My New Blog Title"
      ]
      tee pipe [
        Mimic.waitFor "textarea[name='description']"
        Mimic.select "textarea[name='description']"
        Mimic.type "My new blog description."
      ]
    ]
  ]

  "viewing posts": pipe [
    tee pipe [
      Mimic.waitFor "a#nav-main-posts-view"
      Mimic.select "a#nav-main-posts-view"
      Mimic.click
    ]
    view "posts view"
  ]

  "creating a post": pipe [
    tee pipe [
      Mimic.waitFor "posts-view"
      Mimic.select "posts-view"
      Mimic.waitForShadow
      Mimic.shadow
      Mimic.waitFor "button[name='add post']"
      Mimic.select "button[name='add post']"
      Mimic.click
    ]
    view "post edit"
  ]

  "writing a post": pipe [
    tee pipe [
      Mimic.waitFor "post-editor"
      Mimic.select "post-editor"
      Mimic.waitForShadow
      Mimic.shadow
      tee pipe [
        Mimic.waitFor "prose-editor"
        Mimic.select "prose-editor"
        Mimic.waitForShadow
        Mimic.shadow
        Mimic.waitFor ".cm-content"
        Mimic.select ".cm-content"
        Mimic.type "Hello world!"
      ]
      tee pipe [
        Mimic.waitFor "post-actions"
        Mimic.select "post-actions"
        Mimic.waitForShadow
        Mimic.shadow
        Mimic.waitFor "button[name='publish']"
        Mimic.select "button[name='publish']"
        Mimic.click
      ]
    ]
  ]

  "deleting a post": pipe [
    tee pipe [
      Mimic.waitFor "post-editor"
      Mimic.select "post-editor"
      Mimic.waitForShadow
      Mimic.shadow
      tee pipe [
        Mimic.waitFor "post-actions"
        Mimic.select "post-actions"
        Mimic.waitForShadow
        Mimic.shadow
        Mimic.waitFor "button[name='remove']"
        Mimic.select "button[name='remove']"
        Mimic.click
      ]
    ]
    view "posts view"
  ]
