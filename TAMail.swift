//
//  TAMail.swift
//  TFreport
//
//  Created by 朝井鴻輝 on 2016/03/07.
//  Copyright © 2016年 teA.AsaiKoki. All rights reserved.
//

import UIKit

/*
    @class TAMail v1.1
    
    @propety
        mailAddress:NSURL           { get }
        subject:String!             { get set }
        body:String!                { get set }
        delegate:TAMailDelegate?    { get set }
    
    @method
        init(mailto:NSURL?)

        openMailer()
*/

/*  Sample
    let address = NSURL(string: "xxx@xxx.ne.jp")
    let mail    = TAMail(mailto: address)
    mail.delegate   = self
    mail.subject    = "お問い合わせ"
    mail.body       = "[お問い合わせ内容をお書きください]"
    mail.openMailer()
*/


@objc public protocol TAMailDelegate{
    /** メーラーが開かれる直前に呼ばれる
        ture:通常通りメーラーを開く
        false:メーラーを開かない
     */
    optional func mailerWillOpen(mail:TAMail)->Bool
    /** メーラーが開かれた後に呼ばれる */
    optional func mailerDidOpen()
}

public class TAMail:NSObject {
    //--------------------------------------------------------------------------------------
    //MARK: - Property
    
    private(set) var mailAddress:NSURL
    
    public var subject:String!{
        willSet{if newValue == nil {fatalError("Cannot set nil")}}
        didSet{ //エスケープ
            self.subject = self.subject.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.alphanumericCharacterSet())
        }
    }
    
    public var body:String! {
        willSet{if newValue == nil {fatalError("Cannot set nil")}}
        didSet{ //エスケープ
            self.body = self.body.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.alphanumericCharacterSet())
        }
    }
    
    public var delegate:TAMailDelegate?
    
    //--------------------------------------------------------------------------------------
    //MARK: - Init

    override init() {fatalError("Please use init(mailto:)")}
    
    init(mailto address:NSURL?){
        if address == nil {fatalError("Invalid address")}
        self.mailAddress    = address!
        self.subject        = ""
        self.body           = ""
    }
    
    //--------------------------------------------------------------------------------------
    //MARK: - Method

    public func openMailer(){
        let mailString  = "mailto:\(self.mailAddress)?Subject=\(self.subject)&Body=\(self.body)"
        let mailUrl     = NSURL(string: mailString)
        
        //メーラを開くかどうかデリゲートする
        if self.delegate?.mailerWillOpen?(self) == false {return}
        
        //メーラーを開く
        UIApplication.sharedApplication().openURL(mailUrl!)
        
        //メーラを開いた後の処理をデリゲート
        self.delegate?.mailerDidOpen?()
    }
    
}
