import Foundation


final class NetworkManager {
    
    
    static func loadWeather(completion: @escaping (DataWeather?, Error?)  -> Void) {
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?lat=35&lon=139&appid=258cda358540ba669325b98f90414068") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { responseData, response, error in
            
            if let data = responseData {
                let weather =  try? JSONDecoder().decode(DataWeather.self, from: data)
                completion(weather, error)
                
            } else {
                completion(nil,error)
            }
            
        }.resume()
    }
    
}
