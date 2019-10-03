//
//  ViewController.swift
//  ToDoey05
//
//  Created by 田中陽子 on 2019/09/27.
//  Copyright © 2019 Yoko Tanaka. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "温泉行きたい"
        itemArray.append(newItem)
        
        load()
//
//        let newItem2 = Item()
//        newItem.title = "Find 2"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem.title = "Find 3"
//        itemArray.append(newItem3)
        // ユーザーデフォルトの値、もしキーがなかったらオプショナルとして
//        if let items = defaults.array(forKey: "ToDoListArray")as?[String]{
//            itemArray = items
//        }
//
    }
    //tableView Datasourceメソッド
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for:indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        //チェックマークのクリックしたとき
//        if itemArray[indexPath.row].done == true{
//            cell.accessoryType = .checkmark
//        }else{
//            cell.accessoryType = .none
//        }
        
        return cell
        
    }
    //tableView Dalegateメソッド
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        
        //選択した行を教える
        if itemArray[indexPath.row].done == false{
            itemArray[indexPath.row].done = true
        }else{
            itemArray[indexPath.row].done = false
        }
        
        
    //セルのアクセサリのチェックマークをクリックしたらつける、このインデックスパスはローカル変数
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none //最初はついてない

        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark //それ以外はチェックマークがついていない場合はつける
        }
        
        tableView.deselectRow(at: indexPath, animated: true)//選択したグレー
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "タイトルを追加してください", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "タイトルを入力", style: .default) { (action) in
//            print(textField.text)//ここに入力したものを反映したい
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            do {
                // 機械が読めるようにエンコードしている。
                let data = try PropertyListEncoder().encode(self.itemArray)
                // "ToDoListArray" のキーで保存している。
                self.defaults.set(data, forKey: "ToDoListArray")//ユーザーデフォルトのキー、これがエラーになってしまう
            }catch {
                fatalError()
            }
            
            self.tableView.reloadData()//新しい配列をtableviewに反映する
            
            
        }
        
        alert.addTextField { (alertTextField) in
        
            alertTextField.placeholder = "新しいアイテムを作成"
            textField = alertTextField
            
//            print(alertTextField.text)
//            print("Now")
        }
        
        //addボタンを押した時のアラートアクション実行
        alert.addAction(action)
        
        present(alert,animated: true,completion: nil)
        
        
    }
    
    private func load() {
        // "ToDoListArray" のキーで取り出している。
        guard let data = defaults.data(forKey: "ToDoListArray") else { return }
        do {
            // 人間が読めるように、デコードしている。
            let items = try PropertyListDecoder().decode([Item].self, from: data)
            self.itemArray = items
        } catch {
            fatalError ("Cannot Load.")
        }
    }
    
    func test() {
        print("test")
    }
    
    // スワイプで削除
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        itemArray.removeTask(at: indexPath.row)
//    }


}

//class yamatatsu {
//    func yamamoto() {
//        ToDoListViewController().test()
//        ToDoListViewController().load()
//    }
//}

