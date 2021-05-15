//
//  Constants.swift
//
//  Created by Ravi Agrawal on 14/05/21.
//

import Foundation
import UIKit

let BASE_API_URL = "https://restcountries.eu/rest/v2/"
let COUNTRY_LIST_URL = BASE_API_URL + "all"
let COUNTRY_LIST_BY_NAME_URL = BASE_API_URL + "name"

/**
 *  Useful shared methods and Instances
 **/
//MARK:- ###############################
//MARK:- GLOBAL METHODS


enum Type {
    case Name
    case Capital
    case Currency
    case Population
}

class Constants {
    fileprivate static let shared = Constants()
    internal let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    internal let mainStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    internal static func sharedInstance() -> Constants {
        return shared
    }
}
