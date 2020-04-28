pub contract AdvancedContract {
    pub greeting: String
    pub role: String

    init(){
        log("Init contract")
        self.greeting = "Holla!"
        self.role = "face"
    }

    pub sayHi():String {
        return self.greeting
    }

    pub showRole():String{
      return self.role
    }
}
