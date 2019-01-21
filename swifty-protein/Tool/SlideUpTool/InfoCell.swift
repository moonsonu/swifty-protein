//
//  InfoCell.swift
//  swifty-protein
//
//  Created by Kristine Sonu on 1/18/19.
//  Copyright © 2019 Kristine Sonu. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        backgroundColor = UIColor(r: 108, g: 172, b: 228)
        addSubview(separatorView)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": separatorView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0(1)]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": separatorView]))
        
    }
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let inx: UILabel = {
        let name = UILabel()
        name.text = "Name"
        return name
    }()
    
    let val: UILabel = {
        let symbol = UILabel()
        symbol.text = "Symbol"
        return symbol
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class InfoCell: BaseCell {
    
    var parsing: Parse? {
        didSet {
            inx.font = UIFont(name: "menlo-Bold", size: 15)
            val.font = UIFont(name: "menlo-Bold", size: 15)
            inx.textColor = UIColor.white
            val.textColor = UIColor.white
            inx.text = parsing!.index
            val.text = "\(parsing?.value ?? "No Info")"
        }
    }
    
    override func setupViews() {
        super.setupViews()

        addSubview(inx)
        addSubview(val)
        addConstraintsWithFormat("H:|-8-[v0(160)]-1-[v1]|", views: inx, val)
        addConstraintsWithFormat("V:|-10-[v0]|", views: inx)
        addConstraintsWithFormat("V:|-10-[v0]|", views: val)
        addConstraint(NSLayoutConstraint(item: inx, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: val, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}

extension UIView {
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
