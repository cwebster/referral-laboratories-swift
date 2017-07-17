//
//  FirstViewController.swift
//  ReferralLaboratories
//
//  Created by Craig Webster on 24/11/2016.
//  Copyright © 2016 Craig Webster. All rights reserved.
//

import UIKit


class LaboratoryTestsViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var LaboratoryTestsTableView: UITableView!
    
    var laboratoryTestsDataSouce : Array<Any> = []
    let textCellIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.LaboratoryTestsTableView.delegate = self
        
        LaboratoryTest.laboratoryTests{laboratoryTests
            in
            self.laboratoryTestsDataSouce = laboratoryTests
            self.LaboratoryTestsTableView.dataSource = self
            DispatchQueue.main.async{
                self.LaboratoryTestsTableView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.laboratoryTestsDataSouce.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath as IndexPath)
        
        let row = indexPath.row
        let analyte = laboratoryTestsDataSouce[row] as? LaboratoryTest
        cell.textLabel?.text = analyte?.attributes.analyteName
        return cell
    }
    
    
}

