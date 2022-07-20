import Foundation
import CoreLocation

protocol ForecastWeatherModelProtocol {
    
    var dataSource: DataWeather? { get }
    
    var forecastTitle: String { get }
  
    var coordinate: CLLocationCoordinate2D? { get }
    var locationManager: CLLocationManager { get }
}

class ForecastWeatherModel: ForecastWeatherModelProtocol {
    
    var dataSource: DataWeather?
    
    var forecastTitle: String = "Forecast"
    
    var coordinate: CLLocationCoordinate2D?
    var locationManager: CLLocationManager = CLLocationManager()
    
    
    
}
