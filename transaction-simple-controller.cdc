import Controller from 0x02

transaction {
  prepare(acct: AuthAccount) {

  }

  execute {
      log("start")
      if let addOperator = Controller.operator as? Controller.AddOperator{
        log(addOperator.name)

        let sum = addOperator.operate(operands: [2,3])
        log(sum)
      }
    }
}
