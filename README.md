# MyCreditManager
A challenge for Wanted pre-on-boarding.

## 챌린지 정보
* 챌린지 주소 : https://www.wanted.co.kr/events/pre_challenge_ios_1
* 과제 내용 : https://yagomacademy.notion.site/iOS-ba2d0c0bb0b949c896cc28567706e969

## Issue01 : 기본 세팅
* Command in line 이해
  * readLine을 통한 콘솔 input 값 수신
  * 함수 재호출을 통한 exit 방지 및 반복 실행

## Issue02: 학생 추가 및 삭제 구현
* 구현 방식: Array
  * 차후 과목과 성적 입력을 위해 임시로 Array를 만들고 input value를 담았음(studentInfoArray)
  * 새 Array를 만들어 위의 이름이 포함된 array들을 담기(studentsArray)
  * studentInfoArray는 studentsArray에 담긴 후엔 새로운 이름을 받기 위해 초기화
  * array 검색을 위한 사용 함수 : contains, firstIndex

## Issue03: 성적 입력 및 삭제 구현
* 구현 방식
  * 이름을 검색하고, 해당하는 array에 append 하는 방식으로 구현
* 특이사항
  1. 이미 데이터 공간이 존재하는 배열은 임의의 substring으로 접근 불가. 
  * ex1) [[]]와 같은 빈 배열이 있는 배열의 $0[0]으로 접근하면 오류.
  * ex2) [[Jason], [Jack, Swift, A+] ]의 경우 뒷 배열이 세 개의 개체를 갖고 있다 해도, $0[2]와 같은 substring을 사용해 검색하면 오류. 앞 하나짜리 배열([Jason])도 순환해야 하기 때문. 
  * 해결:
    * ex1의 경우: 원하는 배열을 비게 만든 후, 다시 빈 배열을 검색해 삭제.
    ```
     studentsArray[studentAndSubjectIndex].removeAll()
     studentsArray.removeAll(where: { $0.isEmpty })
    ```
    * ex2의 경우: endIndex 활용
    ```
    if splittedInputArray.endIndex < 2 {
       print("입력이 잘못되었습니다. 다시 확인해주세요.")
       checkInput()
    } 
    ```
  2. 성적 입력을 위한 enum 생성
  * "A+" 등의 특수기호는 케이스생성 불가. rawValue 활용
  * enum case의 rawValue에 해당하지 않는 성적은 입력 불가 처리 (차후 평균값 계산때 오류 방지)
  ```
  enum CreditPoints: String {
    case Aplus = "A+"
    case A = "A"
    case Bplus = "B+"
    case B = "B"
    case Cplus = "C+"
    case C = "C"
    case Dplus = "D+"
    case D = "D"
  }
  // ...
  } else if CreditPoints(rawValue: String(splittedInputArray[2])) == nil{
    print("점수 입력이 잘못되었습니다. 다시 확인해주세요.")
    checkInput()
  } 
  ```
  3. 고민 지점이었던 데이터 저장 디자인.
  * '동일 학생 이름의 다른 성적이 포함된 여러 Array 생성'으로 구현

## Issue04: 점수 평균 구하기
* 구현 방식
  * 점수 연동 및 평균 구현
    * Double 소수점 밑 두자리 수는 "%.2f" 로 지정
    * 소수점 한자리 수 및 정수의 끝 "0" 지우기 -> hasSuffix로 조건검색 후 removeLast 로 원하는 자릿수 삭제
    * 성적 입력 및 검색의 안정성을 위해 성적 부여에도 enum의 rawValue 활용.
* 오류 수정
  * 서브스크립트의 인덱스를 통한 배열 접근에서 에러 발생
  * 해결 방법 : filter로 과목과 성적이 모두 입력된 배열 내에서 검색하도록 조건 부여
  * 그 외 : 각 목적에 맞게 조건 수정
