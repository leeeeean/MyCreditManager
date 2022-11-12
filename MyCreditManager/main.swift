//
//  main.swift
//  MyCreditManager
//
//  Created by 최리안 on 2022/11/13.
//

import Foundation

var studentNameList : [String] = []
var studentList : [Student] = []
let scoreDataDict = ["A+":4.5, "A":4, "B+":3.5, "B":3, "C+":2.5, "C":2, "D+":1.5, "D":1, "F":0]

let menuMessage = "원하는 기능을 입력해주세요\n1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료"
let menuInputError = "뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요."
let studentInputError = "입력이 잘못되었습니다. 다시 확인해주세요"
let addStudentMessage = "추가할 학생의 이름을 입력해주세요"
let deleteStudentMessage = "삭제할 학생의 이름을 입력해주세요"
let addScoreMessage = "성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요 \n입력예) Mickey Swift A+ \n만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다."
let deleteScoreMessage = "성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요 \n입력예) Mickey Swift"
let averageScoreMessage = "평점을 알고싶은 학생의 이름을 입력해주세요"


while true {
    print(menuMessage)
    if let input = readLine() {
        if input == "X" {
            break
        }
        if let intInput = Int(input) {
            if intInput >= 1, intInput <= 5 {
                switch intInput {
                case 1:
                    addStudent()
                case 2:
                    deleteStudent()
                case 3:
                    addScore()
                case 4:
                    deleteScore()
                case 5:
                    averageScore()
                default:
                    break
                }
            } else {
                print(menuInputError)
            }
        } else {
            print(menuInputError)
        }
    } else {
        print(menuInputError)
    }
}

func addStudent() {
    print(addStudentMessage)
    if let student = readLine(), student.count != 0 {
        if studentNameList.contains(student) {
            print("\(student)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
        } else {
            studentNameList.append(student)
            studentList.append(Student(name: student))
            print("\(student) 학생을 추가했습니다.")
        }
    } else {
        print(studentInputError)
    }
}

func deleteStudent() {
    print(deleteStudentMessage)
    if let student = readLine(), student.count != 0 {
        if studentNameList.contains(student) {
            print("\(student) 학생을 삭제하였습니다.")
            let index = studentNameList.firstIndex(of: student)!
            studentNameList.remove(at: index)
            studentList.remove(at: index)
        } else {
            print("\(student) 학생을 찾지 못했습니다.")
        }
    } else {
        print(studentInputError)
    }
}

func addScore() {
    print(addScoreMessage)
    if let input = readLine() {
        let scoreData = input.split(separator: " ")
        if scoreData.count == 3 {
            let studentName = String(scoreData[0])
            let subject = String(scoreData[1])
            let score = String(scoreData[2])
            if studentNameList.contains(studentName) {
                let index = studentNameList.firstIndex(of: studentName)!
                studentList[index].updateScore(subject: subject, score: score)
                print("\(studentName) 학생의 \(subject) 과목이 \(score)로 추가(변경)되었습니다.")
            } else {
                print("\(studentName) 학생을 찾지 못했습니다.")
            }
        } else {
            print(studentInputError)
        }
    } else {
        print(studentInputError)
    }
}

func deleteScore() {
    print(deleteScoreMessage)
    if let input = readLine() {
        let scoreData = input.split(separator: " ")
        if scoreData.count == 2 {
            let studentName = String(scoreData[0])
            let subject = String(scoreData[1])
            if studentNameList.contains(studentName) {
                let index = studentNameList.firstIndex(of: studentName)!
                studentList[index].deleteScore(subject: subject)
                print("\(studentName) 학생의 \(subject) 과목의 성적이 삭제되었습니다.")
            } else {
                print("\(studentName) 학생을 찾지 못했습니다.")
            }
        } else {
            print(studentInputError)
        }
    } else {
        print(studentInputError)
    }
}

func averageScore() {
    print(averageScoreMessage)
    if let student = readLine(), student.count != 0 {
        if studentNameList.contains(student) {
            let index = studentNameList.firstIndex(of: student)!
            var score: Double = 0
            for key in studentList[index].scores.keys {
                print("\(key) : \(studentList[index].scores[key]!)")
                score += scoreDataDict[studentList[index].scores[key]!]!
            }
            score /= Double(studentList[index].scores.keys.count)
            let conversalScore = String(format: "%.2f", score)
            print("평점 : \(conversalScore)")
            
        } else {
            print("\(student) 학생을 찾지 못했습니다.")
        }
    } else {
        print(studentInputError)
    }
}

class Student {
    let name: String
    var scores: Dictionary<String, String> = [:]
    
    init(name: String) {
        self.name = name
    }
    
    func updateScore(subject: String, score: String) {
        scores[subject] = score
    }
    
    func deleteScore(subject: String) {
        scores[subject] = nil
    }
}


