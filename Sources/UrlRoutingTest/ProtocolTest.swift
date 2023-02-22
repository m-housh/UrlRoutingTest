import URLRouting

protocol SiteRouteRouter: ParserPrinter {
  
  associatedtype SiteRoute
  
  @ParserBuilder
  var body: AnyParserPrinter<URLRequestData, SiteRoute> { get }
}

extension SiteRouteRouter {
  
  public func parse(_ input: inout URLRequestData) throws -> Self.SiteRoute {
    try body.parse(input)
  }

  public func print(_ output: Self.SiteRoute, into input: inout URLRequestData) throws {
    try body.print(output, into: &input)
  }
}

struct OneRouter: SiteRouteRouter, Equatable {
  
  @ParserBuilder
  var body: AnyParserPrinter<URLRequestData, Api.Route.One> {
    Route(.case(Api.Route.One.somewhere)) {
      Path { "somewhere"; Digits() }
    }
    .eraseToAnyParserPrinter()
  }
}

struct TwoRouter: SiteRouteRouter, Equatable {
  
  @ParserBuilder
  var body: AnyParserPrinter<URLRequestData, Api.Route.Two> {
    Route(.case(Api.Route.Two.somewhere)) {
      Path { "somewhere"; Digits() }
    }
    .eraseToAnyParserPrinter()
  }
}

struct ApiRouter: SiteRouteRouter, Equatable {
  
  @ParserBuilder
  var body: AnyParserPrinter<URLRequestData, Api.Route> {
    OneOf {
      Route(.case(Api.Route.one)) {
        Path { "one" }
        OneRouter()
      }
      Route(.case(Api.Route.two)) {
        Path { "two" }
        TwoRouter()
      }
    }
    .eraseToAnyParserPrinter()
  }
}
