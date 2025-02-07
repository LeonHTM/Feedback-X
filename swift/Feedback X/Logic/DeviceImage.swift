//
//  DeviceImage.swift
//  Feedback X
//
//  Created by Leon  on 06.02.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import Foundation


struct DeviceImage {
    
    static func getDeviceIdentifier() -> String {
        
        var size = 0
           // Get the size of the data
           sysctlbyname("hw.model", nil, &size, nil, 0)
           
           var model = [CChar](repeating: 0, count: size)
           // Retrieve the actual data
           sysctlbyname("hw.model", &model, &size, nil, 0)
        
        //MacBook Air
        
        if String(cString: model) == "MacBookAir9,1"{
            return "MacBook Air"
        }else if String(cString: model) == "MacBookAir10,1"{
            return "MacBook Air"
        }else if String(cString: model) == "Mac14,2"{
            return "MacBook Air"
        }else if String(cString: model) == "Mac15,12"{
            return "MacBook Air"
        }else if String(cString: model) == "Mac15,13"{
            return "MacBook Air"
        }else if String(cString: model) == "Mac14,15"{
            return "MacBook Air"
        }
        
        //MacBook Pro
        
        else if String(cString: model) == "Mac16,1"{
            return "MacBook Pro"
        }else if String(cString: model) == "Mac16,6"{
            return "MacBook Pro"
        }else if String(cString: model) == "Mac16,8"{
            return "MacBook Pro"
        }else if String(cString: model) == "Mac16,7"{
            return "MacBook Pro"
        }else if String(cString: model) == "Mac16,5"{
            return "MacBook Pro"
        }else if String(cString: model) == "Mac15,3"{
            return "MacBook Pro"
        }else if String(cString: model) == "Mac15,6"{
            return "MacBook Pro"
        }else if String(cString: model) == "Mac15,8"{
            return "MacBook Pro"
        }else if String(cString: model) == "Mac15,10"{
            return "MacBook Pro"
        }else if String(cString: model) == "Mac15,7"{
            return "MacBook Pro"
        }else if String(cString: model) == "Mac15,9"{
            return "MacBook Pro"
        }else if String(cString: model) == "Mac15,11"{
            return "MacBook Pro"
        }else if String(cString: model) == "Mac14,5"{
            return "MacBook Pro"
        }else if String(cString: model) == "Mac14,9"{
            return "MacBook Pro"
        }else if String(cString: model) == "Mac14,6"{
            return "MacBook Pro"
        }else if String(cString: model) == "Mac14,10"{
            return "MacBook Pro"
        }else if String(cString: model) == "Mac14,7"{
            return "MacBook Pro"
        }else if String(cString: model) == "MacBookPro18,3"{
            return "MacBook Pro"
        }else if String(cString: model) == "MacBookPro18,4"{
            return "MacBook Pro"
        }else if String(cString: model) == "MacBookPro18,1"{
            return "MacBook Pro"
        }else if String(cString: model) == "MacBookPro18,2"{
            return "MacBook Pro"
        }else if String(cString: model) == "MacBookPro17,1"{
            return "MacBook Pro"
        }else if String(cString: model) == "MacBookPro16,3"{
            return "MacBook Pro"
        }else if String(cString: model) == "MacBookPro16,2"{
            return "MacBook Pro"
        }else if String(cString: model) == "MacBookPro16,1"{
            return "MacBook Pro"
        }else if String(cString: model) == "MacBookPro16,4"{
            return "MacBook Pro"
        }else if String(cString: model) == "MacBookPro15,4"{
            return "MacBook Pro"
        }else if String(cString: model) == "MacBookPro15,1"{
            return "MacBook Pro"
        }else if String(cString: model) == "MacBookPro15,3"{
            return "MacBook Pro"
        }else if String(cString: model) == "MacBookPro15,2"{
            return "MacBook Pro"
        }
        
        //Mac Pro
        
        else if String(cString: model) == "Mac14,8"{
            return "Mac Pro"
        }else if String(cString: model) == "MacPro7,1"{
            return "Mac Pro"
        }
        
        //iMac
        
        else if String(cString: model) == "Mac16,3"{
            return "iMac"
        }else if String(cString: model) == "Mac16,2"{
            return "iMac"
        }else if String(cString: model) == "Mac15,5"{
            return "iMac"
        }else if String(cString: model) == "Mac15,4"{
            return "iMac"
        }else if String(cString: model) == "iMac21,1"{
            return "iMac"
        }else if String(cString: model) == "iMac21,2"{
            return "iMac"
        }else if String(cString: model) == "iMac20,1"{
            return "iMac"
        }else if String(cString: model) == "iMac20,2"{
            return "iMac"
        }else if String(cString: model) == "iMac19,1"{
            return "iMac"
        }else if String(cString: model) == "iMac19,2"{
            return "iMac"
        }
        
        //iMac Pro
        
        else if String(cString: model) == "iMacPro1,1"{
            return "iMac Pro"
        }
        
        //Mac mini
        
        else if String(cString: model) == "Mac16,11"{
            return "Mac mini"
        }else if String(cString: model) == "Mac16,10"{
            return "Mac mini"
        }else if String(cString: model) == "Mac14,3"{
            return "Mac mini"
        }else if String(cString: model) == "Mac14,12"{
            return "Mac mini"
        }else if String(cString: model) == "Macmini9,1"{
            return "Mac mini"
        }else if String(cString: model) == "Macmini8,1"{
            return "Mac mini"
        }
        
        //Mac Studio
        
        else if String(cString: model) == "Mac14,13"{
            return "Mac Studio"
        }else if String(cString: model) == "Mac14,14"{
            return "Mac Studio"
        }else if String(cString: model) == "Mac13,1"{
            return "Mac Studio"
        }else if String(cString: model) == "Mac13,2"{
            return "Mac Studio"
        }
        
        //Unknown Mac Device
        
        else{
            return "Unknown Mac Device"
        }
        
       
    }
    
    static func getDeviceName() -> String {
        
        return Host.current().localizedName ?? "Unknown"
    }
    
    
}
