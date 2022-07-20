import Foundation

struct DataWeather: Codable {
    var cod: String?
    var message: Int?
    var cnt: Int?
    var list: [Dt]
    var city: City?
    
    enum CodingKeys: String, CodingKey {
        case cod
        case message
        case cnt
        case list
        case city
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(cod, forKey: .cod)
        try container.encode(message, forKey: .message)
        try container.encode(cnt, forKey: .cnt)
        try container.encode(list, forKey: .list)
        try container.encode(city, forKey: .city)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cod = try container.decode(String.self, forKey: .cod)
        message = try container.decode(Int.self, forKey: .message)
        cnt = try container.decode(Int.self, forKey: .cnt)
        list = try container.decode(Array.self, forKey: .list)
        city = try container.decode(City.self, forKey: .city)
    }
}

struct City: Codable {
    var name: String?
}

struct Dt: Codable {
    var dt: Int?
    var main: Main?
    var weather: [Weather]
    var wind: Wind
    var rain : Rain?
    
}

struct Rain: Codable {
    
    var rain: Double?
    
    enum CodingKeys: String, CodingKey {
        case rain = "3h"
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(rain, forKey: .rain)
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        rain = try container.decode(Double.self, forKey: .rain)
    }
}

struct Wind: Codable {
    var speed: Double?
    var deg: Double?
}

struct Main: Codable {
    var temp: Double?
    var feels_like: Double?
    var humidity: Double?
    var pressure: Double?
}

struct Weather: Codable {
    var main: String?
    var icon: String?
}
