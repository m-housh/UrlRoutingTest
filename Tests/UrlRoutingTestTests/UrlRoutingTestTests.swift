import XCTest
@testable import UrlRoutingTest

final class UrlRoutingTestTests: XCTestCase {

  func test_protocol_failing() throws {
    let router = ApiRouter()
    
    let request = URLRequest(url: URL(string: "/one/somewhere/1")!)
    do {
     _ =  try router.match(request: request)
    } catch {
      XCTFail()
    }
  }
  
  func test_protocol_passes_when_using_individual() throws {
    let router = OneRouter()
    let request = URLRequest(url: URL(string: "/somewhere/1")!)
    do {
     let res =  try router.match(request: request)
      XCTAssertEqual(res, .somewhere(1))
    } catch {
      XCTFail()
    }
  }
  
  func test_property_passes() throws {
    let router = apiRouter
    
    let request = URLRequest(url: URL(string: "/one/somewhere/1")!)
    do {
      let res =  try router.match(request: request)
      XCTAssertEqual(res, .one(.somewhere(1)))
    } catch {
      XCTFail()
    }
  }
}
