//
//  DetialTableViewController.swift
//  通讯录
//
//  Created by AVIC_IOS_ZZF on 2017/12/1.
//  Copyright © 2017年 AVIC_IOS_ZZF. All rights reserved.
//

import UIKit

class DetialTableViewController: UITableViewController {

    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var phoneTf: UITextField!
    @IBOutlet weak var titleTf: UITextField!
    var person:Person?
    
    //闭包是可选的
    var completionCallBack:(()->())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        //判断person是否有值,如果有设置UI
        guard let person = person else {
            self.person = Person()
            return
        }
        nameTf.text = person.name
        phoneTf.text = person.phone
        titleTf.text = person.title
    }
    
    //MARK: - tableview代理
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    //保存
    @IBAction func save(_ sender: Any) {
        //1 用UI更新person的内容
        person?.name = nameTf.text
        person?.phone = phoneTf.text
        person?.title = titleTf.text
        
        //1.1 执行闭包回调
        //! 强行解包,如果没有值,就会崩溃
        //? 可选解包,如果闭包为nil,就什么都不做
        completionCallBack?()
        
        
        //2 返回上一级页面
        navigationController?.popViewController(animated: true)
    }
    

}
