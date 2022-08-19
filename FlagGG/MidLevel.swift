//
//  MidLevel.swift
//  FlagGG
//
//  Created by Mac on 17.11.2021.
//

import SwiftUI


struct MidLevel: View {
    
    @State private var countries = ["Аргентина", "Австралія", "Бразилія", "Бутан", "Канада", "Чілі", "Данія", "Єгипет", "Фінляндія", "Гондурас", "Греція", "Гренландія", "Індія", "Казахстан", "Кірібаті", "Ліван", "Мадагаскар", "Мексика", "Монголія", "Морокко", "Мозамбік", "Норвегія", "Пакістан", "Польща", "ПАР", "Южна Корея", "Таджикістан", "Туніс", "САЄ", "Україна", "США", "Зімбабве", "Китай", "Франція", "Нідерланди", "Румунія", "Німеччина", "Великобританія", "Австрія", "Італія"] .shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var scoreMid = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    var body: some View {
        
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.yellow, .orange]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20){
                HStack{
                    Text("обери прапорець")
                        .font(.title3)
                    Text(countries[correctAnswer])
                        .font(.title3)
                        .fontWeight(.black)
                }
                
                ScrollView{
                    ForEach(0..<4) { number in
                        Button(action: {
                            self.flagTapped(number)
                            self.showingScore = true
                        }){
                            Image(self.countries[number])
                                .renderingMode(.original)
                                .frame(width: 250, height: 128)
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color.black, lineWidth: 3))
                        }
                    }
                }
                
                HStack(spacing: 40) {
                    Text("Рахунок: \(scoreMid)")
                        .font(.largeTitle)
                        .fontWeight(.black)
                    
                    Button(action: {
                        self.downScore()
                    }){
                        Image("arefresh")
                    }
                }
                
                Spacer()
                
                HStack{
                    Text("важкість")
                        .font(.largeTitle)
                        .fontWeight(.black)
                    NavigationLink(destination: HardLevel(), label: {
                        Image("alevelup")
                    })
                }
                
                Spacer()
                
                
            
                
                
                
            }
        } .alert(isPresented: $showingScore){
            Alert(title: Text(scoreTitle), message: Text("Рахунок: \(scoreMid)"), dismissButton: .default(Text("Далі")) {
                self.askQuestion()
            })
        }.navigationBarTitle("СЕРЕДНЄ", displayMode: .inline)
        
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Правильна відповідь"
            scoreMid += 1
        } else {
            scoreTitle = "Неправильно! Це флаг \(countries[number])"
            scoreMid -= 1
        }
    }
    
    func downScore(){
        scoreMid = 0
    }
    
}







struct MidLevel_Previews: PreviewProvider {
    static var previews: some View {
        MidLevel()
    }
}

