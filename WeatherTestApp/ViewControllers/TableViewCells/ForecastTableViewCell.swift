import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    var dataSource3: DataWeather?
    
    
    @IBOutlet private weak var imageWeather: UIImageView!
    @IBOutlet  weak var temperature: UILabel!
    @IBOutlet private weak var time: UILabel!
    @IBOutlet private weak var changeNatural: UILabel!
    
    
    
    func checkCount( cellsian: inout String) -> String {
     
    if cellsian.count >= 3 {
        cellsian = ""
       return cellsian
    }
        return cellsian
    }
        
    func weatherItemModel(item: DataWeather) {
        
      //  self.temperature.text = "\(item.list.first?.main?.temp)"
      
    }
    

}
