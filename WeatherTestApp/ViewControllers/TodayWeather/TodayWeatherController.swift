
import Foundation
import UIKit
import CoreLocation

class TodayWeatherController: UIViewController {
    
    var model: TodayWeatherModel = TodayWeatherModel()
    
    private var myView: TodayWeatherView! {
        self.view as? TodayWeatherView
    }
    
    override func loadView() {
        let view: TodayWeatherView = TodayWeatherView()
        view.controller = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        view.backgroundColor = .white
        model.locationManager.delegate = self
        model.locationManager.startUpdatingLocation()
    }
    
    func setupView() {
        myView.setupImageView()
        myView.setupLabel()
        
    }
    
    
    private func loadWeather() {
        myView.startRequest()
        NetworkManager.loadWeather(for: model.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)) { [weak self] weather, error in
            if let weather = weather {
                DispatchQueue.main.async { [weak self] in
                   self?.myView.finishRequest()
                    self?.model.dataSource = weather
                    self?.myView.addLabelParametr(nameLocation: self?.model.dataSource?.city?.name ?? "",
                                                  howDegree: self?.model.dataSource?.list.first?.main?.temp ?? 0,
                                                  weatherConditions: self?.model.dataSource?.list.first?.weather.first?.main ?? "",
                                                  speedWind: self?.model.dataSource?.list.first?.wind.speed ?? 0,
                                                  procentHumidity: self?.model.dataSource?.list.first?.main?.humidity ?? 0,
                                                  pressure: self?.model.dataSource?.list.first?.main?.pressure ?? 0,
                                                  precipitationConditions: self?.model.dataSource?.list.first?.rain?.rain ?? 0 ,
                                                  deg: self?.model.dataSource?.list.first?.wind.deg ?? 0 )
                    
                    
                }
            } else if  let error = error {
                self?.myView.finishRequest()
                print(error.localizedDescription)
            }
        }
    }
    
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

extension TodayWeatherController: TodayWeatherViewOutput {
    
}

extension TodayWeatherController: CLLocationManagerDelegate {
    
    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus) {
            manager.requestWhenInUseAuthorization()
        }
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        if let location = locations.last {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            let coordinat = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            self.model.coordinate = coordinat
            loadWeather()
            self.model.locationManager.stopUpdatingLocation()
            
        }
    }
    
}

