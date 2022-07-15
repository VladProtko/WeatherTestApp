import UIKit

class TodayWeatherVC: UIViewController {
    
    var dataSource: DataWeather?
    let directionOfTheWind = DirectionOfTheWind()
    let changeDegree = ChangeDegree()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loadWeather()
        addLabel()
    }
        
  

    
    private func loadWeather() {
        NetworkManager.loadWeather { [weak self] weather, error in
            if let weather = weather {
                DispatchQueue.main.async { [weak self] in
                    self?.dataSource = weather
                    self?.addLabelParametr()
                }
            } else if  let error = error {
                print(error.localizedDescription)
            }
        }
    }

    func addLabelParametr() {
        //================LabelNameCity
        let labelCity = UILabel(frame: CGRect(x: (UIScreen.main.bounds.width / 2) - 100,
                                              y: (UIScreen.main.bounds.height / 4) + 30 ,
                                              width: 200,
                                              height: 50))
        
        labelCity.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        labelCity.textAlignment = .center
        
        let nameCity = dataSource?.city?.name
        labelCity.text = nameCity
        self.view.addSubview(labelCity)
        
        //==============labelDegree
        
        let labelDegree = UILabel(frame: CGRect(x: (UIScreen.main.bounds.width / 4),
                                                y: (UIScreen.main.bounds.height / 4) + 70 ,
                                                width: 200,
                                                height: 50))
        
        labelDegree.textAlignment = .center
        labelDegree.textColor = .systemBlue
        labelDegree.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        
        let cellsian = changeDegree.changeDegrees(temp: (dataSource?.list.first?.main?.temp)!)
        let weather = (dataSource?.list.first?.weather.first?.main)!
        
        labelDegree.text =   "+\(cellsian) Cº \(weather) "
        self.view.addSubview(labelDegree)
        
        //=============================== wind
        let labelWind = UILabel(frame: CGRect(x: (UIScreen.main.bounds.width / 4),
                                              y: (UIScreen.main.bounds.height / 2) + 135,
                                              width: 70,
                                              height: 50))
       
        labelWind.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        
        let wind = (dataSource?.list.first?.wind.speed)!
        labelWind.text = "\(wind) km/h"
        self.view.addSubview(labelWind)
        
        //====================humidity
        
        let labelHumidity = UILabel(frame: CGRect(x: (UIScreen.main.bounds.width / 10) + 12.5,
                                                  y: (UIScreen.main.bounds.height / 2) + 60,
                                                  width: 70,
                                                  height: 50))
              
        labelHumidity.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        
        let humidity = (dataSource?.list.first?.main?.humidity)!
        let changeToIntHumidity = Int(humidity)
        labelHumidity.text = "\(changeToIntHumidity)%"
        self.view.addSubview(labelHumidity)
        
        //====================pressure
        
        let labelPressure = UILabel(frame: CGRect(x: (UIScreen.main.bounds.width / 4 ) + (UIScreen.main.bounds.width / 4) + (UIScreen.main.bounds.width / 4) - 12.5,
                                                  y: (UIScreen.main.bounds.height / 2) + 60,
                                                  width: 70,
                                                  height: 50))
        labelPressure.textAlignment = .center
        labelPressure.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        
        let pressure = (dataSource?.list.first?.main?.pressure)!
        let changeToIntPressure = Int(pressure)
        labelPressure.text = "\(changeToIntPressure) hPa"
        self.view.addSubview(labelPressure)
        
        //=======================precipitation
        
        let labelPrecipitation = UILabel(frame: CGRect(x: (UIScreen.main.bounds.width / 2 - 25),
                                                       y: (UIScreen.main.bounds.height / 2) + 60,
                                                       width: 70,
                                                       height: 50))
        
        labelPrecipitation.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        
        let precipitation = (dataSource?.list.first?.rain?.rain)!
        labelPrecipitation.text = "\(precipitation) mm"
        self.view.addSubview(labelPrecipitation)

        //========================deg
        
        let labelDeg = UILabel(frame: CGRect(x: (UIScreen.main.bounds.width / 4) + (UIScreen.main.bounds.width / 4) + 32.5,
                                                            y: (UIScreen.main.bounds.height / 2) + 135,
                                                            width: 50,
                                                            height: 50))
               
        labelDeg.textAlignment = .center
        labelDeg.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        
        let deg = directionOfTheWind.directionOfTheWind(direction: (dataSource?.list.first?.wind.deg)!)
        labelDeg.text = deg
        self.view.addSubview(labelDeg)
        
    }
    


    
    func addLabel() {
        // labael - Today
        let label = UILabel(frame: CGRect(x: 0,
                                          y: 0,
                                          width: 200,
                                          height: 25))
        
        label.center = CGPoint(x: view.frame.width / 2, y: view.frame.minY + label.frame.height * 2)
        label.textAlignment = .center
        
        label.text = "Today"
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
        
        let attrString = NSMutableAttributedString(string: "\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\")
        
        attrString.addAttributes([.foregroundColor: UIColor.systemPink], range: NSRange(location: 0, length: 13))
        attrString.addAttributes([.foregroundColor: UIColor.systemOrange], range: NSRange(location: 13, length: 13))
        attrString.addAttributes([.foregroundColor: UIColor.systemGreen], range: NSRange(location: 26, length: 13))
        attrString.addAttributes([.foregroundColor: UIColor.systemBlue], range: NSRange(location: 39, length: 13))
        attrString.addAttributes([.foregroundColor: UIColor.systemYellow], range: NSRange(location: 52, length: 13))
        attrString.addAttributes([.foregroundColor: UIColor.red], range: NSRange(location: 65, length: 13))
        
        labelLineColor.attributedText = attrString
        
        // setup imageWeatherConditions
        let imageWeatherConditons = UIImageView(frame: CGRect(x: (UIScreen.main.bounds.width / 2) - 50,
                                                              y: (UIScreen.main.bounds.width / 2) - 80,
                                                              width: 100,
                                                              height: 100))
        
        imageWeatherConditons.image = UIImage(systemName: "cloud.heavyrain")
        imageWeatherConditons.tintColor = .yellow
        
        self.view.addSubview(imageWeatherConditons)
        
        //setup firstSeparator
        let firstSeparator = UILabel(frame: CGRect(x: (UIScreen.main.bounds.width / 4),
                                                   y: (UIScreen.main.bounds.height / 2),
                                                   width: 400,
                                                   height: 3))
        
        firstSeparator.textAlignment = .left
        firstSeparator.textColor = .lightGray
        firstSeparator.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        firstSeparator.text = "----------------------"
        self.view.addSubview(firstSeparator)
        
        //setup secondSeparator
        let secondSeparator = UILabel(frame: CGRect(x: (UIScreen.main.bounds.width / 4),
                                                    y: (UIScreen.main.bounds.height / 4) + (UIScreen.main.bounds.height / 4) + (UIScreen.main.bounds.height / 4) + 15,
                                                    width: 400,
                                                    height: 3))
        
        secondSeparator.textAlignment = .left
        secondSeparator.textColor = .lightGray
        secondSeparator.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        secondSeparator.text = "----------------------"
        self.view.addSubview(secondSeparator)
        
        // setup imageHumidity
        let imageHumidity = UIImageView(frame: CGRect(x: (UIScreen.main.bounds.width / 10),
                                                                y: (UIScreen.main.bounds.height / 2) + 25,
                                                                width: 50,
                                                                height: 50))
        
        imageHumidity.image = UIImage(systemName: "cloud.heavyrain")
        imageHumidity.tintColor = .yellow
        imageHumidity.addDashedBorder()
        self.view.addSubview(imageHumidity)
        
        // setup imageWind
        let imageWind = UIImageView(frame: CGRect(x: (UIScreen.main.bounds.width / 4) + 5,
                                                  y: (UIScreen.main.bounds.height / 2) + 100,
                                                  width: 50,
                                                  height: 50))
        
        imageWind.image = UIImage(systemName: "wind")
        imageWind.tintColor = .yellow
        imageWind.addDashedBorder()
        self.view.addSubview(imageWind)
        
        // setup imagePrecipitation
        let imagePrecipitation = UIImageView(frame: CGRect(x: (UIScreen.main.bounds.width / 2 - 25),
                                                           y: (UIScreen.main.bounds.height / 2) + 25,
                                                           width: 50,
                                                           height: 50))
        
        imagePrecipitation.image = UIImage(systemName: "drop")
        imagePrecipitation.tintColor = .yellow
        imagePrecipitation.addDashedBorder()
        self.view.addSubview(imagePrecipitation)
        
       
        // setup imageDeg
        let imageDeg = UIImageView(frame: CGRect(x: (UIScreen.main.bounds.width / 4) + (UIScreen.main.bounds.width / 4) + 32.5,
                                                 y: (UIScreen.main.bounds.height / 2) + 100,
                                                 width: 50,
                                                 height: 50))
        
        imageDeg.image = UIImage(systemName: "location")
        imageDeg.tintColor = .yellow
        imageDeg.addDashedBorder()
        self.view.addSubview(imageDeg)
                
        // setup imagePressure
        let imagePressure = UIImageView(frame: CGRect(x: (UIScreen.main.bounds.width / 4 ) + (UIScreen.main.bounds.width / 4) + (UIScreen.main.bounds.width / 4),
                                                      y: (UIScreen.main.bounds.height / 2) + 25,
                                                      width: 50,
                                                      height: 50))
        
        imagePressure.image = UIImage(systemName: "escape")
        imagePressure.tintColor = .yellow
        imagePressure.addDashedBorder()
        self.view.addSubview(imagePressure)
        
        // setup button Share
        
        let buttonShare = UIButton(frame: CGRect(x: (UIScreen.main.bounds.width / 2 - 50) , y: (UIScreen.main.bounds.height / 4) + (UIScreen.main.bounds.height / 4) + (UIScreen.main.bounds.height / 4) , width: 100, height: 100))
        buttonShare.setTitle("Share", for: .normal)
        buttonShare.setTitleColor(.orange, for: .normal)
        
        self.view.addSubview(buttonShare)
        
}
}


