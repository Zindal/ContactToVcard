//
//  ViewController.swift
//  ConatctV
//
//  Created by zindal on 02/10/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let arr = getAllContacts()
        print(arr.count)
        self.saveContacts(contacts: arr)

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func saveContacts(contacts : [CNContact]) {
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let fileURL = URL.init(fileURLWithPath: documentsPath.appending("/Contacts.vcf"))
        
        let data : NSData?
        do {
            
            try data = CNContactVCardSerialization.data(with: contacts) as! NSData
            
            do {
                try data?.write(to: fileURL, options: .atomic)
                print(fileURL.absoluteString)
            }
            catch {
                print("Failed to write!")
            }
        }
        catch {
            
            print("Failed!")
        }
    }
    

    
    func getAllContacts() -> [CNContact]
    {
        var contactArr : [CNContact] = []
        let contatcStore = CNContactStore()
        let fetchRequest = CNContactFetchRequest.init(keysToFetch: [CNContactVCardSerialization.descriptorForRequiredKeys()])
        
       try! contatcStore.enumerateContacts(with: fetchRequest) { (contact, end) in
            
            contactArr.append(contact)
        }
        
        return contactArr
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

