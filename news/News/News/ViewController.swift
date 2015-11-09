

import UIKit

import Alamofire
import SCLAlertView_Objective_C
import SwiftyJSON
import SDWebImage
import EAIntroView

class ViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate,EAIntroDelegate{
    
    var tableSendData = News()
    var newsData:NSData = NSData()
    var newsArray:[News] = []
    
    @IBOutlet weak var newstitle: UILabel!
    @IBOutlet weak var newsimg: UIImageView!
    @IBOutlet weak var sendbtn: UIButton!
    
    @IBOutlet weak var tiyunewstableview: UITableView!
    
    let myKey="19fee1afd34f31fbd5f6a64c1d8d1b7a"
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let url = TIYU_NEWS_LIST
        let httpArg = "num=10&page=1"
        request(url, httpArg: httpArg)
        
        // talbleview Source
        tiyunewstableview.dataSource = self
        tiyunewstableview.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func getGuidView(){
        
        let page1 = EAIntroPage()
        page1.title = "体育"
        page1.desc = "体育新闻"
        page1.bgImage = UIImage(named: "image1.jpg")
        page1.titleFont = UIFont.systemFontOfSize(20)
        page1.titlePositionY = 40
        
        let page2 = EAIntroPage()
        page2.title = "国际"
        page2.desc = "国际新闻"
        page2.bgImage = UIImage(named: "image2.jpg")
        page2.titleFont = UIFont.systemFontOfSize(20)
        page2.titlePositionY = 40

        
        let page3 = EAIntroPage()
        page3.title = "个人"
        page3.desc = "个人新闻"
        page3.bgImage = UIImage(named: "image3.jpg")
        page3.titleFont = UIFont.systemFontOfSize(20)
        page3.titlePositionY = 40

        let intro = EAIntroView(frame: self.view.frame,andPages:[page1,page2,page3])
        intro.delegate = self
        intro.showInView(self.view)
        
    }
    
    //体育数据转成实体
    func getModael(data:NSData) -> NSArray{
        
        print("start Json to Model")
        //        println(data)
        var newsArrayData:[News] = []
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
            newsArrayData.append(new)
            
        }
        
        return newsArrayData
        
    }
    // tableview 方法
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return Int(1)
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellid = "tiyunewscellid"
        var cell = tiyunewstableview.dequeueReusableCellWithIdentifier(cellid)
        
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellid)
        }
        
        cell?.textLabel?.text = self.newsArray[indexPath.row].newsTitle
        cell?.detailTextLabel?.text = self.newsArray[indexPath.row].newsDescription
        cell?.imageView?.sd_setImageWithURL(NSURL(string:self.newsArray[indexPath.row].newsPicUrl as String),placeholderImage: UIImage(named: "default_showPic.png"))
        
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        print(indexPath.row)
        let vc = NewView(nibName: "NewView", bundle: nil);
        vc.tiyunews = self.newsArray[indexPath.row]
        let nc = self.navigationController
        nc!.pushViewController(vc, animated: true)
        
        self.tableSendData = newsArray[indexPath.row]
        
    }
    // get data
    func getreq(url:String,httpArg:String) -> NSMutableURLRequest {
        
        let req = NSMutableURLRequest(URL: NSURL(string: url + "?" + httpArg)!)
        req.timeoutInterval = 6
        req.HTTPMethod = "GET"
        req.addValue(self.myKey, forHTTPHeaderField: "apikey")
        return req
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func  request(httpUrl: String, httpArg: String) {
        let req = getreq(httpUrl, httpArg: httpArg)
        Alamofire.request(req).response { _, _, d,_ in
            self.newsArray = self.getModael(d!) as! [News]
            self.tiyunewstableview.reloadData()
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    print("11111111")
                    self.newstitle.text = self.newsArray[1].newsTitle
                    self.newsimg.sd_setImageWithURL(NSURL(string:(self.newsArray[1].newsPicUrl as String)),placeholderImage: UIImage(named: "default_showPic.png"))
            })
            
        }
        
    }
}

