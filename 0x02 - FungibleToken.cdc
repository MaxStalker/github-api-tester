import Operators from 0x01

pub contract FungibleToken {

	  pub resource interface Receiver {
        pub fun deposit(from: @ProgrammableVault) {
            pre {
                from.balance > UInt64(0):
                    "Deposit balance must be positive"
            }
        }
    }

    pub resource interface Balance {
        pub var balance: UInt64
    }

    pub resource ProgrammableVault: Receiver, Balance {
      
		    // keeps track of the total balance of the account's tokens
        pub var balance: UInt64
        // This will keep actions available for this vault
        pub var actions: {String: AnyStruct}

        pub fun addAction(name: String, op: {Operators.Operator}){
          // trigger event here in order to notify owner about it...
          log("New action added: ".concat(name))
          self.actions[name] = op
        }

        pub fun deposit(from: @ProgrammableVault) {           
          if let action = self.actions["deposit"]{
            if let op = action as? {Operators.Operator}{
              let data: { String: AnyStruct } = {
                "amount": from.balance as AnyStruct,
                "sender": from.owner as AnyStruct
              }              
 
              // let resources: {String: AnyResource?} = {}
              op.operate(data: data) 
            }
          }
          

          self.balance = self.balance + from.balance
          destroy from
        }

        // initialize the balance at resource creation time
        init(balance: UInt64) {
            self.balance = balance
            self.actions = {} // here we shall actually store a chain of actions...
        }
    }

    // Empty Vault factory
    pub fun createEmptyVault(): @ProgrammableVault {
        return <-create ProgrammableVault(balance: UInt64(0))
    }

    // Minter to create tokens out of thin air 🧙‍♂️
    pub resource ProgVaultMinter{
      pub fun mintTokens(amount: UInt64, recipient: &AnyResource{Receiver}){
        let tempVault <- create ProgrammableVault(balance: amount)
        recipient.deposit(from: <- tempVault)
      }
    }


    init() {
        self.account.save(<-create ProgVaultMinter(), to: /storage/ProgVaultMinter)
        self.account.link<&ProgVaultMinter>(/private/ProgVaultMinter, target: /storage/ProgVaultMinter)
    }
}
 
