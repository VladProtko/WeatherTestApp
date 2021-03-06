import UIKit
import CoreLocation

class ForecastVC: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var ForecastTableView: UITableView!
    
    var dataSource: DataWeather? { didSet{ self.ForecastTableView.reloadData() }}
    private let locationManager: CLLocationManager = CLLocationManager()
    private var coordinat = CLLocationCoordinate2D() { didSet { getLocation()}}

  //  private lazy var locationService: LoacationManagerProtocol = LocationManager()


   
    override func viewDidLoad() {
        super.viewDidLoad()
        ForecastTableView.delegate = self
        ForecastTableView.dataSource = self
       // loadWeather()
        addLabel()
        view.backgroundColor = .white
        
    }
    
    func getLocation() -> CLLocationCoordinate2D? {
        locationManager.requestWhenInUseAuthorization()
        
        return locationManager.location?.coordinate
        
    }
    
    private func loadWeather() {
        
       // guard let coordinates = locationService.getLocation() else { return }
        NetworkManager.loadWeather(for: coordinat) { [weak self] weather, error in
            if let weather = weather {
                DispatchQueue.main.async { [weak self] in
                    self?.dataSource = weather
                   
                }
            } else if  let error = error {
                print(error.localizedDescription)
            }
        }
    }


    
    func addLabel() {
        
        // labael - Forecast
        let label = UILabel(frame: CGRect(x: 0,
                                          y: 0,
                                          width: 200,
                                          height: 25))
        
        label.center = CGPoint(x: view.frame.width / 2, y: view.frame.minY + label.frame.height * 2)
        label.textAlignment = .center
        label.text = "Forecast"
        self.view.addSubview(label)
        
        //  setup lineMulticolors
        let labelLineColor = UILabel(frame: CGRect(x: 0,
                                                   y: (view.frame.minY + label.frame.height * 2) + 25,
                                                   width: UIScreen.main.bounds.width + 120,
                                                   height: 3))
        
        labelLineColor.textAlignment = .right
        labelLineColor.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        labelLineColor.backgroundColor = .lightGray
        self.view.addSubview(labelLineColor)
        
        let attrString = NSMutableAttributedString(string: " \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\" )
                                
        attrString.addAttributes([.foregroundColor: UIColor.systemPink], range: NSRange(location: 0, length: 13))
        attrString.addAttributes([.foregroundColor: UIColor.systemOrange], range: NSRange(location: 13, length: 13))
        attrString.addAttributes([.foregroundColor: UIColor.systemGreen], range: NSRange(location: 26, length: 13))
        attrString.addAttributes([.foregroundColor: UIColor.systemBlue], range: NSRange(location: 39, length: 13))
        attrString.addAttributes([.foregroundColor: UIColor.systemYellow], range: NSRange(location: 52, length: 13))
        attrString.addAttributes([.foregroundColor: UIColor.red], range: NSRange(location: 65, length: 13))

        labelLineColor.attributedText = attrString
        
    }

}

extension ForecastVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        view.tintColor = .clear
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .black
   }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Today"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTableViewCell",for: indexPath) as? ForecastTableViewCell
        
        let cellsian =  Int(dataSource?.list.first?.main?.temp ?? 0)
        
        cell?.temperature.text = "+\(cellsian) C??"
        
        return cell ?? UITableViewCell()
    }
    
    
}
