//
//  DetailViewController.swift
//  swifty-protein
//
//  Created by Kristine Sonu on 1/15/19.
//  Copyright © 2019 Kristine Sonu. All rights reserved.
//

import UIKit
import SceneKit

class DetailViewController: UIViewController {

    @IBOutlet weak var ProteinView: SCNView!
    
    let activityIndicator = ActivityIndicator.shared
    var name : String?
    var pdb_file : String?
    var http: String = "https://files.rcsb.org/ligands/view/"
    var pdb: String = "_ideal.pdb"
    var atom: [Elements]?
    let settingLaunch = SlideupInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.animateActivity(title: "Loading...", view: self.view, navigationItem: navigationItem)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "menlo-Bold", size: 20)!]
        getproteinInfo(pName: name!)
        ProteinView.allowsCameraControl = true
        ProteinView.autoenablesDefaultLighting = true
//        ProteinView.layer.borderWidth = 5
//        ProteinView.layer.borderColor = UIColor.white.cgColor
        ProteinView.layer.cornerRadius = 10
        ProteinView.layer.masksToBounds = true
        
        sceneSetup()
        
        atom = GetAtomInfo().getAtomInfo()
        
        //show atom information
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.didTap(_:)))
        self.view.addGestureRecognizer(tapGR)
        
        //share button
        let addButton = UIBarButtonItem(title: "share", style: .plain, target: self, action: #selector(shareButton))
        self.navigationItem.rightBarButtonItem = addButton

        
    }

    func getproteinInfo(pName: String) {

        let url = URL(string: http + pName + pdb)
        let task = URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            if error == nil {
                DispatchQueue.main.async {
                self.activityIndicator.stopAnimating(navigationItem: self.navigationItem)
                let urlContent = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                var lines:[String] = []
                let string = urlContent! as String
                string.enumerateLines { (line, _) in
                    lines.append(line)
                }


                self.ProteinView!.scene = ProteinSCN(pdb_file: lines)
                self.activityIndicator.stopAnimating(navigationItem: self.navigationItem)
                self.title = self.name
            }
            }
            
            else {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating(navigationItem: self.navigationItem)
                }
                self.performSegue(withIdentifier: "warning", sender: self)
                print("error")
                
            }
        })

        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        task.resume()

    }
    
    func sceneSetup() {
        ProteinView.backgroundColor = UIColor.gray
        ProteinView.autoenablesDefaultLighting = true
        ProteinView.allowsCameraControl = true
    }
    
    @objc func didTap(_ tapGR: UITapGestureRecognizer) {

        let v = self.ProteinView as SCNView
        let tapPoint = tapGR.location(in: v)
        let hits = self.ProteinView!.hitTest(tapPoint, options: nil)
        
        if let tappedNode = hits.first?.node {

            if tappedNode.name?.isEmpty != nil {
                for index in atom! {
                    if index.symbol.lowercased() == tappedNode.name?.lowercased(){
                        settingLaunch.getAtominfo(data: index)
                        settingLaunch.handleView()
                    }
                }
            }
            else {
                print("error")
            }
        }
    }
    
    @objc func shareButton(_ sender: UINavigationItem) {
        let image = ProteinView.snapshot()
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            activityVC.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
            activityVC.completionWithItemsHandler = { activity, success, items, error in
            if success {
                if activity == .saveToCameraRoll {
                    self.showMessage()
                }
            }
        }
        self.present(activityVC, animated: true, completion: nil)
        }
    
    func showMessage() {
        let alertController = UIAlertController(title: "Save to Cameraroll", message: "저장완료", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

