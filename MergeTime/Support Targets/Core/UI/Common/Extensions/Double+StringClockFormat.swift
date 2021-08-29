//
//  Double+StringClockFormat.swift
//  Core
//
//  Created by Vlad Shkodich on 24.04.2021.
//

public extension Double {
    
    func toStringClockFormat() -> String {
        guard !self.isNaN else {
            return ""
        }
        
        let seconds: Int = Int(self.truncatingRemainder(dividingBy: 60))
        let hours: Int = Int(self) / 3600
        let minutes: Int = (Int(self) / 60) - (hours * 60)
        
        if minutes >= 0 && hours == 0 {
            return String(format: "%01d:%02d", minutes, max(0, seconds))
        }
        
        return String(format: "%01d:%02d:%02d", hours, minutes, seconds)
    }
}
