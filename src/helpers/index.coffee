import Registry from "@dashkite/registry"

Navigate =
  back: ({ fallback }) -> ->
    if navigation.entries().at(-1)?.sameDocument == true
      navigation.back()
    else
      navigation.navigate fallback

  to: ( target ) -> ->
    application = await Registry.get "application"
    application.navigate target
export default Navigate