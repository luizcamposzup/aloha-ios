//
//  FormValidation.swift
//  AlohaIOS
//
//  Created by zupper on 13/12/19.
//  Copyright © 2019 Luizhcarminati. All rights reserved.

import UIKit

struct AutoCompleteData {
    static let autoCompleteDataInstance = AutoCompleteData()
    
    var autoCompleteData = AutoComplete()
    
    mutating func setInstance(instance: AutoComplete) {
        self.autoCompleteData = instance
    }
    
    func getInstance() -> AutoComplete {
        return autoCompleteData
    }
}

class AutoComplete: UIView {
    public var dataSource = [String]()
    public var onTextField : UITextField!
    public var completionHandler: CompletionHandler?
    var tableView : UITableView?
    public var dropDownHeight : CGFloat?
    public var onView : UIView?
    var filterDataSource = [String]()
    public var indexPath : IndexPath?
    private var isMultiLine  = false
    public var cellHeight : CGFloat!
    public var showAlwaysOnTop = false
    var is_filter = false
    private var isOnTop = false
    typealias CompletionHandler = (_ text: String , _ index : Int) -> Void
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Show DropDown
    public func show(completionHandler: @escaping CompletionHandler) {
        self.tableView?.frame = CGRect(x: 0, y: 0, width: onTextField.frame.width, height: 150)
        self.frame = CGRect(x: onTextField.frame.minX, y: onTextField.frame.maxY+40, width: onTextField.frame.width, height: 150)
        onTextField.addTarget(self, action: #selector(didBeganText(textField:)), for: .editingDidBegin)
        onTextField.addTarget(self, action: #selector(didChangeText(textField:)), for: .editingChanged)
        onTextField.addTarget(self, action: #selector(didEndText(textField:)), for: .editingDidEnd)
        self.addSubview(tableView!)
        self.onView?.addSubview(self)
        self.alpha = 0
        self.isHidden = true
        self.tableView?.alpha = 0
        self.tableView?.isHidden = true
        self.completionHandler = completionHandler
    }
    
    // MARK: - SetUp View
    private func setUp() {
        self.tableView = UITableView()
        self.tableView?.register(UINib(nibName: "AutoCompleteViewCell", bundle: nil),
                                 forCellReuseIdentifier: "AutoCompleteViewCell")
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.tableFooterView = UIView()
        self.tableView?.layer.cornerRadius = 10
        self.tableView?.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.cellHeight = 60
    }
    
    @objc func didChangeText(textField: UITextField) {
        if let textInField = onTextField.text {
            if textInField.count == 0{
                is_filter = false
                self.tableView?.reloadData()
            }else{
                is_filter = true
                let tempData = dataSource.filter{ $0.localizedCaseInsensitiveContains(textInField) }
                filterDataSource = tempData
                self.isShowView(is_show: true)
                self.tableView?.reloadData()
            }
        }
    }
    
    @objc func didBeganText(textField: UITextField) {
        self.isShowView(is_show: true);
    }
    
    @objc func didEndText(textField: UITextField) {
        is_filter = false
        self.isShowView(is_show: false)
        self.tableView?.reloadData()
    }
    
    private func isShowView(is_show : Bool) {
        if !self.isHidden && is_show{ return }
        if is_show {
            self.alpha = 0
            self.isHidden = false
            self.tableView?.alpha = 0
            self.tableView?.isHidden = false
            self.tableView?.separatorStyle = .none
            UIView.animate(withDuration: 0.3) {
                self.alpha = 1
                self.tableView?.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.tableView?.alpha = 0
                self.alpha = 0
            }) { (finished) in
                self.tableView?.isHidden = finished
                self.isHidden = finished
            }
        }
    }
    
    private func changeHeightForCount(count: Int) {
        if cellHeight == nil { return }
        var newFrame = self.frame
        newFrame.size.height = cellHeight * CGFloat(count)
        self.frame = newFrame
        self.tableView?.frame = CGRect(x: 0, y: 0, width: newFrame.width, height: newFrame.height)
        self.setNeedsLayout()
    }
    
    private func attributedText(withString string: String, boldString: String, font: UIFont) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: [NSAttributedString.Key.font: font])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font.withSize(font.pointSize + 3)]
        let range = (string as NSString).range(of: boldString, options: .caseInsensitive)
        attributedString.addAttributes(boldFontAttribute, range: range)
        return attributedString
    }
}

// MARK: - TableView Delegate
extension AutoComplete : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if is_filter {
            let selectedStr = filterDataSource[indexPath.row]
            let selectedIndex = dataSource.firstIndex(of: selectedStr)
            self.isShowView(is_show: false)
            self.completionHandler!(selectedStr, selectedIndex!)
            return
        }
        let selectedStr = dataSource[indexPath.row]
        let selectedIndex = indexPath.row
        self.isShowView(is_show: false)
        self.completionHandler!(selectedStr, selectedIndex)
    }
}

// MARK: - TableView DataSource
extension AutoComplete : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if is_filter{
            self.changeHeightForCount(count: self.filterDataSource.count < 4 ? self.filterDataSource.count : 3)
            return self.filterDataSource.count
        }
        self.changeHeightForCount(count: self.dataSource.count < 4 ? self.dataSource.count : 3)
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AutoCompleteViewCell") as! AutoCompleteViewCell
        if is_filter {
            cell.lblTitle.text = filterDataSource[indexPath.row]
        }else{
            cell.lblTitle.text = dataSource[indexPath.row]
        }

        let formattedString = self.attributedText(withString: cell.lblTitle.text!, boldString: onTextField.text!, font: onTextField.font!)
        cell.lblTitle.attributedText = formattedString
        return cell
    }
}

extension AutoComplete {
    func heightForLabel(text:String) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x:0, y:0, width: self.onTextField.frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = self.onTextField.font
        label.text = text
        label.sizeToFit()
        return label.frame.height + 20
    }
    
    @objc func keyboarDidShown(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        var aRect : CGRect = (self.onView?.frame)!
        aRect.size.height -= keyboardSize!.height
        if (self.onTextField) != nil {
            if aRect.height < (self.frame.origin.y + self.frame .height) {
                if !isOnTop {
                    self.frame = CGRect(x: onTextField.frame.minX, y: self.frame.origin.y - self.frame.height - self.onTextField.frame.height, width: onTextField.frame.width, height: self.frame.height)
                    isOnTop = true
                    self.setNeedsDisplay()
                }
            }
        }
    }
}

// MARK: - Height for text
extension String {
    func height(constraintedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.text = self
        label.font = font
        label.sizeToFit()
        return label.frame.height + 30
    }
}

