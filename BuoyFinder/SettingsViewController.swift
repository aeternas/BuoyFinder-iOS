//
//  SettingsViewController.swift
//  BuoyFinder
//
//  Created by Matthew Iannucci on 2/17/17.
//  Copyright © 2017 Matthew Iannucci. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase

class SettingsViewController: UITableViewController, GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        FIRAuth.auth()?.addStateDidChangeListener({ (_, _) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 3
        default:
            return 0
        }
    }
    
    override func  tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "User Interface"
        case 1:
            return "Account"
        case 2:
            return "About"
        default:
            return ""
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var reuseIdentifier = "subtitleCell"
        if indexPath.section == 2 {
            reuseIdentifier = "basicCell"
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Units"
                cell.detailTextLabel?.text = "Metric"
                break
            default:
                break
            }
            break
        case 1:
            switch indexPath.row {
            case 0:
                if let user = FIRAuth.auth()?.currentUser {
                    cell.textLabel?.text = "Logged in as \(user.email!)"
                    cell.detailTextLabel?.text = "Click to log out"
                } else {
                    cell.textLabel?.text = "Not Logged In"
                    cell.detailTextLabel?.text = "Click to log in and sync your favorites"
                }
               break
            default:
                break
            }
            break
        case 2:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Contact Developer"
                break
            case 1:
                cell.textLabel?.text = "Rate On The App Store"
                break
            case 2:
                cell.textLabel?.text = "Copyright 2017 Matthew Iannucci"
            default:
                break;
            }
            break
        default:
            break
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            break
        case 1:
            switch indexPath.row {
            case 0:
                if let _ = FIRAuth.auth()?.currentUser {
                    do {
                        try FIRAuth.auth()?.signOut()
                    } catch let signOutError as NSError {
                        print ("Error signing out: %@", signOutError)
                    }
                } else {
                    GIDSignIn.sharedInstance().signIn()
                }
                break
            default:
                break
            }
            break
        case 2:
            switch indexPath.row {
            case 0:
                let email = "rhodysurf13@gmail.com"
                let url = URL(string: "mailto:\(email)?subject=BuoyFinder for iOS")!
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                break
            case 1:
                let url = URL(string: "itms-apps://itunes.apple.com/app/id945847570")!
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                break
            default:
                break
            }
            break
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}