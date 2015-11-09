
import UIKit

class UserViewController: UIViewController , UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var myTableView: UITableView!
    
    var names: [String: [String]]!
    var keys: [String]!
    
    let sectionsTableIdentifier = "user"
    
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//      self.navigationTitle.text = "个人"
        
        myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: sectionsTableIdentifier)
        
        let path = NSBundle.mainBundle().pathForResource("user", ofType: "plist")
        let namesDict = NSDictionary(contentsOfFile: path!)
        names = namesDict as! [String: [String]]
        keys = namesDict!.allKeys as! [String]
        
        print(names)
        print(keys)
        
        myTableView.sectionIndexBackgroundColor = UIColor.blackColor()
        myTableView.sectionIndexTrackingBackgroundColor = UIColor.darkGrayColor()
        myTableView.sectionIndexColor = UIColor.whiteColor()
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return keys.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = keys[section]
        let nameSection = names[key]!
        return nameSection.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCellWithIdentifier(sectionsTableIdentifier, forIndexPath: indexPath)
            
        let ise = indexPath.section
//        let irow = indexPath.row
        
        if ise != 2{
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            
        }
        
        print("\(indexPath.section)---\(indexPath.row)")
        let key = keys[indexPath.section]
        let nameSection = names[key]!
        print("\(indexPath.section):\(key)---\(indexPath.row):\(nameSection)")

        cell.textLabel?.font = UIFont(name: "HiraKakuProN-W3", size: 14)
        cell.textLabel?.text = nameSection[indexPath.row]
        
        
//         print("登录状态：\(loginState)")
//        if loginState{
//            if indexPath.section == 0 && indexPath.row == 0{
//                cell.textLabel?.text = userWeibo.nickname
//            }
//            
//        }
        
        return cell
    }
    
    override func viewWillAppear(animated: Bool) {
        
//        if loginState{
//            myTableView.reloadData()
//        }
        
        myTableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
