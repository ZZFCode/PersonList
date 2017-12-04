//
//  LIstTableViewController.swift
//  通讯录
//
//  Created by AVIC_IOS_ZZF on 2017/12/1.
//  Copyright © 2017年 AVIC_IOS_ZZF. All rights reserved.
//

import UIKit

class LIstTableViewController: UITableViewController {

    var personList = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData { (list) in
            self.personList = list
            
            self.tableView.reloadData()
        }
    }
    
    private func loadData(completion:@escaping (_ list:[ Person])->()) -> (){
        DispatchQueue.global().sync {
            print("正在努力加载中")
            Thread.sleep(forTimeInterval: 1)
            var arrayM = [Person]()
            for i in 0 ..< 20 {
                let p = Person()
                p.name = "ZhangSan - \(i)"
                p.phone = "186" + String(format:"%07d",arc4random_uniform(1000000))
                p.title = "BOSS"
                arrayM.append(p)
            }
            DispatchQueue.main.async(execute: {
                //回调,执行闭包
                completion(arrayM)
            })
        }
    }

    //添加新的联系人
    @IBAction func addNewPerson(_ sender: Any) {
        //执行segue跳转
        performSegue(withIdentifier: "listToDetial", sender: nil)
        
    }
    // MARK: - 控制器跳转的方法
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetialTableViewController
        //设置选中的person,indexPath
        if let indexPath = sender as? IndexPath {
            //indexPath一定有值
            vc.person = personList[indexPath.row]
            vc.completionCallBack = {
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }else{
            //新建联系人
            vc.completionCallBack = {
                //1 获取明细控制器的person
                guard let p = vc.person else{
                    return
                }
                //2 插入数组中
                self.personList.insert(p, at: 0)
                //3 刷新表格
                self.tableView.reloadData()
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        cell.textLabel?.text = personList[indexPath.row].name
        cell.detailTextLabel?.text = personList[indexPath.row].phone
        
        return cell
    }

    //MARK: - tableview代理方法
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //执行segue
        performSegue(withIdentifier: "listToDetial", sender: indexPath)
    }
    

}
