pub contract ChainOperators{

    pub resource interface Operator{
        pub let name: String
        pub var nextOp: @AnyResource?

        pub fun operate(data: {String: AnyStruct}, resources: @{String: AnyResource?}): AnyStruct
        pub fun setNext(nextOperator: @AnyResource?)
    }

    pub resource Chain{
        pub var trigger:String
        pub var firstLink: @AnyResource? // we need it in order to cast down to Operator, I believe
        pub var lastLink: &AnyResource?

        init(trigger: String){
            self.trigger = trigger
            self.firstLink <- nil
            self.lastLink = nil
        }

        pub fun setTrigger(trigger: String){
            self.trigger = trigger
        }

        pub fun setFirstLink(link: @AnyResource?): @AnyResource?{
            if let firstLink <- link as? @{Operator}{
                self.firstLink <-! firstLink
                return nil
            } else {
                return <- link
            }
        }

        destroy(){
            destroy self.firstLink
        }
    }
}