//
//  ViewController.swift
//  Flower-Recognition
//
//
//  Created by David
//  Copyright © 2017 David. All rights reserved.
//

import UIKit
import CoreML
import Vision // Apple's ML framework
import Alamofire
import SwiftyJSON
import SDWebImage   // Used to pull image


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // Base URL for WikiPedia API request
    let wikipediaURl = "https://en.wikipedia.org/w/api.php"

    
    let imagePicker = UIImagePickerController()
    
    // Info label on bottom screen
    @IBOutlet weak var label: UILabel!
    
    // Main image view
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set image properties
        imagePicker.delegate = self
        imagePicker.allowsEditing = true    // Allow user to crop image after selected (1 of 2)
        imagePicker.sourceType = .camera    // Use camera
    }

    // Image was selected ("Use Image")
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // If user selected image AND it can be converted to UIImage THEN convert to CIImage
        if let userPickedImage = info[UIImagePickerControllerEditedImage] as? UIImage { // info[x]: x = Allow user to crop image after selected (2 of 2)
        
            // Convert user picked image to CIImage (core image image)
            guard let convertedCIImage = CIImage(image: userPickedImage) else {
                // If fails throw error
                fatalError("Cannot convert to CIImage")
            }
            
            // Pass to Detect
            detect(image: convertedCIImage)
        
            // Set image view as user picked image
            //imageView.image = userPickedImage
            
        }
        
        // Once User is finished picking image, dismiss
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    func detect(image: CIImage) {
        
        // Create vision container
        guard let model = try? VNCoreMLModel(for: FlowerClassifier().model) else {
            // If model fails
            fatalError("Model cannot be imported")
        }
        
        // Create Request
        let request = VNCoreMLRequest(model: model) { (request, error) in
            
            // Look for where image was classified as
            guard let classification = request.results?.first as? VNClassificationObservation else {
                fatalError("No classification for this image")
            }
            
            // String that describes what the classification is IE: Name of flower
            // Set to top of screen
            self.navigationItem.title = classification.identifier.capitalized
            
            self.requestInfo(flowerName: classification.identifier)
        }
        
        // Handler to process request
        let handler = VNImageRequestHandler(ciImage: image)
        
        // Perform request
        do {
            try handler.perform([request])
        }
        catch {
            // Log any errors should it fail
            print(error)
        }
        
    }
    
    func requestInfo(flowerName: String) {
        
        // Params for parsing HTTP response
        let parameters : [String:String] = [
            "format" : "json",
            "action" : "query",
            "prop" : "extracts|pageimages",
            "exintro" : "",
            "explaintext" : "",
            "titles" : flowerName,
            "indexpageids" : "",
            "redirects" : "1",
            "pithumbsize" : "500"
            ]
        
        Alamofire.request(wikipediaURl, method: .get, parameters: parameters).responseJSON { (response) in
            // Response succeeds
            if response.result.isSuccess {
                print("Got wiki Info")
                print(response)
                
                // Store JSON response
                let flowerJSON : JSON = JSON(response.result.value!)
                
                // Parse response and grab page ID
                let pageid = flowerJSON["query"]["pageids"][0].stringValue // convert to string
                
                // Parse response and use page ID to find flower description
                let flowerDescription = flowerJSON["query"]["pages"][pageid]["extract"].stringValue // convert to string
                
                // Grab Wiki flower picture url
                let flowerImageURL = flowerJSON["query"]["pages"][pageid]["thumbnail"]["source"].stringValue
                
                // Display flower image with given wiki URL
                self.imageView.sd_setImage(with: URL(string: flowerImageURL))
                
                // Display label on screen
                self.label.text = flowerDescription
                
                
            }
        }
    }

    // Camera Button
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
        // Present image picker when 'Camera' Icon is tapped
        present(imagePicker, animated: true, completion: nil)
        
    }
}

