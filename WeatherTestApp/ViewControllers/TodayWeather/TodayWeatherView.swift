import Foundation
import UIKit

protocol TodayWeatherViewInput: ViewRequestProtocol {
    func setupImageView()
    func setupLabel()
    func addLabelParametr(nameLocation: String, howDegree: Double, weatherConditions: String, speedWind: Double,procentHumidity: Double, pressure: Double, precipitationConditions: Double , deg: Double)
}

protocol TodayWeatherViewOutput: AnyObject {
    
}

class TodayWeatherView: GView {
  
    weak var controller: TodayWeatherController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
    }
  
}

extension TodayWeatherView: TodayWeatherViewInput {
    
    func addLabelParametr(nameLocation: String, howDegree: Double, weatherConditions: String, speedWind: Double,procentHumidity: Double, pressure: Double, precipitationConditions: Double , deg: Double) {
        
        
        if precipitationConditions > 0 {
            let imageWeatherConditons = UIImageView(frame: CGRect(x: (UIScreen.main.bounds.width / 2) - 50,
                                                                  y: (UIScreen.main.bounds.width / 2) - 80,
                                                                  width: 100,
                                                                  height: 100))
            
            imageWeatherConditons.image = UIImage(systemName: controller.model.imageWeatherConditonsRain)
            imageWeatherConditons.tintColor = .yellow
            controller.view.addSubview(imageWeatherConditons)
        } else {
            
            let imageWeatherConditons = UIImageView(frame: CGRect(x: (UIScreen.main.bounds.width / 2) - 50,
                                                                  y: (UIScreen.main.bounds.width / 2) - 80,
                                                                  width: 100,
                                                                  height: 100))
            
            imageWeatherConditons.image = UIImage(systemName: controller.model.imageWeatherConditonsSunny)
            imageWeatherConditons.tintColor = .yellow
            controller.view.addSubview(imageWeatherConditons)
        }
        
        setLabel(name: nameLocation,
                 size: CGRect(x: (UIScreen.main.bounds.width / 2) - 150,
                              y: (UIScreen.main.bounds.height / 4) + 30,
                              width: 300,
                              height: 50),
                 backgroundColor: .clear,
                 textAlighment: .center,
                 font: 25, textColor: .black)
        
        // вынести все стринги в модельку
        
        setLabel(name: "\(Int(howDegree))ºС",
                 size: CGRect(x: (UIScreen.main.bounds.width / 4) - 60,
                              y: (UIScreen.main.bounds.height / 4) + 70,
                              width: 200,
                              height: 50),
                 backgroundColor: .clear,
                 textAlighment: .center,
                 font: 30, textColor: .systemBlue)
        
        setLabel(name: weatherConditions,
                 size: CGRect(x: (UIScreen.main.bounds.width / 4) + 40,
                              y: (UIScreen.main.bounds.height / 4) + 70,
                              width: 200,
                              height: 50),
                 backgroundColor: .clear,
                 textAlighment: .center,
                 font: 30, textColor: .systemBlue)
        
        setLabel(name: "\(Int(speedWind))  km/h",
                 size: CGRect(x: (UIScreen.main.bounds.width / 4),
                              y: (UIScreen.main.bounds.height / 2) + 135,
                              width: 100,
                              height: 50),
                 backgroundColor: .clear,
                 textAlighment: .natural,
                 font: 15, textColor: .black)
                
        setLabel(name: "\(Int(procentHumidity)) %",
                 size: CGRect(x: (UIScreen.main.bounds.width / 10) + 12.5,
                              y: (UIScreen.main.bounds.height / 2) + 60,
                              width: 70,
                              height: 50),
                 backgroundColor: .clear,
                 textAlighment: .left,
                 font: 15, textColor: .black)
                    
        setLabel(name: "\(Int(pressure)) hPa",
                 size: CGRect(x: (UIScreen.main.bounds.width / 4 ) + (UIScreen.main.bounds.width / 4) + (UIScreen.main.bounds.width / 4) - 12.5,
                              y: (UIScreen.main.bounds.height / 2) + 60,
                              width: 70,
                              height: 50),
                 backgroundColor: .clear,
                 textAlighment: .left,
                 font: 15, textColor: .black)
        
        // добавить условие для отображения дождь/солнце //imageWeatherConditons.image = UIImage(systemName: "sun.max")
        
        setLabel(name: "\(precipitationConditions) mm",
                 size: CGRect(x: (UIScreen.main.bounds.width / 2 - 25),
                              y: (UIScreen.main.bounds.height / 2) + 60,
                              width: 70,
                              height: 50),
                 backgroundColor: .clear,
                 textAlighment: .natural,
                 font: 15, textColor: .black)
        
        setLabel(name: controller.model.utility.directionOfTheWind(direction: deg),
                 size: CGRect(x: (UIScreen.main.bounds.width / 4) + (UIScreen.main.bounds.width / 4) + 32.5,
                              y: (UIScreen.main.bounds.height / 2) + 135,
                              width: 50,
                              height: 50),
                 backgroundColor: .clear,
                 textAlighment: .center,
                 font: 15, textColor: .black)
    }
    
    func setImage(name: String,size: CGRect) -> UIImageView {
        let image = UIImageView(frame: size)
        image.image = UIImage(systemName: name)
        image.tintColor = .yellow
        image.addDashedBorder()
        controller.view.addSubview(image)
        return image
    }
    func setLabel(name: String, size: CGRect, backgroundColor: UIColor, textAlighment:
                  NSTextAlignment, font: CGFloat, textColor: UIColor ) -> UILabel {
        
        let label = UILabel(frame: size)
        label.textAlignment = textAlighment
        label.font = UIFont.systemFont(ofSize:font, weight: .bold)
        label.backgroundColor = backgroundColor
        label.textColor = textColor
        label.text = name
        controller.view.addSubview(label)
        return label
    }
    
    
    
    func srtAttrbutedString(label: UILabel, nameLabel: String) -> NSMutableAttributedString {
        
        let attrString = NSMutableAttributedString(string: nameLabel)
        
        attrString.addAttributes([.foregroundColor: UIColor.systemPink], range: NSRange(location: 0, length: 13))
        attrString.addAttributes([.foregroundColor: UIColor.systemOrange], range: NSRange(location: 13, length: 13))
        attrString.addAttributes([.foregroundColor: UIColor.systemGreen], range: NSRange(location: 26, length: 13))
        attrString.addAttributes([.foregroundColor: UIColor.systemBlue], range: NSRange(location: 39, length: 13))
        attrString.addAttributes([.foregroundColor: UIColor.systemYellow], range: NSRange(location: 52, length: 13))
        attrString.addAttributes([.foregroundColor: UIColor.red], range: NSRange(location: 65, length: 13))
        
        label.attributedText = attrString
        
        return attrString
    }
    
    func setupLabel() {
        setLabel(name: controller.model.todayTitle,
                 size: CGRect(x: (UIScreen.main.bounds.width / 2) - 100,y: (UIScreen.main.bounds.minY + 37.5),width: 200,height: 25),
                 backgroundColor: .clear,
                 textAlighment: .center,
                 font: 20, textColor: .black)
        
        setLabel(name: controller.model.separator,
                 size: CGRect(x: (UIScreen.main.bounds.width / 4), y: (UIScreen.main.bounds.height / 2), width: 400, height: 3),
                 backgroundColor: .clear,
                 textAlighment: .left,
                 font: 20, textColor: .lightGray)
        
        setLabel(name: controller.model.separator,
                 size: CGRect(x: (UIScreen.main.bounds.width / 4), y: (UIScreen.main.bounds.height / 4) + (UIScreen.main.bounds.height / 4) + (UIScreen.main.bounds.height / 4) + 15, width: 400, height: 3) ,
                 backgroundColor: .clear,
                 textAlighment: .left,
                 font: 20, textColor: .lightGray)
        
        
        srtAttrbutedString(label:setLabel(name: controller.model.lineTitle,
                                            size: CGRect(x: 0,y: UIScreen.main.bounds.minY + 75,width: UIScreen.main.bounds.width + 120, height: 3),
                                            backgroundColor: .lightGray,
                                            textAlighment: .right,
                                          font: 15, textColor: .clear) ,
                                            nameLabel: controller.model.lineTitle)
    }
    
    
    func setupImageView() {
        
        setImage(name: controller.model.humidity, size: CGRect( x: (UIScreen.main.bounds.width / 10),
                                                                y: (UIScreen.main.bounds.height / 2) + 25,
                                                                width: 50,
                                                                height: 50))
        
        setImage(name: controller.model.wind,
                 size: CGRect(x: (UIScreen.main.bounds.width / 4) + 5,
                              y: (UIScreen.main.bounds.height / 2) + 100,
                              width: 50,
                              height: 50))
        
        setImage(name: controller.model.drop,
                 size: CGRect(x: (UIScreen.main.bounds.width / 2 - 25),
                              y: (UIScreen.main.bounds.height / 2) + 25,
                              width: 50,
                              height: 50))
        
        setImage(name: controller.model.location,
                 size: CGRect(x: (UIScreen.main.bounds.width / 4) + (UIScreen.main.bounds.width / 4) + 32.5,
                              y: (UIScreen.main.bounds.height / 2) + 100,
                              width: 50,
                              height: 50))
        
        setImage(name: controller.model.escape,
                 size: CGRect(x: (UIScreen.main.bounds.width / 4 ) + (UIScreen.main.bounds.width / 4) + (UIScreen.main.bounds.width / 4),
                              y: (UIScreen.main.bounds.height / 2) + 25,
                              width: 50,
                              height: 50))
        
        // - придумать функцию которая принимает картинку исходя из погодных условий
      
        
        // - подумать как ска сделать что бы не обводилось бордером
        
        
    }
    
    func startRequest() {
        start()
    }
    
    func finishRequest() {
        stop()
    }
    
        // setup button Share
        
        //        let buttonShare = UIButton(frame: CGRect(x: (UIScreen.main.bounds.width / 2 - 50) , y: (UIScreen.main.bounds.height / 4) + (UIScreen.main.bounds.height / 4) + (UIScreen.main.bounds.height / 4) , width: 100, height: 100))
        //        buttonShare.setTitle("Share", for: .normal)
        //        buttonShare.setTitleColor(.orange, for: .normal)
        //
        //        self.view.addSubview(buttonShare)
      
    
    
    
}
