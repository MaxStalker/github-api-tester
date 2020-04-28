pub contract BaseContract {
    pub greeting: String

    init(){
        log("Init contract")
        self.greeting = "Holla!"
    }

    pub sayHi():String {
        return self.greeting
    }
}
