//
//  ResultViewController.swift
//  QuizApp
//
//  Created by Zaki on 17.04.2023.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet var animalTypeLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    var answers: [Answer]!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        let time = ContinuousClock().measure {
            updateResult()
        }
        print(time)
    }

    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
}

// MARK: - Private Methods
extension ResultViewController {
    private func updateResult() {
        var frequencyOfAnimals: [Animal: Int] = [:]
        let animals = answers.map { $0.animal }
        
        for animal in animals {
            frequencyOfAnimals[animal, default: 0] += 1
        }
        
        let sortedFrequentOfAnimals = frequencyOfAnimals.sorted { $0.value > $1.value }
        guard let mostFrequentAnimal = sortedFrequentOfAnimals.first?.key else { return }
        
        updateUI(with: mostFrequentAnimal)
    }
    
    private func updateUI(with animal: Animal) {
        animalTypeLabel.text = "Вы - \(animal.rawValue)"
        descriptionLabel.text = "\(animal.definition)"
    }
}
