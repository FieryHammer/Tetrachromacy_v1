//
//  ColorService.swift
//  Tetrachromacy
//
//  Created by Horvath, Mate on 2018. 11. 11..
//  Copyright © 2018. Finastra. All rights reserved.
//

import Alamofire
import SwiftyJSON

class ColorService {
    static let instance = ColorService()
    
    var themes = [String]()
    var currentColor: ThemeColor!
    
    func getThemes(completion: @escaping (_ success: Bool) -> ()) {
        Alamofire.request(HEROKU_URL, method: .get, parameters: nil, encoding: JSONEncoding.default
            , headers: DEFAULT_HEADER).responseJSON { (response) in
                if response.error != nil {
                    completion(false)
                    debugPrint(response.error as Any)
                    
                    return
                }
                
                guard let data = response.data else { completion(false); return }
                guard let json = JSON(data: data).array else {return}
                for theme in json {
                    self.themes.append(theme["name"].stringValue)
                }
                
                completion(true)
        }
    }
    
    func getColorTheme(for name: String, completion: @escaping (_ success: Bool) -> ()) {
        Alamofire.request("\(HEROKU_URL)/\(name)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: DEFAULT_HEADER).responseJSON { (response) in
            if response.error != nil {
                completion(false)
                debugPrint(response.error as Any)
                
                return
            }
            
            guard let data = response.data else { completion(false); return }
            let json = JSON(data: data)
            
            let primaryColor = json["primary_color"].stringValue
            let secondaryColor = json["secondary_color"].stringValue
            self.currentColor = ThemeColor(name: name, primaryColor: primaryColor, secondaryColor: secondaryColor)
            
            completion(true)
        }
    }
}
