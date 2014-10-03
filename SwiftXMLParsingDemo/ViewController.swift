//
//  ViewController.swift
//  SwiftXMLParsingDemo
//

import UIKit

class ViewController: UIViewController,NSXMLParserDelegate {
    
    var strXMLData:String = ""
    var currentElement:String = ""
    var passData:Bool=false
    var passName:Bool=false

    @IBOutlet var lblNameData : UILabel! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var url:String="http://api.androidhive.info/pizza/?format=xml"
        var urlToSend: NSURL = NSURL(string: url)
        // Parse the XML
        var parser = NSXMLParser(contentsOfURL: urlToSend)
        parser.delegate = self
        
        var success:Bool = parser.parse()
        
        if success {
            println("parse success!")
            
            println(strXMLData)
            
            lblNameData.text=strXMLData
            
        } else {
            println("parse failure!")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parser(parser: NSXMLParser!,didStartElement elementName: String!, namespaceURI: String!, qualifiedName : String!, attributes attributeDict: NSDictionary!) {
        currentElement=elementName;
        if(elementName=="id" || elementName=="name" || elementName=="cost" || elementName=="description")
        {
            if(elementName=="name"){
                passName=true;
            }
            passData=true;
        }
    }
    
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
        currentElement="";
        if(elementName=="id" || elementName=="name" || elementName=="cost" || elementName=="description")
        {
            if(elementName=="name"){
                passName=false;
            }
            passData=false;
        }
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!) {
        if(passName){
            strXMLData=strXMLData+"\n\n"+string
        }
        
        if(passData)
        {
            println(string)
        }
    }
    
    func parser(parser: NSXMLParser!, parseErrorOccurred parseError: NSError!) {
        NSLog("failure error: %@", parseError)
    }
}

