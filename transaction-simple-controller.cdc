import Controller from 0x01

transaction {

  let ref: &Controller.Operator
  let add: ((Int, Int): Int)

  prepare(acct: AuthAccount) {

    self.ref = acct.borrow<&Controller.Operator>(from: /storage/Operator)!
    self.add = fun(a: Int, b: Int): Int{
      return a + b
    }
  }

  execute {
    // This works :)
    log(self.ref.id)

    // Those two lines as well
    var res = self.add(2,5)
    log(res)

    // It works if we use Int
    self.ref.changeOperator(newOperator: 5)
    log(self.ref.operator)

    
    // Now this one doesn't :(
    /*
    self.ref.changeOperator(newOperator: fun(a: Int, b: Int): Int{
      return a + b
    })
    */
  }
}
