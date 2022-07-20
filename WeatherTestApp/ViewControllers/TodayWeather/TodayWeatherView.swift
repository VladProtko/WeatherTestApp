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
        
        setLabel(name: nameLocation,
                 size: CGRect(x: (UIScreen.main.bounds.width / 2) - 170,
                              y: (UIScreen.main.bounds.height / 4) + 30,
                              width: 400,
                              height: 50),
                 color: .clear,
                 textAlighment: .center,
                 font: 25)
        
        // вынести все стринги в модельку
        
        setLabel(name: "\(Int(howDegree))ºС",
                 size: CGRect(x: (UIScreen.main.bounds.width / 4) - 30,
                              y: (UIScreen.main.bounds.height / 4) + 70,
                              width: 200,
                              height: 50),
                 color: .clear,
                 textAlighment: .center,
                 font: 30)
        
        setLabel(name: weatherConditions,
                 size: CGRect(x: (UIScreen.main.bounds.width / 4) + 70,
                              y: (UIScreen.main.bounds.height / 4) + 70,
                              width: 200,
                              height: 50),
                 color: .clear,
                 textAlighment: .center,
                 font: 30)
        
        setLabel(name: "\(Int(speedWind))  km/h",
                 size: CGRect(x: (UIScreen.main.bounds.width / 4),
                              y: (UIScreen.main.bounds.height / 2) + 135,
                              width: 100,
                              height: 50),
                 color: .clear,
                 textAlighment: .natural,
                 font: 15)
                
        setLabel(name: "\(Int(procentHumidity)) %",
                 size: CGRect(x: (UIScreen.main.bounds.width / 10) + 12.5,
                              y: (UIScreen.main.bounds.height / 2) + 60,
                              width: 70,
                              height: 50),
                 color: .clear,
                 textAlighment: .left,
                 font: 15)
                    
        setLabel(name: "\(Int(pressure)) hPa",
                 size: CGRect(x: (UIScreen.main.bounds.width / 4 ) + (UIScreen.main.bounds.width / 4) + (UIScreen.main.bounds.width / 4) - 12.5,
                              y: (UIScreen.main.bounds.height / 2) + 60,
                              width: 70,
                              height: 50),
                 color: .clear,
                 textAlighment: .left,
                 font: 15)
        
        // добавить условие для отображения дождь/солнце //imageWeatherConditons.image = UIImage(systemName: "sun.max")
        
        setLabel(name: "\(precipitationConditions) mm",
                 size: CGRect(x: (UIScreen.main.bounds.width / 2 - 25),
                              y: (UIScreen.main.bounds.height / 2) + 60,
                              width: 70,
                              height: 50),
                 color: .clear,
                 textAlighment: .natural,
                 font: 15)
        
        setLabel(name: controller.directionOfTheWind(direction: deg),
                 size: CGRect(x: (UIScreen.main.bounds.width / 4) + (UIScreen.main.bounds.width / 4) + 32.5,
                              y: (UIScreen.main.bounds.height / 2) + 135,
                              width: 50,
                              height: 50),
                 color: .clear,
                 textAlighment: .center,
                 font: 15)
    }
    
    func setImage(name: String,size: CGRect) -> UIImageView {
        let image = UIImageView(frame: size)
        image.image = UIImage(systemName: name)
        image.tintColor = .yellow
        image.addDashedBorder()
        controller.view.addSubview(image)
        return image
    }
    
    func setLabel(name: String, size: CGRect, color: UIColor, textAlighment:
                  NSTextAlignment, font: CGFloat) -> UILabel {
        
        let label = UILabel(frame: size)
        label.textAlignment = textAlighment
        label.font = UIFont.systemFont(ofSize:font, weight: .bold)
        label.backgroundColor = color
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
                 color: .clear,
                 textAlighment: .center,
                 font: 20)
        
        setLabel(name: controller.model.separator,
                 size: CGRect(x: (UIScreen.main.bounds.width / 4), y: (UIScreen.main.bounds.height / 2), width: 400, height: 3),
                 color: .clear,
                 textAlighment: .left,
                 font: 20)
        
        setLabel(name: controller.model.separator,
                 size: CGRect(x: (UIScreen.main.bounds.width / 4), y: (UIScreen.main.bounds.height / 4) + (UIScreen.main.bounds.height / 4) + (UIScreen.main.bounds.height / 4) + 15, width: 400, height: 3) ,
                 color: .clear,
                 textAlighment: .left,
                 font: 20)
        
        
        srtAttrbutedString(label:setLabel(name: controller.model.lineTitle,
                                            size: CGRect(x: 0,y: UIScreen.main.bounds.minY + 75,width: UIScreen.main.bounds.width + 120, height: 3),
                                            color: .lightGray,
                                            textAlighment: .right,
                                            font: 15) ,
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
        let imageWeatherConditons = UIImageView(frame: CGRect(x: (UIScreen.main.bounds.width / 2) - 50,
                                                              y: (UIScreen.main.bounds.width / 2) - 80,
                                                              width: 100,
                                                              height: 100))
        
        // - подумать как ска сделать что бы не обводилось бордером
        
        imageWeatherConditons.image = UIImage(systemName: controller.model.imageWeatherConditons)
        imageWeatherConditons.tintColor = .yellow
        controller.view.addSubview(imageWeatherConditons)
        
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
