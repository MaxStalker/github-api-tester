import ChainController from 0x03

transaction {

  let chainRef: &ChainController.ChainLink

  prepare(acct: AuthAccount) {

    self.chainRef = acct.borrow<&ChainController.ChainLink>(from: /storage/ChainLink)!
    
    /*
 
    let addition: ((&ChainLink): AnyStruct) = fun (link: &ChainLink): ((Int, Int): Int) {
      return fun(a: Int, b: Int): Int{
        return a + b
      }
    }
    */
  }

  execute {
    let a = 132
    self.chainRef.setItem(item: a)
    log(self.chainRef.item)
  }
}
