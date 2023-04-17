//
//  ViewController.swift
//  QuizApp
//
//  Created by Zaki on 17.04.2023.
//

import UIKit

class QuestionViewController: UIViewController {

    // MARK: -IB Outlets
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var questionLabel: UILabel!
    
    
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var multipleSwitches: [UISwitch]!
    
    
    @IBOutlet var rangedStackView: UIStackView!
    @IBOutlet var rangedLabels: [UILabel]!
    @IBOutlet var rangedSlider: UISlider!
    
    //MARK: - Private properties
    private let questions = Question.getQuestion()
    private var questionIndex = 0
    private var currentAnswers: [Answer] {
        questions[questionIndex].answers
    }
    private var answerChosen: [Answer] = []

    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        UpdateUI()
        let answerCount = Float(currentAnswers.count - 1)
        rangedSlider.maximumValue = answerCount
        rangedSlider.value = answerCount / 2
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let resultVC = segue.destination as? ResultViewController else { return }
        resultVC.answers = answerChosen
    }

    // MARK: - IB Actions
    
    @IBAction func singleButtonTouched(_ sender: UIButton) {
        guard let buttonIndex = singleButtons.firstIndex(of: sender) else { return }
        let currentAnswer = currentAnswers[buttonIndex]
        answerChosen.append(currentAnswer)
        nextQuestion()
    }
    
    
    @IBAction func multipleButtonTouched() {
        for(multipleSwitch, answer) in zip(multipleSwitches, currentAnswers) {
            if multipleSwitch.isOn {
                answerChosen.append(answer)
            }
        }
        nextQuestion()
    }
    
    @IBAction func rangedButtonTouched() {
        let index = lrintf(rangedSlider.value)
        answerChosen.append(currentAnswers[index])
        nextQuestion()
    }
    
}

// MARK: - Private methods
private extension QuestionViewController {
    func UpdateUI() {
        //Hide everything
        for stackView in [singleStackView, multipleStackView, rangedStackView] {
            stackView?.isHidden = true
        }
        
        // Get current question
        let currentQuestion = questions[questionIndex]
        
        // Set current question to question label
        questionLabel.text = currentQuestion.title
        
        // Calculate progress
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        // Set progress to the progress view
        progressView.setProgress(totalProgress, animated: true)
        
        // Set navigation title
        title = "Вопрос № \(questionIndex + 1) из \(questions.count)"
        
        // Show stacks corresponding to question type
        showCurrentAnswers(for: currentQuestion.type)
    }
    
    func showCurrentAnswers(for type: ResponseType) {
        switch type {
        case .single: showSingleStackView(with: currentAnswers)
        case .multiple: showMultipleStackView(with: currentAnswers)
        case .ranged: showRangedStackView(with: currentAnswers)
        }
    }
    
    func showSingleStackView(with answers: [Answer]) {
        singleStackView.isHidden.toggle()
        
        for(button, answer) in zip(singleButtons, answers) {
            button.setTitle(answer.title, for: .normal)
        }
        
    }
    
    func showMultipleStackView(with answers: [Answer]) {
        multipleStackView.isHidden.toggle()
        
        for (label, answer) in zip(multipleLabels, answers) {
            label.text = answer.title
        }
    }
    
    func showRangedStackView(with answers: [Answer]) {
        rangedStackView.isHidden.toggle()
        
        rangedLabels.first?.text = answers.first?.title
        rangedLabels.last?.text = answers.last?.title
    }
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            UpdateUI()
            return
        }
        
        performSegue(withIdentifier: "showResult", sender: nil)
    }
    
    
}
