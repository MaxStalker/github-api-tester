import Controller from 0x01

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

        pub fun addAction(name: String, op: {Controller.Operator}){
          self.actions[name] = op
        }

        // initialize the balance at resource creation time
        init(balance: UInt64) {
            self.balance = balance
            self.actions = {}
        }

        pub fun deposit(from: @ProgrammableVault) {
            // Inject other code here
            self.balance = self.balance + from.balance
            destroy from
        }
    }

    // createEmptyVault
    //
    // Function that creates a new Vault with a balance of zero
    // and returns it to the calling context. A user must call this function
    // and store the returned Vault in their storage in order to allow their
    // account to be able to receive deposits of this token type.
    //
    pub fun createEmptyVault(): @ProgrammableVault {
        return <-create ProgrammableVault(balance: UInt64(0))
    }


    // The init function for the contract. All fields in the contract must
    // be initialized at deployment. This is just an example of what
    // an implementation could do in the init function. The numbers are arbitrary.
    init() {

        // create the Vault with the initial balance and put it in storage
        // account.save saves an object to the specified `to` path
        // The path is a literal path that consists of a domain and identifier
        // The domain must be `storage`, `private`, or `public`
        // the identifier can be any name
        // let vault <- create Vault(balance: self.totalSupply)
        // self.account.save(<-vault, to: /storage/MainVault)

        // Create a new MintAndBurn resource and store it in account storage
        // self.account.save(<-create VaultMinter(), to: /storage/MainMinter)

        // Create a private capability link for the Minter
        // Capabilities can be used to create temporary references to an object
        // so that callers can use the reference to access fields and functions
        // of the objet.
        // 
        // The capability is stored in the /private/ domain, which is only
        // accesible by the owner of the account
        // self.account.link<&VaultMinter>(/private/Minter, target: /storage/MainMinter)
    }
}
 
