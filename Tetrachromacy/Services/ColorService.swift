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
    
    func getColorTheme(for name: String, completion: @escaping (_ success: Bool, _ themeColor: ThemeColor?) -> ()) {
        Alamofire.request("\(HEROKU_URL)/\(name)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: DEFAULT_HEADER).responseJSON { (response) in
            if response.error != nil {
                completion(false, nil)
                debugPrint(response.error as Any)
                
                return
            }
            
            guard let data = response.data else { completion(false, nil); return }
            let json = JSON(data: data)
            
            let primaryColor = json["primary_color"].stringValue
            let secondaryColor = json["secondary_color"].stringValue
            let colorPicked = ThemeColor(name: name, primaryColor: primaryColor, secondaryColor: secondaryColor)
            
            completion(true, colorPicked)
        }
    }
    
    func uploadImage(_ image: UIImage, completion: @escaping (_ success: Bool, _ themeColor: ThemeColor?) -> ()) {
        
        let imageData = image.pngData()!
            
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imageData, withName: "image", fileName: "image.png", mimeType: "image/png")
        }, to: "\(HEROKU_URL)/uploadImage", encodingCompletion: { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                
                upload.responseJSON(completionHandler: { (response) in
                    print(response.result.value as Any)
                    
                    // Response should be usable to create a ThemeColor and pass it instead of nil
                    completion(true, nil)
                })
                
            case .failure(let encodingError):
                print(encodingError)
                completion(false, nil)
            }
        })
    }
}
