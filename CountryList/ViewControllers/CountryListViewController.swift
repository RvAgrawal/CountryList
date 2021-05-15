//
//  CountryListViewController.swift
//  CountryList
//
//  Created by Ravi Agrawal on 14/05/21.
//

import UIKit

class CountryListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate {

    //MARK:- Params
    var arrCountries = [CountryObj]()
    var arrTemp = [CountryObj]()
    var selectedSegment = Type.Name
    
    //MARK:- IBOutlet
    @IBOutlet weak var searchCountry: UISearchBar!
    @IBOutlet weak var tblCountry: UITableView!
    @IBOutlet weak var segmentSort: UISegmentedControl!
    @IBOutlet weak var viewNoData: UIView!
    @IBOutlet weak var lblNoData: UILabel!
    @IBOutlet weak var imgNoData: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }
    
    //MARK:- Custom Methods
    func initialSetup(){
        self.lblNoData.text = "Please Wait Fetching Countries"
        self.imgNoData.image = UIImage.init(named: "no_country")
        
        var txfSearchField: UITextField?
        if #available(iOS 13,*) {
            txfSearchField = self.searchCountry.searchTextField
        } else {
            txfSearchField = self.searchCountry.value(forKey: "_searchField") as? UITextField
        }
        txfSearchField?.font = UIFont(name: "Rubik-Medium", size: 16.0)
        
        self.callGetCountryListAPI()
    }
    
    func sortCountriesByType(type : Type){
        switch type {
        case .Name:
            self.arrTemp = self.arrTemp.sorted(by: { (countryObj1, countryObj2) -> Bool in
                return countryObj1.getSetCountryName.compare(countryObj2.getSetCountryName) == ComparisonResult.orderedAscending
            })
            break
        case .Capital:
            self.arrTemp = self.arrTemp.sorted(by: { (countryObj1, countryObj2) -> Bool in
                return countryObj1.getSetCapital.compare(countryObj2.getSetCapital) == ComparisonResult.orderedAscending
            })
            break
        case .Currency:
            self.arrTemp = self.arrTemp.sorted(by: { (countryObj1, countryObj2) -> Bool in
                let strCurr1 = (countryObj1.getSetCurrencies!.first)?.getSetName as! String
                let strCurr2 = (countryObj2.getSetCurrencies!.first)?.getSetName as! String
                
                return strCurr1.compare(strCurr2) == ComparisonResult.orderedAscending
            })
            break
        case .Population:
            self.arrTemp = self.arrTemp.sorted(by: { (countryObj1, countryObj2) -> Bool in
                return countryObj1.getSetPopulation > (countryObj2.getSetPopulation)
            })
            break
        default:
            self.arrTemp = self.arrTemp.sorted(by: { (countryObj1, countryObj2) -> Bool in
                return countryObj1.getSetCapital.compare(countryObj2.getSetCapital) == ComparisonResult.orderedAscending
            })
            break
        }
        self.reloadUI()
    }
    
    func resetCountryList(){
        self.arrTemp = self.arrCountries
        self.selectedSegment = .Name
        self.sortCountriesByType(type: self.selectedSegment)
    }
    
    func reloadUI(){
        DispatchQueue.main.async {
            if self.arrTemp.count > 0 {
                self.viewNoData.isHidden = true
            } else {
                self.viewNoData.isHidden = false
                self.lblNoData.text = "No Countries Found"
                self.imgNoData.image = UIImage.init(named: "no_country")
            }
            self.tblCountry.reloadData()
        }
    }

    //MARK:- API Calling Methods
    func callGetCountryListAPI() {
        guard let url = URL(string: COUNTRY_LIST_URL) else {
            print("Error in URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                self.reloadUI()
                return
            }
            guard let data = data else {
                print("Error: No data")
                self.reloadUI()
                return
            }
            
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data)
                for data in (jsonData as! Array<Any>) {
                    print(data)
                    let obj = CountryObj(JSON: data as! [String : Any])
                    self.arrTemp.append(obj!)
                }
                self.arrCountries = self.arrTemp
                DispatchQueue.main.async {
                    self.sortCountriesByType(type : self.selectedSegment)
                }
            } catch {
                print("JSON data not converted")
                self.reloadUI()
                return
            }
        }.resume()
    }
    
    @objc func callCountryAPIWithSearch(){
        let searchText = self.searchCountry.text
        guard let url = URL(string: String(format: "%@/%@", COUNTRY_LIST_BY_NAME_URL,searchText!)) else {
            print("Error in URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                self.reloadUI()
                return
            }
            guard let data = data else {
                print("Error: No data")
                self.reloadUI()
                return
            }
            
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data)
                self.arrTemp.removeAll()
                if jsonData is NSArray{
                    for data in (jsonData as! Array<Any>) {
                        let obj = CountryObj(JSON: data as! [String : Any])
                        self.arrTemp.append(obj!)
                    }
                    DispatchQueue.main.async {
                        self.sortCountriesByType(type : self.selectedSegment)
                        self.viewNoData.isHidden = true
                    }
                } else if jsonData is NSDictionary{
                    self.reloadUI()
                }
            } catch {
                print("JSON data not converted")
                self.reloadUI()
                return
            }
        }.resume()
    }
    
    // MARK: - Tableview delegate and datasource methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrTemp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell") as? CountryCell {
            cell.countryData = self.arrTemp[indexPath.row]
            cell.drawCountryDataCell()
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "CountryDetailViewController") as? CountryDetailViewController else { return }
        detailVC.countryData = self.arrTemp[indexPath.row]
        self.present(detailVC, animated: true) {
        }
    }
    
    // MARK: - search bar delegate method
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        self.view .endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view .endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" {
            self.resetCountryList()
        } else {
            if (searchBar.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count)! >= 3 {
                NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(callCountryAPIWithSearch), object: nil)
                self.perform(#selector(callCountryAPIWithSearch), with: nil, afterDelay: 2.0)
            } else {
                self.resetCountryList()
            }
        }
    }
    
    //MARK:- UISegementControl Methods
    
    @IBAction func segmentIndexChanges(_ sender: Any) {
        switch self.segmentSort.selectedSegmentIndex {
        case 0:
            self.selectedSegment = .Name
            break
        case 1:
            self.selectedSegment = .Capital
            break
        case 2:
            self.selectedSegment = .Currency
            break
        case 3:
            self.selectedSegment = .Population
            break
        default:
            break
        }
        self.sortCountriesByType(type: self.selectedSegment)
    }
}

