//
//  InsaneLevel.swift
//  FlagGG
//
//  Created by Mac on 17.11.2021.
//

import SwiftUI

struct InsaneLevel: View {
    
    
    @State private var countries = ["Аргентина", "Австралія", "Бразилія", "Бутан", "Чілі", "Данія", "Єгипет", "Фінляндія", "Гондурас", "Гренландія", "Кірібаті", "Ліван", "Мадагаскар", "Мексика", "Монголія", "Морокко", "Мозамбік", "Норвегія", "Пакістан", "ПАР", "Таджикістан", "Туніс", "САЄ", "Зімбабве"] .shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var scoreInsane = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var time = 15
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.red, .purple]), startPoint: .top, endPoint: .bottom)
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
                    ForEach(0..<7) { number in
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
                    Text("Рахунок: \(scoreInsane)")
                        .font(.largeTitle)
                        .fontWeight(.black)
                    
                    Button(action: {
                        self.downScore()
                    }){
                        Image("arefresh")
                    }
                }
                
                Spacer()
                
                Text("через \(time) секунд -1")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .onReceive(timer) { _ in
                        timerGoing()
                    }
            
            }
            
        } .alert(isPresented: $showingScore){
            Alert(title: Text(scoreTitle), message: Text("Рахунок: \(scoreInsane)"), dismissButton: .default(Text("Далі")) {
                self.askQuestion()
            })
        }.navigationBarTitle("НЕЙМОВІРНО", displayMode: .inline)
        
    }
    
     
    func timerGoing() {
        if time > 0 {
            time -= 1
        } else {
            scoreInsane -= 1
            time = 15
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Правильна відповідь"
            scoreInsane += 1
        } else {
            scoreTitle = "Неправильно! Це флаг \(countries[number])"
            scoreInsane -= 2
        }
    }
    
    func downScore(){
        scoreInsane = 0
        time = 15
    }
    
}

struct InsaneLevel_Previews: PreviewProvider {
    static var previews: some View {
        InsaneLevel()
    }
}
