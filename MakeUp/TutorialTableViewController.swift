//
//  TutorialTableViewController.swift
//  Make TV
//
//  Created by Lucas Moreton on 6/23/16.
//  Copyright © 2016 Kaique de Souza Monteiro. All rights reserved.
//

import UIKit

class TutorialTableViewController: UITableViewController {
    let ocasiao: [String] = ["Casamento", "Trabalho", "Festa", "Almoço", "Encontro"]
    let tons: [String] = ["Quente", "Frio"]
    let instensidade: [String] = ["Leve", "Pesado"]
    var categoriaSelecionada: [Int] = [0,0,0]
    var lastIndex: NSIndexPath = NSIndexPath(forRow: 40, inSection: 40)
    weak var delegate: CategoryTableViewDelegate?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (section == 0) {
            return 5
        }
        return 2
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("categoryCell", forIndexPath: indexPath) as! CategoryCell
        
        if indexPath.section == 0 {
            cell.titleLabel.text = ocasiao[indexPath.row]
            cell.accessoryType = .None
            if indexPath.row + 1 == categoriaSelecionada[0] {
                cell.accessoryType = .Checkmark
            }
        } else if indexPath.section == 1 {
            cell.titleLabel.text = tons[indexPath.row]
            cell.accessoryType = .None
            if indexPath.row + 1 == categoriaSelecionada[1] {
                cell.accessoryType = .Checkmark
            }
            
        } else {
            cell.titleLabel.text = instensidade[indexPath.row]
            cell.accessoryType = .None
            if indexPath.row + 1 == categoriaSelecionada[2] {
                cell.accessoryType = .Checkmark
            }
        }
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if categoriaSelecionada[indexPath.section] == indexPath.row + 1 {
            categoriaSelecionada[indexPath.section] = 0
        } else {
            categoriaSelecionada[indexPath.section] = indexPath.row + 1
            
        }
        
        tableView.reloadData()
        
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("headerCell") as! HeaderCell
        
        if section == 0 {
            headerCell.name.text = "Ocasião"
            return headerCell
        } else if section == 1 {
            headerCell.name.text = "Tons"
            return headerCell
        }
        headerCell.name.text = "Intensidade"
        return headerCell
        
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    override func tableView(tableView: UITableView, didUpdateFocusInContext context: UITableViewFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        
        tableView.didUpdateFocusInContext(context, withAnimationCoordinator: coordinator)
        
        (context.previouslyFocusedView as? CategoryCell)?.titleLabel.textColor = UIColor(red: 216/256, green: 216/256, blue: 216/256, alpha: 1)
        (context.nextFocusedView as? CategoryCell)?.titleLabel.textColor = UIColor.blackColor()
        
    }
}