
 final class ChangeDegree {
     
     func changeDegrees(temp: Double) -> String {
         
         let changeCelsius = temp - 273.15
         let celsius = Int(changeCelsius)
         
         return "\(celsius)"
     }
    
}
