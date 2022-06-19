import UIKit
import Foundation


struct ModelWeather {
    var imageWeather: UIImage
    var temperature: String
    var time: String
    var changeNatural: String
}

final class DataWeather: Codable {

    
    struct DataWeather: Codable {
        var cod: String?
        var message: Int?
        var cnt: Int?
        var list: [Dt]
    }
    
    struct Dt: Codable {
        var dt: Int?
    }
    
 
}
