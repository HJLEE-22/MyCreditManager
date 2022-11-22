//
//  main.swift
//  MyCreditManager
//
//  Created by 이형주 on 2022/11/16.
//

import Foundation

var studentsArray: [[String]] = []
var studentInfoArray: [String] = []

enum CreditPoints: String {
    case Aplus = "A+"
    case A = "A"
    case Bplus = "B+"
    case B = "B"
    case Cplus = "C+"
    case C = "C"
    case Dplus = "D+"
    case D = "D"
    case F = "F"
}


private func checkInput() {
    print("원하는 기능을 입력해주세요.\n1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
    var input = readLine()
    if let input = input, let intInput = Int(input) {

            if 1...5 ~= intInput {
                switch intInput {
                case 1:
                    addingStudent()
                case 2:
                    deletingStudent()
                case 3:
                    addingCredits()
                case 4:
                    deletingCredits()
                case 5:
                    calculatingAverage()
                default:
                    break
                }
                
            } else {
                print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.");
                checkInput()
            }

    } else if let input = input, input.lowercased() == "x" {
            print("프로그램을 종료합니다...")
    } else {
        print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.");
        checkInput()
    }
}

private func addingStudent() {
    
    // 띄어쓰기 방지 필요
    print("추가할 학생의 이름을 입력해주세요")
    var nameInput = readLine()
    guard let nameInput = nameInput else { return }

    if studentsArray.contains(where: { $0[0] == nameInput }) {
        print("\(nameInput)은 이미 존재하는 이름입니다. 추가하지 않습니다.")
        checkInput()
    } else if  nameInput.contains(where: {$0 == " "} ){
        // 이름에 띄어쓰기 입력 불가
        print("띄어쓰기 입력은 불가합니다. 다시 확인해주세요.")
        checkInput()
    } else if nameInput.trimmingCharacters(in: .whitespaces) != "" {
        studentInfoArray.append(nameInput)
        studentsArray.append(studentInfoArray)
        studentInfoArray.removeAll()
        print("\(nameInput) 학생을 추가했습니다.")
        checkInput()
    } else if nameInput.trimmingCharacters(in: .whitespaces) == "" {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        checkInput()
    }
}

private func deletingStudent() {
    print("삭제할 학생의 이름을 입력해주세요")
    var nameInput = readLine()
    if let nameInput = nameInput {
        if studentsArray.contains(where: { $0[0] == nameInput  }) {
            var studentIndexInArray = studentsArray.firstIndex(where: { $0[0] == nameInput })!
            studentsArray.remove(at: studentIndexInArray)
            print("\(nameInput)학생을 삭제하였습니다.")
            checkInput()
        } else {
            print("\(nameInput) 학생을 찾지 못했습니다.")
            checkInput()
        }
    }
}
  
private func addingCredits() {
    print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.\n입력예) Mickey Swift A+\n만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
    var creditInput = readLine()
    if let creditInput = creditInput {
        var splittedInputArray = creditInput.split { $0 == " " }
        
        if splittedInputArray.endIndex < 3 {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
            checkInput()
        } else if CreditPoints(rawValue: String(splittedInputArray[2])) == nil{
            print("점수 입력이 잘못되었습니다. 다시 확인해주세요.")
            checkInput()
        } else if !studentsArray.contains(where: { $0[0] == splittedInputArray[0] }) {
            print("\(splittedInputArray[0]) 학생을 찾지 못했습니다.")
            checkInput()
            // 정상 추가/변경되는 경우
        } else if studentsArray.contains(where: { $0[0] == splittedInputArray[0] && $0.endIndex == 1 }) {
                // 학생이름은 있지만 성적이 아무것도 없을때
                var studentIndex = studentsArray.firstIndex(where: { $0[0] == splittedInputArray[0]  })!
                studentsArray[studentIndex].append(String(splittedInputArray[1]))
                studentsArray[studentIndex].append(String(splittedInputArray[2]))
                print("\(splittedInputArray[0]) 학생의 \(splittedInputArray[1]) 과목이 \(splittedInputArray[2])로 추가(변경) 되었습니다.")
                //                                print("\(splittedInputArray[0]) 학생의 \(splittedInputArray[1]) 과목이 \(splittedInputArray[2])로 추가 되었습니다.")
                checkInput()
                
        } else if studentsArray.filter({ $0.endIndex == 3 }).contains(where: { $0[0] == splittedInputArray[0] && $0[1] == splittedInputArray[1] }) {
                // 같은 과목의 성적이 있을 때
            var studentAndSubjectIndex = studentsArray.firstIndex(where: { $0[0] == splittedInputArray[0] && $0[1] == splittedInputArray[1] })!
                studentsArray[studentAndSubjectIndex].remove(at: 2)
                studentsArray[studentAndSubjectIndex].append(String(splittedInputArray[2]))
                print("\(splittedInputArray[0]) 학생의 \(splittedInputArray[1]) 과목이 \(splittedInputArray[2])로 추가(변경) 되었습니다.")
                //                                print("\(splittedInputArray[0]) 학생의 \(splittedInputArray[1]) 과목이 \(splittedInputArray[2])로 변경 되었습니다.")
                checkInput()
        } else if studentsArray.filter({ $0.endIndex == 3 }).contains(where: { $0[0] == splittedInputArray[0] && $0[1] != splittedInputArray[1] }){
            // 다른 과목의 성적을 추가할 때
            studentsArray.append([String(splittedInputArray[0]), String(splittedInputArray[1]), String(splittedInputArray[2])])
            print("\(splittedInputArray[0]) 학생의 \(splittedInputArray[1]) 과목이 \(splittedInputArray[2])로 추가(변경) 되었습니다.")
            //                                print("\(splittedInputArray[0]) 학생의 \(splittedInputArray[1]) 과목이 \(splittedInputArray[2])로 추가 되었습니다.")
            checkInput()
        }
    }
}

private func deletingCredits(){
    print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.\n입력예) Mickey Swift")
    var creditInput = readLine()
    if let creditInput = creditInput {
        var splittedInputArray = creditInput.split { $0 == " " }
        if splittedInputArray.endIndex < 2 {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
            checkInput()
        } else if !studentsArray.contains(where: { $0[0] == splittedInputArray[0] }) {
            print("\(splittedInputArray[0]) 학생의 해당 과목 점수를 찾지 못했습니다.")
            checkInput()
        } else if studentsArray.contains(where: { $0[0] == splittedInputArray[0] }) {
            if studentsArray.contains(where: { $0[1] == splittedInputArray[1] }) {
                var studentAndSubjectIndex = studentsArray.firstIndex(where: { $0[0] == splittedInputArray[0] && $0[1] == splittedInputArray[1]  })!
                studentsArray[studentAndSubjectIndex].removeAll()
                studentsArray.removeAll(where: { $0.isEmpty })
                print("\(splittedInputArray[0]) 학생의 \(splittedInputArray[1]) 과목의 성적이 삭제 되었습니다.")
                checkInput()
            } else {
                print("\(splittedInputArray[0]) 학생을 찾지 못했습니다.")
//                                print("\(splittedInputArray[0]) 학생의 \(splittedInputArray[1]) 성적을 찾지 못했습니다.")
                checkInput()
            }
        }
    }
}

private func calculatingAverage() {
    print("평점을 알고싶은 학생의 이름을 입력해주세요")
    var nameInput = readLine()
    guard let nameInput = nameInput else { return }
    var splittedInputArray = nameInput.split { $0 == " " }
    if splittedInputArray.endIndex < 1 {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        checkInput()
    } else if !studentsArray.contains(where: { $0[0] == splittedInputArray[0] }) {
        print("\(splittedInputArray[0]) 학생을 찾지 못했습니다.")
        checkInput()
    } else if studentsArray.contains(where: { $0[0] == nameInput }) {
        var studentsArrayForAverage = studentsArray.filter({ $0[0] == nameInput })
        let averageCount = studentsArrayForAverage.count
        print(averageCount)
        var creditsForAverage: Double = 0.0
        for i in 0...averageCount-1 {
            var subjectName = studentsArrayForAverage[i][1]
            var subjectCredit = studentsArrayForAverage[i][2]
            switch subjectCredit {
            case CreditPoints.Aplus.rawValue: creditsForAverage += 4.5
            case CreditPoints.A.rawValue: creditsForAverage += 4.0
            case CreditPoints.Bplus.rawValue: creditsForAverage += 3.5
            case CreditPoints.B.rawValue: creditsForAverage += 3.0
            case CreditPoints.Cplus.rawValue: creditsForAverage += 2.5
            case CreditPoints.C.rawValue: creditsForAverage += 2.0
            case CreditPoints.Dplus.rawValue: creditsForAverage += 1.5
            case CreditPoints.D.rawValue: creditsForAverage += 1.0
            case CreditPoints.F.rawValue: creditsForAverage += 0
            default: break
            }
            print("\(subjectName): \(subjectCredit)")
        }
        var average = String(format: "%.2f", creditsForAverage / Double(averageCount))
        if average.hasSuffix("00") {
            average.removeLast(3)
        } else if average.hasSuffix("0") {
            average.removeLast(1)
        }
        print("평점: \(average)")

        checkInput()
    }
}

checkInput()
