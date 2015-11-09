

import UIKit

class NewView: UIViewController {

    @IBOutlet weak var web: UIWebView!

    var tiyunews = News()
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        print("newsTitle___"+tiyunews.newsTitle)
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.getHtmlView()
        })
        
        // Do any additional setup after loading the view.
    }
    
    func getHtmlView(){
        
        let htmlUrl = NSURL(string: self.tiyunews.newsUrl)
        self.web.loadRequest(NSURLRequest(URL: htmlUrl!))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
