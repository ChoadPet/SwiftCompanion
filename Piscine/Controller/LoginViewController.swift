
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    var token: String?
    var student = Student()
    var request = Request(key: "cc43ceb358106731d80f1632630654977e63db6d99de2b005dfd9cae3449bdb5", secret: "ec0d99b9863a1b008785dba367d753450bb189be38be4e53823f2a8d0f7a5052")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        request.basicRequest() // Made request
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        assignbackground()
        warningLabel.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.request.student = Student()
    }
    
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -50 // Move view 150 points upward
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
    func dismissKeyboard() { view.endEditing(true) }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondVC: UserInfoTableViewController = segue.destination as! UserInfoTableViewController
        secondVC.studentInfo = self.request.student
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        if (username.text?.isEmpty)! {
            styleForWarningLbl(for: warningLabel, with: UIColor.yellow, text: "Empty field. Please enter username!")
        } else {
            customActivityIndicatory(self.view)
            warningLabel.isHidden = true
            let userName = (username.text?.removingWhitespaces())!
            print("Looking for: [\(userName)] user")
            if let token = self.request.token {
                self.request.getUser(by: token, with: userName, completion: { [weak self] (response, error) in // Call get func for getting student data
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    if let response = response {
                        if !response.isEmpty {
                            self?.request.setStudent(student: (self?.student)!, response: response) // Set self.student data from response
                            DispatchQueue.main.async {
                                self?.username.text = ""
                                self?.customActivityIndicatory((self?.view)!, startAnimate: false)
                                self?.performSegue(withIdentifier: "toUserInfo", sender: self)
                            }
                        } else {
                            DispatchQueue.main.async { [weak self] in
                                self?.customActivityIndicatory((self?.view)!, startAnimate: false)
                                self?.styleForWarningLbl(for: (self?.warningLabel)!, with: UIColor.red, text: "User not found!")
                            }
                        }
                    }
                })
            }
        }
    }
    
    func assignbackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background-image")
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    func styleForWarningLbl(for label: UILabel, with color: UIColor, text: String) {
        label.isHidden = false
        label.backgroundColor = color
        label.text = text
    }
    
    func customActivityIndicatory(_ viewContainer: UIView, startAnimate:Bool? = true) {
        
        let mainContainer: UIView = UIView(frame: viewContainer.frame)
        mainContainer.center = viewContainer.center
        mainContainer.backgroundColor = UIColor.black
        mainContainer.alpha = 0.6
        mainContainer.tag = 789456123
        mainContainer.isUserInteractionEnabled = false
        
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.frame = CGRect(x:0.0,y: 0.0,width: 40.0, height: 40.0)
        activityIndicatorView.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.whiteLarge
        activityIndicatorView.center = CGPoint(x: mainContainer.frame.size.width / 2, y: mainContainer.frame.size.height / 2)
        if startAnimate! {
            mainContainer.addSubview(activityIndicatorView)
            viewContainer.addSubview(mainContainer)
            activityIndicatorView.startAnimating()
        } else {
            for subview in viewContainer.subviews {
                if subview.tag == 789456123 {
                    subview.removeFromSuperview()
                }
            }
        }
    }
}

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
