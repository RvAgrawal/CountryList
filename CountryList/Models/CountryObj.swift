//
//  CountryObj.swift
//  CountryList
//
//  Created by Ravi Agrawal on 14/05/21.
//

import Foundation

class CountryObj: Mappable, Equatable, Hashable {
    
    
    //MARK:- params
    
    private var countryName: String = ""
    private var population: Int = 0
    private var currencies: [Currency]?
    private var capital: String = ""
    private var callingCodes: [String]?
    private var region: String = ""
    private var borders: [String]?
    private var cioc: String = ""
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.countryName                            <- map["name"]
        self.population                             <- map["population"]
        self.currencies                             <- map["currencies"]
        self.capital                                <- map["capital"]
        self.callingCodes                           <- map["callingCodes"]
        self.region                                 <- map["region"]
        self.borders                                <- map["borders"]
        self.cioc                                   <- map["cioc"]
    }
    
    // Required Init method
    init () {
    }
    
    var hashValue: Int {
        return countryName.hashValue
    }

   
    
    //MARK:- Getters and Setters
    
    internal var getSetCountryName:String {
        get {
            return self.countryName
        }
        set {
            self.countryName = newValue
        }
    }
    internal var getSetPopulation:Int {
        get {
            return self.population
        }
        set {
            self.population = newValue
        }
    }
    internal var getSetCurrencies: [Currency]? {
        get {
            return self.currencies
        }
        set {
            self.currencies = newValue
        }
    }
    internal var getSetCapital:String {
        get {
            return self.capital
        }
        set {
            self.capital = newValue
        }
    }
    
    internal var getSetCioc:String {
        get {
            return self.cioc
        }
        set {
            self.cioc = newValue
        }
    }
    
    internal var getSetCallingCodes: [String]? {
        get {
            return self.callingCodes
        }
        set {
            self.callingCodes = newValue
        }
    }
    internal var getSetRegion:String {
        get {
            return self.region
        }
        set {
            self.region = newValue
        }
    }
    internal var getSetBorders: [String]? {
        get {
            return self.borders
        }
        set {
            self.borders = newValue
        }
    }
    
    internal var getCountryData:[String: Any]? {
        get {
            return ["countryName" : self.countryName as AnyObject, "population" : self.population as AnyObject, "currencies": self.currencies as AnyObject, "cioc": self.cioc as AnyObject,   "capital": self.capital as AnyObject,"callingCodes": self.callingCodes as AnyObject,"region": self.region as AnyObject, "borders": self.borders as AnyObject]
        }
    }
    
    static func ==(lhs: CountryObj, rhs: CountryObj) -> Bool {
        return (lhs.countryName == rhs.countryName) ? true : false
    }
}


class Currency: Mappable, Equatable, Hashable {
    
    
    //MARK:- params
    
    private var code: String = ""
    private var name: String = ""
    private var symbol: String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.code                            <- map["code"]
        self.name                            <- map["name"]
        self.symbol                          <- map["symbol"]
    }
    
    // Required Init method
    init () {
    }
    
    var hashValue: Int {
        return name.hashValue
    }

   
    
    //MARK:- Getters and Setters
    
    internal var getSetName:String {
        get {
            return self.name
        }
        set {
            self.name = newValue
        }
    }
    
    internal var getSetCode:String {
        get {
            return self.code
        }
        set {
            self.code = newValue
        }
    }
    
    internal var getSetSymbol:String {
        get {
            return self.symbol
        }
        set {
            self.symbol = newValue
        }
    }
    
    internal var getCountryData:[String: Any]? {
        get {
            return ["name" : self.name as AnyObject, "code" : self.code as AnyObject, "symbol": self.symbol as AnyObject]
        }
    }
    
    static func ==(lhs: Currency, rhs: Currency) -> Bool {
        return (lhs.name == rhs.name) ? true : false
    }
}

