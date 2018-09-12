//
//  PagingMenuViewController.swift
//  EnglishNewsApp
//
//  Created by 三上 綾介 on 2018/09/12.
//  Copyright © 2018年 Ryosuke Mikami. All rights reserved.
//

import UIKit

class PagingMenuViewController1: UIViewController,UITableViewDelegate,UITableViewDataSource,XMLParserDelegate{
    
    // TableView のインスタンスを生成
    var tableView:UITableView = UITableView()
    
    // XMLParser のインスタンスを生成
    var parser = XMLParser()
    
    // テーブル内の列を可変な配列クラス(要素数を追加、挿入、削除など変更できる) NSMutableArrayのインスタンスを生成
    var rows = NSMutableArray()
    
    // 今回は item タグ内を取得。item で固定なので Stringクラスでインスタンスを生成
    var element = String()
    
    // キー:title、値: ＠＠＠、キー:link、値: ＠＠＠、と値が変わるので可変な辞書クラスNSMutableDictionary インスタンスを生成
    var elements = NSMutableDictionary()
    
    // title タグ内の値を格納。値が変わるので、NSMutableString
    var titleString = NSMutableString()
    
    // link タグ内の値を格納。値が変わるので、NSMutableString
    var linkString = NSMutableString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 列の数を初期化
        rows = []
        
        // tableViewを作成
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 54.0)
        tableView.backgroundColor = UIColor.red
        self.view.addSubview(tableView)
        
        // xmlを解析(パース)
        let urlString:String = "http://news.yahoo.co.jp/pickup/entertainment/rss.xml"
        let url:URL = URL(string:urlString)!
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        parser.parse()
        tableView.reloadData()
    }
    
    // セルの高さを設定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    // セクションの数を設定
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // セクション内の列の数を設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    // 列ごとのセルに値を設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        
        // タイトル(title)
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.text = (rows[indexPath.row] as AnyObject).value(forKey: "title") as? String
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        cell.textLabel?.textColor = UIColor.white
        
        // サブタイトル(link)
        cell.detailTextLabel?.text = (rows[indexPath.row] as AnyObject).value(forKey: "link") as? String
        cell.detailTextLabel?.font = UIFont.boldSystemFont(ofSize: 9.0)
        cell.detailTextLabel?.textColor = UIColor.white
        
        return cell
    }
    
    // 開始タグ
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        element = elementName
        
        if element == "item" {
            
            elements = NSMutableDictionary()
            elements = [:]
            titleString = NSMutableString()
            titleString = ""
            linkString = NSMutableString()
            linkString = ""
        }
    }
    
    // 開始タグと終了タグの間にデータが存在した時
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if element == "title"{
            
            titleString.append(string)
            
        } else if element == "link"{
            
            linkString.append(string)
            
        }
    }
    
    // 終了タグ
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        // 要素 item だったら
        if elementName == "item"{
            
            // titleString の中身が空でないなら
            if titleString != "" {
                // elementsにキー: title を付与して、titleString をセット
                elements.setObject(titleString, forKey: "title" as NSCopying)
            }
            
            // linkString の中身が空でないなら
            if linkString != "" {
                // elementsにキー: link を付与して、 linkString をセット
                elements.setObject(linkString, forKey: "link" as NSCopying)
            }
            
            // rowsの中にelementsを加える
            rows.add(elements)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
