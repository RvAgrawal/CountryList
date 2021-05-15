//
//  CountryDetailViewController.swift
//  CountryList
//
//  Created by Ravi Agrawal on 14/05/21.
//

import UIKit

class CountryDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK:- Params
    var strNavigationTitle : String = ""
    var countryData : CountryObj?
    var countryBorders: [String]?
    var currencies: [Currency]?
    var flowLayout: UICollectionViewFlowLayout {
        let _flowLayout = UICollectionViewFlowLayout()
        
        // edit properties here
        _flowLayout.itemSize = CGSize(width: 70, height: 40)
        _flowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 5)
        _flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        _flowLayout.minimumInteritemSpacing = 0.0
        return _flowLayout
    }
    
    var flowLayoutCurrencies: UICollectionViewFlowLayout {
        let _flowLayout = UICollectionViewFlowLayout()
        
        // edit properties here
        _flowLayout.itemSize = CGSize(width: 90, height: 40)
        _flowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 5)
        _flowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        _flowLayout.minimumInteritemSpacing = 0.0
        return _flowLayout
    }
    
    //MARK:- IBOutlet
    @IBOutlet weak var lblCountryName: UILabel!
    @IBOutlet weak var lblCapital: UILabel!
    @IBOutlet weak var lblPopulation: UILabel!
    @IBOutlet weak var lblNoCountry: UILabel!
    @IBOutlet weak var lblNoCountryDivider: UILabel!
    @IBOutlet weak var lblCallingcode: UILabel!
    @IBOutlet weak var lblRegion: UILabel!
    @IBOutlet weak var lblCode: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewCurrencies: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }
    
    //MARK:- Custom Methods
    func initialSetup(){
        self.collectionView.collectionViewLayout = flowLayout
        self.collectionViewCurrencies.collectionViewLayout = flowLayoutCurrencies
        self.setupData()
    }
    
    func setupData(){
        
        if (self.countryData?.getSetCioc.count)! > 0{
            self.lblCode.text = self.countryData?.getSetCioc
        }
        else{
            self.lblCode.text = String((self.countryData?.getSetCountryName.prefix(3))!).uppercased()
        }
        
        self.lblCountryName.text = self.countryData?.getSetCountryName
        self.lblCapital.text = self.countryData?.getSetCapital
        //self.lblCurrency.text = String(format: "%@ (%@)", (self.countryData?.getSetCurrencies!.first)?["name"] as! CVarArg,(self.countryData?.getSetCurrencies!.first)?["symbol"] as! CVarArg)
        self.lblRegion.text = self.countryData?.getSetRegion
        self.lblPopulation.text = String(format: "%d", self.countryData?.getSetPopulation as! CVarArg)
        self.lblCallingcode.text = String(format: "+%@", self.countryData?.getSetCallingCodes?.first as! CVarArg)
        self.countryBorders = self.countryData?.getSetBorders
        self.currencies = self.countryData?.getSetCurrencies
        if self.countryBorders!.count > 0 {
            self.collectionView.reloadData()
            self.collectionView.isHidden = false
            self.lblNoCountry.isHidden = true
            self.lblNoCountryDivider.isHidden = true
        }
        else{
            self.collectionView.isHidden = true
            self.lblNoCountry.isHidden = false
            self.lblNoCountryDivider.isHidden = false
        }
    }
    
    //MARK:- UICollectionview delegate Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return self.currencies!.count
        }
        else{
            return self.countryBorders!.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SurroundingCountriesCell", for: indexPath as IndexPath) as! SurroundingCountriesCell
        
        if collectionView.tag == 1 {
            let code = self.currencies![indexPath.row].getSetCode
            let symbol = self.currencies![indexPath.row].getSetSymbol
            if symbol is NSNull || symbol as! String == "<null>" {
                cell.lblCode.text = String(format: "%@", code as! CVarArg)
            } else {
                cell.lblCode.text = String(format: "%@ (%@)", code as! CVarArg,symbol as! CVarArg)
            }
            
        }
        else{
            cell.lblCode.text = self.countryBorders![indexPath.row]
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 70, height: 40)
    }
    
}

