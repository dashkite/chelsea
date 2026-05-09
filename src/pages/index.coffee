export default ->
  Promise.all [
    import("./connect")
    import("./posts")
    import("./blog")
    import("./post")
  ]
