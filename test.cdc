pub contract ChainOperators{
    pub resource interface Operator{
        pub let name: String
        pub var nextOp: @AnyResource?

        pub fun operate(data: {String: AnyStruct}, resources: @{String: AnyResource?}): AnyStruct
        pub fun setNext(next: @AnyResource?)
    }
}