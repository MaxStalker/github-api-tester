pub contract ChainController{

  // Below here you can find a ChainLink
  pub resource ChainLink{
    pub let next: @ChainLink?
    pub var operator: AnyStruct?
    
    pub fun changeOperator(newOperator: ((&ChainLink):AnyStruct) ): Void{
      log("let's spicy things up")
      let ref: &ChainLink = &self as &ChainLink
      self.operator = newOperator(ref) 
    }

    init(){
      self.operator = nil
      self.next <- nil
    }

    destroy(){
      destroy self.next
    }
  }
  

  // Ths is contract init function
  init(){
    log("Chain Controller created")
    let chain <- create ChainLink()
    self.account.save(<-chain, to: /storage/ChainLink)
    
    // 

    let addition: ((&ChainLink): AnyStruct) = fun (link: &ChainLink): ((Int, Int): Int) {
      return fun(a: Int, b: Int): Int{
        return a + b
      }
    }

    /*
    let ref:&ChainLink = &chain as &ChainLink
    
    let addExposed = addition(ref)
    let result = addExposed(2,5)
    log(result)
    */
    log("it works!")
  }
}