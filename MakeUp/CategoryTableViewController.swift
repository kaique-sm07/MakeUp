//
//  CategoryTableViewController.swift
//  MakeUp
//
//  Created by Kaique de Souza Monteiro on 09/06/16.
//  Copyright © 2016 Kaique de Souza Monteiro. All rights reserved.
//

import UIKit
import SwiftyJSON

class CategoryTableViewController: UITableViewController {
    
    let ocasiao: [String] = ["Casamento", "Trabalho", "Festa", "Almoço", "Encontro"]
    let tons: [String] = ["Quente", "Frio"]
    let instensidade: [String] = ["Leve", "Pesado"]
    var categoriaSelecionada: [Int] = [0,0,0]
    var json:JSON = nil
    var lastIndex: NSIndexPath = NSIndexPath(forRow: 40, inSection: 40)
    weak var delegate: CategoryTableViewDelegate?

    override func viewDidLoad() {
        
        
        if let path = NSBundle.mainBundle().pathForResource("imagens", ofType: "json") {
            
            do{
                let jsonData = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                self.json = JSON(data: jsonData)
            } catch {
                
            }
        }
        
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        var urls : [String] = []
        for (index,subJson):(String, JSON) in self.json["Imagens"] {
            if (subJson["ocasiao"].int == categoriaSelecionada[0] || categoriaSelecionada[0] == 0) && (subJson["tom"].int == categoriaSelecionada[1] || categoriaSelecionada[1] == 0) && (subJson["intensidade"].int == categoriaSelecionada[2] || categoriaSelecionada[2] == 0){
                urls.append(subJson["url"].string!)
            }
        }
        self.tableView.reloadData()
        self.performSegueWithIdentifier("detail", sender: urls)
        super.viewWillAppear(animated)
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
        
        var urls : [String] = []
        for (index,subJson):(String, JSON) in self.json["Imagens"] {
            if (subJson["ocasiao"].int == categoriaSelecionada[0] || categoriaSelecionada[0] == 0) && (subJson["tom"].int == categoriaSelecionada[1] || categoriaSelecionada[1] == 0) && (subJson["intensidade"].int == categoriaSelecionada[2] || categoriaSelecionada[2] == 0){
                urls.append(subJson["url"].string!)
            }
        }
        self.tableView.reloadData()
        self.performSegueWithIdentifier("detail", sender: urls)

        
        
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "detail") {
            let secondViewController = segue.destinationViewController as! FirstViewController
            let urls = sender as! [String]
            secondViewController.images = urls
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
