pub contract ChainController{

  pub resource ChainLink{
    pub let next: @ChainLink?
    pub let operator: AnyStruct
    
    pub fun changeOperator(): Void{
      log("let's spicy things up")
    }

    init(){
      self.operator = fun (a: Int, b: Int): Int{
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
  }
}