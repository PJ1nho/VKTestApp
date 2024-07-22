import Foundation

enum Weather: String, CaseIterable {
    
    case fog
    case rain
    case lightning
    case sun
    case cloud
    
    var localizedString: String {
        switch self {
        case .fog:
            return NSLocalizedString("fog", comment: "")
        case .rain:
            return NSLocalizedString("rain", comment: "")
        case .lightning:
            return NSLocalizedString("lightning", comment: "")
        case .sun:
            return NSLocalizedString("sun", comment: "")
        case .cloud:
            return NSLocalizedString("cloudy", comment: "")
        }
    }
}
