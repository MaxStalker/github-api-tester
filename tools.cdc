access(all) contract Tools {

  // AnyStruct arrays and dictionaries not working in Playground, so we gonna hack the solution
  pub struct AnyValue {
      pub let value: AnyStruct

      init(_ value: AnyStruct){
          self.value = value
      }
  }
}
