//
//  CountryCell.swift
//  CountryList
//
//  Created by Ravi Agrawal on 14/05/21.
//

import UIKit

class CountryCell: UITableViewCell {
        
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var lblCountryTitle: UILabel!
    @IBOutlet weak var lblCapitalTitle: UILabel!
    @IBOutlet weak var lblPopulation: UILabel!
    @IBOutlet weak var lblCurrency: UILabel!
    @IBOutlet weak var lblCode: UILabel!
    
    var countryData : CountryObj?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Custom Method
    func drawCountryDataCell() {
        if let data = self.countryData {
            if (self.countryData?.getSetCioc.count)! > 0{
                self.lblCode.text = self.countryData?.getSetCioc
            }
            else{
                self.lblCode.text = String((self.countryData?.getSetCountryName.prefix(3))!).uppercased()
            }
            self.lblCountryTitle.text = self.countryData?.getSetCountryName
            self.lblCapitalTitle.text = String(format: "Capital: %@", data.getSetCapital != "" ? data.getSetCapital : "NA")
            self.lblPopulation.text = String(format: "Population: %d", data.getSetPopulation)
            let strCurrSymbol = (data.getSetCurrencies!.first)?.getSetSymbol
            if strCurrSymbol is NSNull || strCurrSymbol as! String == "<null>" {
                self.lblCurrency.text = String(format: "Currency: %@", (data.getSetCurrencies!.first)?.getSetName as! CVarArg)
            } else {
                self.lblCurrency.text = String(format: "Currency: %@ (%@)", (data.getSetCurrencies!.first)?.getSetName as! CVarArg, strCurrSymbol as! CVarArg)
            }
        }
    }
}
