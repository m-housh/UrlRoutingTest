import URLRouting


var oneRouter: AnyParserPrinter<URLRequestData, Api.Route.One> {
  Route(.case(Api.Route.One.somewhere)) {
    Path { "somewhere"; Digits() }
  }
  .eraseToAnyParserPrinter()
}

var twoRouter: AnyParserPrinter<URLRequestData, Api.Route.Two> {
  Route(.case(Api.Route.Two.somewhere)) {
    Path { "somewhere"; Digits() }
  }
  .eraseToAnyParserPrinter()
}

var apiRouter: AnyParserPrinter<URLRequestData, Api.Route> {
  OneOf {
    Route(.case(Api.Route.one)) {
      Path { "one" }
      oneRouter
    }
    Route(.case(Api.Route.two)) {
      Path { "two" }
      twoRouter
    }
  }
  .eraseToAnyParserPrinter()
}
