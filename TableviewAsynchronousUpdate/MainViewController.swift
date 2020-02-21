//
//  MainViewController.swift
//  TableviewAsynchronousUpdate
//
//  Created by Bharatraj Rai on 2/16/20.
//  Copyright © 2020 Bharatraj Rai. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {
    
    @IBOutlet weak var tableView: NSTableView!
    
    //Craeted below variable to store the email models which is created after parsing from json file
    var interactionModelList: EmailData?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        getContentFromJsonFile()
        getMlNrnPercentage()
    }
    
    /// Below method will read the data from jason file,  parse the data and creates a interaction model using hoigher order function compactMap
    
    
    func getContentFromJsonFile() {
        if let path = Bundle.main.path(forResource: "interactionData", ofType: "json") {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                do {
                    interactionModelList = try JSONDecoder().decode(EmailData.self, from: jsonData)
                } catch {
                    print("Error while reading the content from json file.")
                }
            } catch  {
                print("Could not find the file.")
            }
        }
    }
    
    /// This method is created for asynchronous operation. It generates the random number within 1000 for score and percentage will be calculated, once calculation is completed with sleep(for 1 second) in main queue this data will be updated.
    
    func getMlNrnPercentage() {
        DispatchQueue.global().async{ [weak self] in
            guard let interactions = self?.interactionModelList?.interactions else { return }
            for (index, emailModel) in (interactions.enumerated()) {
                sleep(1)
                let mlScore = Double.random(in: 1...1000)
                emailModel.mlNrnPercentage = (mlScore / 1000)*100
                DispatchQueue.main.async {
                    self?.refreshTableCellViewToUpdateMlNrnPercentage(rowIndex: index, model: emailModel)
                }
            }
        }
    }
    
    func refreshTableCellViewToUpdateMlNrnPercentage(rowIndex: Int, model: EmailModel) {
        model.isMlypeScoreDataLoaded = true
        let cell = tableView.view(atColumn: 0, row: rowIndex, makeIfNecessary: true) as? InteractionTableCellView
        cell?.progressIndicator.stopAnimation(true)
        cell?.progressIndicator.isHidden = true
        cell?.mlNrnPercentageTextField.isHidden = false
        self.tableView.reloadData(forRowIndexes: IndexSet(integer: rowIndex) , columnIndexes:IndexSet(integersIn: 0..<(self.tableView.numberOfColumns)))
    }
}

/// Extension for MainViewController to define tableview data source and delegate method

extension MainViewController: NSTableViewDataSource, NSTableViewDelegate {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return interactionModelList?.interactions?.count ?? 0
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let cell = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? InteractionTableCellView else { return NSTableCellView() }
        guard let rowDataModel = interactionModelList?.interactions?[row] else { return NSTableCellView() }
        cell.configureViewModel(emailModel: rowDataModel)
        return cell
    }
    
}
