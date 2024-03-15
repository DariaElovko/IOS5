//Создать класс родитель и 2 класса наследника
//Создать класс *House* в нем несколько свойств

// Родительский класс
class House {
    var width: Double
    var height: Double
    
    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
    
    func create() {
        print("Дом создан. Площадь: \(width * height) кв. м.")
    }
    
    func destroy() {
        print("Дом уничтожен.")
    }
}

// Класс наследник
class WoodenHouse: House {
    var woodType: String
    
    init(width: Double, height: Double, woodType: String) {
        self.woodType = woodType
        super.init(width: width, height: height)
    }
}

// Класс наследник
class StoneHouse: House {
    var stoneType: String
    
    init(width: Double, height: Double, stoneType: String) {
        self.stoneType = stoneType
        super.init(width: width, height: height)
    }
}

//Создайте класс с методами, которые сортируют массив учеников по разным параметрам

class Student {
    var name: String
    var age: Int
    var grade: Double

    init(name: String, age: Int, grade: Double) {
        self.name = name
        self.age = age
        self.grade = grade
    }

    func displayInfo() {
        print("Student: \(name), Age: \(age), Grade: \(grade)")
    }
}

class StudentManager {
    var students: [Student]
    
    init(students: [Student]) {
        self.students = students
    }
    
    func sortByGrade() {
        students.sort { $0.grade > $1.grade }
    }
    
    func sortByName() {
        students.sort { $0.name < $1.name }
    }
    
    func sortByAge() {
        students.sort { $0.age < $1.age }
    }
    
}

//Написать свою структуру и класс, и пояснить в комментариях - чем отличаются структуры от классов
 
// В отличие от структур, классы поддерживают наследование и имеют ссылочный характер.
// Это значит, что при передаче экземпляра класса в функцию (или его присвоении другой переменной),
// изменения в объекте отразятся везде, где есть ссылка на этот объект.

// Пример структуры
struct Point {
    var x: Double
    var y: Double
}

// Пример класса
class Player {
    var name: String
    var score: Int
    
    init(name: String, score: Int) {
        self.name = name
        self.score = score
    }
    
    //можно прописать методы через func
}

//Напишите простую программу, которая отбирает комбинации в покере из рандомно выбранных 5 карт
import Foundation

// Enum для мастей карт
enum Suit: String, CaseIterable {
    case hearts, diamonds, clubs, spades
}

// Enum для достоинств карт
enum Rank: String, CaseIterable {
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case ten = "10"
    case jack = "Jack"
    case queen = "Queen"
    case king = "King"
    case ace = "Ace"
}

// Структура для представления карты
struct Card {
    var suit: Suit
    var rank: Rank
    
    init(suit: Suit, rank: Rank) {
        self.suit = suit
        self.rank = rank
    }
}

// Функция для генерации рандомной карты
func random_card() -> Card {
    let randomSuit = Suit.allCases.randomElement()!
    let randomRank = Rank.allCases.randomElement()!
    return Card(suit: randomSuit, rank: randomRank)
}

// Функция для генерации рандомной комбинации из 5 карт
func random_poker_hand() -> [Card] {
    var poker_hand = [Card]()
    for _ in 1...5 {
        let random_card = random_card()
        poker_hand.append(random_card)
    }
    return poker_hand
}

// Функция для определения типа комбинации
func poker_hand_type(hand: [Card]) -> String {
    let sorted_hand = hand.sorted { $0.rank.rawValue < $1.rank.rawValue }
    let is_straight = Set(sorted_hand.map { $0.rank.rawValue }).count == 5 && (sorted_hand.last!.rank == .ace || Int(sorted_hand.last!.rank.rawValue)! - Int(sorted_hand.first!.rank.rawValue)! == 4)
    let is_flush = Set(sorted_hand.map { $0.suit }).count == 1
    let rank_counts = Dictionary(grouping: sorted_hand, by: { $0.rank }).mapValues { $0.count }
    
    if is_straight && is_flush {
        return "Straight Flush"
    } else if rank_counts.values.contains(4) {
        return "Four of a Kind"
    } else if rank_counts.values.contains(3) && rank_counts.values.contains(2) {
        return "Full House"
    } else if is_flush {
        return "Flush"
    } else if is_straight {
        return "Straight"
    } else if rank_counts.values.contains(3) {
        return "Three of a Kind"
    } else if rank_counts.values.contains(2) {
        let pairs = rank_counts.filter { $0.value == 2 }
        if pairs.count == 2 {
            return "Two Pairs"
        } else {
            return "One Pair"
        }
    } else {
        return "High Card"
    }
}

var poker_hands = [[Card]]()

let poker_hand = random_poker_hand()
poker_hands.append(poker_hand)

let hand_type = poker_hand_type(hand: poker_hand)
for card in poker_hand {
    print("\(card.rank.rawValue) of \(card.suit.rawValue)")
}
print("Hand Type: \(hand_type)")
print("\n")

//Перебирать все комбинации в покере из 5 карт не стала. Просто вывод старшей комбинации.