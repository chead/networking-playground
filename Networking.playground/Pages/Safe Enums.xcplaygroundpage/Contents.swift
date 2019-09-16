import Foundation

enum Choice {
    case first(Int)
    case second(String)
}

enum ChoiceError: Error, LocalizedError {
    case unknown

    var localizedDescription: String {
        return { () -> String in
            switch self {
            case .unknown:
                return "Unknown"
            }
        }()
    }
}

func foo(i: Int, completion: (Result<Choice, ChoiceError>) -> Void) {
    return completion({ () -> Result<Choice, ChoiceError> in
        switch(i) {
        case 1:
            return .success(.first(i))
            
        case 2:
            return .success(.second("Second"))
            
        default:
            return .failure(ChoiceError.unknown)
        }
    } ())
}

for i in 0...2 {
    foo(i: i) { (result) in
        switch(result) {
        case .success(let value):
            print("Success: \(value)")

        case .failure(let error):
            print("Failure: \(error.localizedDescription)")
        }
    }
}
