//
//  PagingMenuViewController.swift
//  EnglishNewsApp
//
//  Created by 三上 綾介 on 2018/09/12.
//  Copyright © 2018年 Ryosuke Mikami. All rights reserved.
//

import UIKit

class PagingMenuViewController3: UIViewController,UITableViewDelegate,UITableViewDataSource,XMLParserDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    let feedUrl = URL(string: "http://feeds.bbci.co.uk/news/video_and_audio/business/rss.xml")!
    var feedItems = [CeedItem]()
    
    var currentElementName : String! // RSSパース中の現在の要素名
    
    let ITEM_ELEMENT_NAME   = "item"
    let TITLE_ELEMENT_NAME  = "title"
    let LINK_ELEMENT_NAME   = "link"
    let DESCRIPTION_ELEMENT_NAME = "description"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
        let feedItem = self.feedItems[indexPath.row]
        cell.textLabel?.text = feedItem.title
        cell.detailTextLabel?.text = feedItem.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let feedItem = self.feedItems[indexPath.row]
        UIApplication.shared.open(URL(string: feedItem.url)!, options: [:], completionHandler: nil)
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        self.currentElementName = nil
        if elementName == ITEM_ELEMENT_NAME {
            self.feedItems.append(CeedItem())
        } else {
            currentElementName = elementName
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if self.feedItems.count > 0 {
            let lastItem = self.feedItems[self.feedItems.count - 1]
            switch self.currentElementName {
            case TITLE_ELEMENT_NAME:
                let tmpString = lastItem.title
                lastItem.title = (tmpString != nil) ? tmpString! + string : string
            case LINK_ELEMENT_NAME:
                lastItem.url = string
            case DESCRIPTION_ELEMENT_NAME:
                lastItem.description = string
            default: break
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        self.currentElementName = nil
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let parser: XMLParser! = XMLParser(contentsOf: feedUrl)
        parser.delegate = self
        parser.parse()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class CeedItem {
    var title: String!
    var url: String!
    var description: String!
}
