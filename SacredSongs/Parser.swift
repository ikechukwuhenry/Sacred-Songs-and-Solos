//
//  Parser.swift
//  SacredSongs
//
//  Created by MAC on 04/05/2016.
//  Copyright © 2016 Ikhub. All rights reserved.
//

import Foundation

class Parser {
    //let path = "allsongs"
    func createDataFromFile(_ filename: String, ofType:String)-> Data{
        let path = Bundle.main.path(forResource: filename, ofType: ofType)
        let data: Data = try! Data(contentsOf: URL(fileURLWithPath: path!))
        print(data)
        return data
    }
    
    func parseData(_ data: Data) -> [Hymn]?{
         var hymns: [Hymn] = [Hymn]()
        do {
            let array = try JSONSerialization.jsonObject(with: data, options: []) as! NSArray
            guard let dict = array as? [[String: AnyObject]] else { return nil }
            for song in dict{
                guard let index = song["index"] as? Int, let title = song["title"] as? String, let hasChorus = song["hasChorus"] as? Bool, let chorus = song["chorus"] as? String, let verses = song["verses"] as? [String] else { return nil }
                
                let hymn = Hymn(index: index, title: title, hasChorus: hasChorus, chorus: chorus, verses: verses)
                hymns.append(hymn)
                
                
            }
            
        }catch {
            print("could not parse json")
        }
        
        return hymns
    }
}
