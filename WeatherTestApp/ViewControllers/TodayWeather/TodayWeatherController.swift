
import Foundation
import UIKit
import CoreLocation

class TodayWeatherController: UIViewController {
    
    var model: TodayWeatherModel = TodayWeatherModel()
    
    
    private var myView: TodayWeatherView! {
        self.view as? TodayWeatherView
    }
    
//        let items = ["This app is my favorite", UIImage(systemName: "sun.max"), URL(string:"www.google.com")] as [Any]
//        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
//        present(ac,animated: true)
//
//
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

