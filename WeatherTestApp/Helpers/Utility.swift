import Foundation
import UIKit

class Utility {
    
    
    func directionOfTheWind(direction: Double) -> String {
        
        switch direction {
        case 0...22,5:      return "NNE"
        case 22.6...45:     return "NE"
        case 45.1...67.5:   return "ENE"
        case 67.6...90.0:   return "E"
        case 90.1...112.5:  return "ESE"
        case 112.6...135.0: return "SE"
        case 135.1...157.5: return "SSE"
        case 157.6...180.0: return "S"
        case 180.1...202.5: return "SSW"
        case 202.6...225.0: return "SW"
        case 225.1...247.5: return "WSW"
        case 247.6...270.0: return "W"
        case 270.1...292.5: return "WWW"
        case 292.6...315.0: return "NW"
        case 315.1...337.5: return "NNW"
        case 337.6...360:   return "N"

        default:break
        }
        return ""
    }
}
