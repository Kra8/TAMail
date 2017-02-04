# TAMail

Swift3よりデフォルトでメーラーが使用可能になったため、更新停止。

> swift2.xまでは対応。

# Usage  
``` Swift
    let address = NSURL(string: "xxx@xxx.ne.jp")
    let mail    = TAMail(mailto: address)
    mail.delegate   = self
    mail.subject    = "お問い合わせ"
    mail.body       = "[お問い合わせ内容をお書きください]"
    mail.openMailer()
```
