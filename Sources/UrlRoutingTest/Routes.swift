
public enum Api: Equatable {
  public enum Route: Equatable {
    case one(One)
    case two(Two)
    
    public enum One: Equatable {
      case somewhere(Int)
    }
    
    public enum Two: Equatable {
      case somewhere(Int)
    }
  }
}
