//
//  SideMenuViewController.swift
//  SideMenuDrawer
//
//  Created by SV59349 on 26/08/22.
//

import UIKit

public protocol SideMenuViewControllerDelegate {
    func selectedCell(_ row: Int)
}

@IBDesignable public class SideMenuView: UIView {
    
    // MARK: - UI Components
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var headerLabel: UILabel!
    
    // MARK: - Properties
    public var delegate: SideMenuViewControllerDelegate?
    public var cellHight: CGFloat = 44
    public var cellHighlightedColor: UIColor = #colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1)
    public var menu: [SideMenuModel] = []
    
    public var headerTitle: NSAttributedString? {
        didSet {
            headerLabel.attributedText = headerTitle
        }
    }
    
    // MARK: - Initializations
    public override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromXib()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromXib()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        loadFromXib()
    }
    
    // MARK: - Methods
    private func loadFromXib() {
        
        let nib = UINib(nibName: "SideMenuView", bundle: Bundle(for: SideMenuCell.self))
        guard let customCaptchaView = nib.instantiate(withOwner: self).first as? UIView else { return }
        addSubview(customCaptchaView)
        
        customCaptchaView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customCaptchaView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            customCaptchaView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            customCaptchaView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            customCaptchaView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0)
            
        ])
        menuTableView.register(SideMenuCell.nib, forCellReuseIdentifier: SideMenuCell.identifier)
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension SideMenuView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHight
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.selectedCell(indexPath.row)
    }
}

// MARK: - UITableViewDataSource
extension SideMenuView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menu.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = menuTableView.dequeueReusableCell(withIdentifier: SideMenuCell.identifier, for: indexPath) as? SideMenuCell else { fatalError("xib doesn't exist") }
        
        cell.iconImageView.image = self.menu[indexPath.row].icon
        cell.titleLabel.text = self.menu[indexPath.row].title
        
        // Highlighted color
        let myCustomSelectionColorView = UIView()
        myCustomSelectionColorView.backgroundColor = cellHighlightedColor
        cell.selectedBackgroundView = myCustomSelectionColorView
        return cell
    }
}

