pub contract ChainController{

  pub resource ChainLink{
    pub let next: @ChainLink?
    pub var operator: AnyStruct?
    
    pub fun changeOperator(newOperator: ((&ChainLink):AnyStruct) ): Void{
      log("let's spicy things up")
      let ref: &ChainLink = &self as &ChainLink
      self.operator = newOperator(ref) 
    }

    init(){
      self.operator = fun(a: Int, b: Int): Int{
        return a + b
      }
      self.next <- nil
    }

    destroy(){
      destroy self.next
    }
  }
  
  init(){
    log("Chain Controller created")
    let chain <- create ChainLink()
    if let p = chain.operator as? ((Int, Int):Int){
      let result = p(2,5)
      log(result)
    }
    destroy chain;
  }
}