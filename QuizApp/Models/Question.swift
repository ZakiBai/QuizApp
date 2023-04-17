//
//  Question.swift
//  QuizApp
//
//  Created by Zaki on 17.04.2023.
//

struct Question {
    let title: String
    let type: ResponseType
    let answers: [Answer]
    
    static func getQuestion() -> [Question] {
        [
            Question(
                title: "Какую пищу предпочитаете?",
                type: .single,
                answers: [
                    Answer(title: "Steik", animal: .dog),
                    Answer(title: "Fish", animal: .cat),
                    Answer(title: "Morkop", animal: .rabbit),
                    Answer(title: "Kukuruza", animal: .turtle)
                ]
            ),
            Question(
                title: "Что Вам нравится больше?",
                type: .multiple,
                answers: [
                    Answer(title: "Swim", animal: .dog),
                    Answer(title: "Sleep", animal: .cat),
                    Answer(title: "Hug", animal: .rabbit),
                    Answer(title: "Eat", animal: .turtle)
                ]
            ),
            Question(
                title: "Любите ли вы поездки на машине?",
                type: .ranged,
                answers: [
                    Answer(title: "Ненавижу", animal: .cat),
                    Answer(title: "Нервничаю", animal: .rabbit),
                    Answer(title: "Не замечаю", animal: .turtle),
                    Answer(title: "Обожаю", animal: .dog)
                
                ]
            )
           
        
        ]
    }
}

enum ResponseType {
    case single
    case multiple
    case ranged
}

struct Answer {
    let title: String
    let animal: Animal
}

enum Animal: Character {
    case dog = "🐶"
    case cat = "🐱"
    case rabbit = "🐰"
    case turtle = "🐢"
    
    var definition: String {
        switch self {
        case .dog:
            return "Вам нравится быть с друзьями. Вы окружаете себя людьми, которые вам нравятся и всегда готовы помочь."
        case .cat:
            return "Вы себе на уме. Любите гулять сами по себе. Вы цените одиночество."
        case .rabbit:
            return "Вам нравится все мягкое. Вы здоровы и полны энергии."
        case .turtle:
            return "Ваша сила - в мудрости. Медленный и вдумчивый выигрывает на больших дистанциях."
        }
    }
}
