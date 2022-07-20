import Foundation
import CoreLocation

final class NetworkManager: NSObject, CLLocationManagerDelegate  {
    
    let locationManager = CLLocationManager()
    var url = "http://api.openweathermap.org/data/2.5/forecast?lat=35&lon=139&appid=258cda358540ba669325b98f90414068"
    //8f2c2a9856f6696c61f99b0dba6a1fe7
    
    
    static func loadWeather(for coordinates: CLLocationCoordinate2D, completion: @escaping (DataWeather?, Error?)  -> Void) {
        
            let params: [URLQueryItem] = [URLQueryItem(name: "lat", value: String(coordinates.latitude)),
                                          URLQueryItem(name: "lon", value: String(coordinates.longitude)),
                                          URLQueryItem(name: "exclude", value: "minutely"),
                                          URLQueryItem(name: "units", value: "metric"),
                                          URLQueryItem(name: "appid", value: "258cda358540ba669325b98f90414068")]
            var url = URLComponents(string: "https://api.openweathermap.org/data/2.5/forecast")
            url?.queryItems = params
            guard let url = url?.url else { return }
            let weatherRequest = URLRequest(url: url)
            URLSession.shared.dataTask(with: weatherRequest) { data, response, error in
                guard let data = data, error == nil else {
                    print("\(error?.localizedDescription ?? "error")")
                    return
                }
                
                do {
                    if let result = try? JSONDecoder().decode(DataWeather.self, from: data) {
                        completion(result, error)
                    } else {
                        completion(nil,nil)
                    }
                }
            }.resume()

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
}
