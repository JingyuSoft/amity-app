//
//  CreateItineraryController.swift
//  Amity
//
//  Created by Jing Tang on 14/12/2014.
//  Copyright (c) 2014 Jingyu Soft. All rights reserved.
//

import Foundation
class ItineraryCreationController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var citySearchBar: UISearchBar!
    
    var filteredCities: UITableView!
    
    var filtered : NSMutableArray?
    
    var allCities : NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var frame = self.view.frame;
        var width = frame.size.width;
        var height = frame.size.height;
        filteredCities = UITableView(frame: CGRectMake(0, 120, width, height), style: UITableViewStyle.Plain)
        filteredCities?.autoresizingMask = UIViewAutoresizing.FlexibleHeight|UIViewAutoresizing.FlexibleWidth;
        filteredCities?.delegate = self
        filteredCities?.dataSource = self
        filteredCities?.alpha = 1;
        filteredCities?.separatorInset = UIEdgeInsetsZero
        citySearchBar.delegate = self
        
        allCities = NSMutableArray(array: ["Beijing", "Shanghai", "London", "Anqing"])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return filtered?.count ?? 0;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell") as? UITableViewCell
        if(cell == nil){
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        }
        cell?.textLabel.text = filtered?.objectAtIndex(indexPath.row) as? String
        return cell!
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String){
        if(searchText.isEmpty){
            
        }
        else{
            self.view.addSubview(filteredCities)
            filtered = NSMutableArray()
            for city in allCities!{
               var range = city.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
                if(range.location != NSNotFound){
                    filtered?.addObject(city)
                }
            }
        }
        filteredCities?.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        citySearchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar){
        self.filteredCities.removeFromSuperview();
    }
}