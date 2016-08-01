//
//  ViewController.swift
//  SwiftCD
//
//  Created by Sridhar Sanapala on 7/29/16.
//  Copyright © 2016 everythingswift. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func createGradeTapped(sender: AnyObject) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate!

        //Create Core Data Object
        let grade = NSEntityDescription.insertNewObjectForEntityForName("Grade", inManagedObjectContext: appDelegate._managedObjectContext!) as! Grade
        grade.name = "KinderGarten"

        do {
            try appDelegate!._managedObjectContext!.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }

        //Fetch Core Data Object
        let moc = appDelegate!._managedObjectContext
        let fetchGradeRequest = NSFetchRequest(entityName: "Grade")
        var fetchedGrades:[Grade]!

        do {
            fetchedGrades = try moc!.executeFetchRequest(fetchGradeRequest) as! [Grade]
        } catch {
            fatalError("Failed to fetch Grades: \(error)")
        }

        if fetchedGrades.count > 0{
            print("Found Grade objects")
        }else{
            print("Cannot find Grade objects")
        }

    }

    @IBAction func createStudentTapped(sender: AnyObject) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate!

        //Fetch Grade Object
        let moc = appDelegate!._managedObjectContext
        let fetchGradeRequest = NSFetchRequest(entityName: "Grade")
        var fetchedGrades:[Grade]!
        
        do {
            fetchedGrades = try moc!.executeFetchRequest(fetchGradeRequest) as! [Grade]
        } catch {
            fatalError("Failed to fetch Grades: \(error)")
        }

        let grade = fetchedGrades.first
        //Create Student Objects

        let student1 = NSEntityDescription.insertNewObjectForEntityForName("Student", inManagedObjectContext: appDelegate!._managedObjectContext!) as! Student
        student1.firstname = "John"
        student1.studentgrade = grade

        let student2 = NSEntityDescription.insertNewObjectForEntityForName("Student", inManagedObjectContext: appDelegate!._managedObjectContext!) as! Student
        student2.firstname = "Lily"
        student2.studentgrade = grade

        do {
            try appDelegate!._managedObjectContext!.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }

        let fetchStudentRequest = NSFetchRequest(entityName: "Student")
        var fetchedStudents:[Student]!

        do {
            fetchedStudents = try moc!.executeFetchRequest(fetchStudentRequest) as! [Student]
        } catch {
            fatalError("Failed to fetch Students: \(error)")
        }
        
        if fetchedStudents.count > 0{
            print("Found Student objects")
        }else{
            print("Cannot find Student objects")
        }

    }
}

