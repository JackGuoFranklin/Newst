

import UIKit

import Alamofire
import SCLAlertView_Objective_C
import SwiftyJSON
import SDWebImage

class GuoJiNews: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var gjTableView: UITableView!
    var  gjNews = News()
    var  gjNewsArray:[News] = []
   
    @IBOutlet weak var gjImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gjTableView.delegate = self
        gjTableView.dataSource = self
        
        let url = GUOJI_NEWS_LIST
        
        let httpArg = "num=10&page=1"
        request(url, httpArg: httpArg)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gjNewsArray.count
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let gjnewsitem = "gjnewsitem"
        var cell = gjTableView.dequeueReusableCellWithIdentifier(gjnewsitem)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: gjnewsitem)
        }
        
        cell?.textLabel?.text = gjNewsArray[indexPath.row].newsTitle
        cell?.detailTextLabel?.text = gjNewsArray[indexPath.row].newsDescription
        cell?.imageView?.sd_setImageWithURL(NSURL(string:self.gjNewsArray[indexPath.row].newsPicUrl as String),placeholderImage: UIImage(named: "default_showPic.png"))
        
        return cell!
        
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        print(indexPath.row)
        
        let vc = NewView(nibName: "NewView", bundle: nil);
        vc.tiyunews = self.gjNewsArray[indexPath.row]
        let nc = self.navigationController
        nc!.pushViewController(vc, animated: true)
        
        
    }
    
    //体育数据转成实体
    func getModael(data:NSData) -> NSArray{
        
        print("start Json to Model")
        //        println(data)
        var gjNewsArray:[News] = []
        var json = JSON(data:data)
        var keyArray:[String] = [String]()
        
        for var i = 0 ;i<json.count-2; ++i{
            keyArray.append(String(i))
        }
        for var i = 0 ;i<json.count-2; ++i{
            
            let new = News()
            new.newsTitle = json[keyArray[i]]["title"].string!
            new.newsPicUrl = json[keyArray[i]]["picUrl"].string!
            new.newsUrl = json[keyArray[i]]["url"].string!
            new.newsTime = json[keyArray[i]]["time"].string!
            new.newsDescription = json[keyArray[i]]["description"].string!
            gjNewsArray.append(new)
            
        }
        
        return gjNewsArray
        
    }

    // get req
    func getreq(url:String,httpArg:String) -> NSMutableURLRequest {
        
        let req = NSMutableURLRequest(URL: NSURL(string: url + "?" + httpArg)!)
        req.timeoutInterval = 6
        req.HTTPMethod = "GET"
        req.addValue(MY_KEY, forHTTPHeaderField: "apikey")
        return req
        
    }
    
    func  request(httpUrl: String, httpArg: String) {
        
        let req = getreq(httpUrl, httpArg: httpArg)
        
        Alamofire.request(req).response { _, _, d,_ in
            self.gjNewsArray = self.getModael(d!) as! [News]
            self.gjTableView.reloadData()
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                print("11111111")
                self.gjImg.sd_setImageWithURL(NSURL(string:(self.gjNewsArray[1].newsPicUrl as String)),placeholderImage: UIImage(named: "default_showPic.png"))
            })
            
        }
        
    }
    
}
