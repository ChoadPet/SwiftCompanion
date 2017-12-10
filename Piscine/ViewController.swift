
import UIKit

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var username: UITextField!
    
    var token: String?
    var student = Student()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignbackground()
        warningLabel.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        let KEY = "cc43ceb358106731d80f1632630654977e63db6d99de2b005dfd9cae3449bdb5"
        let SECRET = "ec0d99b9863a1b008785dba367d753450bb189be38be4e53823f2a8d0f7a5052"
        
        let BEARER = ((KEY + ":" + SECRET).data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        let url = URL(string: "https://api.intra.42.fr/oauth/token")
        var request = URLRequest(url: url! as URL)
        request.httpMethod = "POST"
        request.setValue("Basic " + BEARER, forHTTPHeaderField: "Authorization")
        request.httpBody = "grant_type=client_credentials&client_id=\(KEY)&client_secret=\(SECRET)".data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                do {
                    let dic = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                    self.token = (dic["access_token"] as? String)!
                }
                catch (let error){
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func getUser(by access_token: String, with user: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
        let url = URL(string: "https://api.intra.42.fr/v2/users/\(user)?access_token=\(access_token)")
        let request = URLRequest(url: url! as URL)
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let data = data {
                do {
                    if let response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        completion(response, nil)
                    }
                }
                catch (let error) {
                    print(error)
                }
            }
            completion(nil, error)
        }
        task.resume()
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func assignbackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background-image")
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondVC: SecondViewController = segue.destination as! SecondViewController
        secondVC.studentInfo = student
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        if (username.text?.isEmpty)! {
            warningLabel.isHidden = false
            warningLabel.backgroundColor = UIColor.yellow
            warningLabel.text = "Empty field. Please enter username"
        } else {
            let userName = (username.text?.removingWhitespaces())!
            print("Looking for: [\(userName)] user")
            if let token = self.token {
                getUser(by: token, with: userName, completion: { (response, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    if let response = response {
                        if !response.isEmpty {
                            if let imagePath = response["image_url"] as? String {
                                self.student.imagePath = imagePath
                            }
                            if let firstName = response["first_name"] as? String {
                                self.student.firstName = firstName
                            }
                            if let lastName = response["last_name"] as? String {
                                self.student.lastName = lastName
                            }
                            if let login = response["login"] as? String {
                                self.student.login = login
                            }
                            if let email = response["email"] as? String {
                                self.student.email = email
                            }
                            if let phone = response["phone"] as? String {
                                self.student.phone = phone
                            } else {
                                self.student.phone = "No phone number"
                            }
                            if let wallet = response["wallet"] as? Int {
                                self.student.wallet = wallet
                            }
                            if let correction_point = response["correction_point"] as? Int {
                                self.student.corrections = correction_point
                            }
                            if let location = response["location"] as? String {
                                self.student.location = "Available " + location
                            } else {
                                self.student.location = "Unavailable"
                            }
                            //TODO some problem with type
                            if let dictionary = response["cursus_users"] as? [NSDictionary] {
                                var cursus = NSDictionary()
                                for course in dictionary {
                                    if course.value(forKey: "cursus_id") as? Int == 1 {
                                        cursus = course
                                    }
                                }
                                if let level = cursus["level"] as? Float {
                                    self.student.level = level
                                } else {
                                    self.student.level = 0.0
                                }
                                if let dictionary = cursus["skills"] as? [NSDictionary] {
                                    for skill in dictionary {
                                        self.student.skills
                                    }
                                }
                            }
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: "toSecondView", sender: self)
                            }
                        } else {
                            print("User not found!")
                        }
                    }
                })
            }
            warningLabel.isHidden = true
        }
    }
}

