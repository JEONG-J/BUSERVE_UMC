//
//  ColorExtension.swift
//  BUSERVE_iOS
//
//  Created by 정태우 on 2023/07/21.
//

import Foundation
import UIKit

extension UIColor {
    static let MainColor = UIColor(named: "MainColor") ?? UIColor(red: 18/255, green: 104/255, blue: 251/255, alpha: 1)
    static let SubColor = UIColor(named: "SubColor") ?? UIColor(red: 255/255, green: 184/255, blue: 0/255, alpha: 1)
    static let Quaternary = UIColor(named: "Quaternary")
    static let Tertiary = UIColor(named: "Tertiary") ?? UIColor(red: 206/255, green: 211/255, blue: 216/255, alpha: 1)
    static let Body = UIColor(named: "Body") ?? UIColor(red: 53/255, green: 58/255, blue: 63/255, alpha: 1)
    static let Secondary = UIColor(named: "Secondary") ?? UIColor(red: 135/255, green: 142/255, blue: 149/255, alpha: 1)
    static let Background = UIColor(named: "Background") ?? UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    static let SecondaryBackground = UIColor(named: "SecondaryBackground")
    
    // LoginView Color
    static let KakaoBackground = UIColor(named: "KakaoBackground") ?? UIColor(red: 255/255, green: 222/255, blue: 0/255, alpha: 1)
    static let GoogleBackground = UIColor(named: "GoogleBackground") ?? UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    static let AppleBackground = UIColor(named: "AppleBackground") ?? UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
    static let LoginTextColor = UIColor(named: "LoginTextColor") ?? UIColor(red: 53/255, green: 58/255, blue: 63/255, alpha: 1)
    
    static let DarkModeSecondBackground = UIColor(named: "DarkModeSecondBackground") ?? UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    static let ButtonAlertBackground = UIColor(named: "ButtonAlertBackground") ?? UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    static let Tertiary_SecondaryColor = UIColor(named: "Tertiary_SecondaryColor") ?? UIColor(red: 206/255, green: 211/255, blue: 216/255, alpha: 1)
    static let Secondary_TertiaryColor = UIColor(named: "Secondary_TertiaryColor") ?? UIColor(red: 135/255, green: 142/255, blue: 149/255, alpha: 1)
    static let Tertiary_Quaternary = UIColor(named: "Tertiary_Quaternary") ?? UIColor(red: 206/255, green: 211/255, blue: 216/255, alpha: 1)
}
