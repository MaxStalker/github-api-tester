import ChainController from 0x03

transaction {

  let chainRef: &ChainController.ChainLink
  let add: ((Int, Int): Int)
  let addWrapped: ((&ChainController.ChainLink): ((Int, Int): Int))

  prepare(acct: AuthAccount) {

    self.chainRef = acct.borrow<&ChainController.ChainLink>(from: /storage/ChainLink)!

    self.add = fun(a: Int, b: Int): Int{
        return a + b
      }

    self.addWrapped = fun (link: &ChainController.ChainLink): ((Int, Int): Int) {
      log(link.testMe)
      return fun(a: Int, b: Int): Int{
        return a + b
      }
    }
    
  }

  execute {
    let a = 777
    self.chainRef.setItem(item: a)
    log(self.chainRef.item)
    self.chainRef.setTestOp(operator: self.add)

    // let add = self.add(link: self.chainRef)
    // log(add(3,5))

    //self.chainRef.changeOperator(ref: self.chainRef, newOperator: self.add)
    // self.chainRef.testOp(operator: self.add)
  }
}
