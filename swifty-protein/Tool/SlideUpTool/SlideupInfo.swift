//
//  SlideupInfo.swift
//  swifty-protein
//
//  Created by Kristine Sonu on 1/18/19.
//  Copyright © 2019 Kristine Sonu. All rights reserved.
//

import UIKit

class Parse: NSObject {
    let index: String?
    let value: Any?
    
    init(index: String, value: Any?) {
        self.index = index
        self.value = value
    }
}

class SlideupInfo: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var info: Elements?
    var parse = [Parse]()
    let cellID = "cellID"
    
    let blackView = UIView()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()

    func getAtominfo(data: Elements?) {
        self.info = data!
        self.parse = [Parse(index: "Name :", value: data?.name ?? "no info"),
                      Parse(index: "Symbol :", value: data?.symbol ?? "no info"),
                      Parse(index: "Atomic Number :", value: data?.number ?? "no info"),
                      Parse(index: "Melting Point :", value: data?.melt ?? "no info"),
                      Parse(index: "Boiling Point :", value: data?.boil ?? "no info"),
                      Parse(index: "Density :", value: data?.density ?? "no info"),
                      Parse(index: "Discovered By:", value: data?.discovered_by ?? "no info"),
                      Parse(index: "Atomic Mass :", value: data?.atomic_mass ?? "no info"),
                      Parse(index: "Group :", value: data?.category ?? "no info"),
                      Parse(index: "Period :", value: data?.period ?? "no info"),
                      Parse(index: "Standard State :", value: data?.phase ?? "no info"),
                      Parse(index: "Molar Heat :", value: data?.molar_heat ?? "no info")
        ]
    }
    
    func handleView() {
        if let window = UIApplication.shared.keyWindow {
            self.collectionView.reloadData()
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            window.addSubview(blackView)
            window.addSubview(collectionView)
            let height: CGFloat = 200
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            collectionView.backgroundColor = UIColor(r: 108, g: 172, b: 228)
            let border = UIColor.white
            collectionView.layer.borderColor = border.cgColor
            collectionView.layer.borderWidth = 3
            collectionView.layer.cornerRadius = 5
            collectionView.layer.masksToBounds = true
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.blackView.alpha = 1
                    self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
            let indexPath = IndexPath(row: 0, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .top, animated: false)
        }
    }
    
    @objc func handleDismiss() {
        self.collectionView.reloadData()

        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)

            }
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return parse.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! InfoCell
        let info = parse[indexPath.item]
        cell.parsing = info
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }

    override init() {
        super.init()

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(InfoCell.self, forCellWithReuseIdentifier: cellID)
    }
}
