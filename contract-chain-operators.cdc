// TODO: Simply embed struct based solution (slightly adjusted) and call it a day :\

pub contract ChainOperators{

    pub resource interface Operator{
        pub let name: String
        pub var nextOp: @AnyResource?

        pub fun operate(data: {String: AnyStruct}, resources: @{String: AnyResource?}): AnyStruct
        pub fun setNext(nextOperator: @AnyResource?)
    }

    pub resource Chain{
        pub var trigger:String
        pub var firstLink: @AnyResource? // we need it in order to cast down to Operator, I believe
        pub var lastLink: &AnyResource?

        init(trigger: String){
            self.trigger = trigger
            self.firstLink <- nil
            self.lastLink = nil
        }

        pub fun setTrigger(trigger: String){
            self.trigger = trigger
        }

        pub fun setFirstLink(link: @AnyResource?): @AnyResource?{
            if let firstLink <- link as? @{Operator}{
                self.firstLink <-! firstLink
                return nil
            } else {
                return <- link
            }
        }

        destroy(){
            destroy self.firstLink
        }
    }

    pub resource Vault{
        pub let balance: UInt
        pub var metaFields: {String: AnyStruct}
        pub var metaResources: @{String: AnyResource?}

        init(balance: UInt){
            self.balance = balance
            self.metaResources <- {};
            self.metaFields = {};
        }
        
        destroy(){
            destroy self.metaResources
        }


        pub fun getMetaResource(name: String): @AnyResource?{
            // If the NFT isn't found, the transaction panics and reverts
            let metaResource <- self.metaResources.remove(key: name)!
            return <- metaResource
        }

        pub fun getMetaField(name: String): AnyStruct?{
            let metaField = self.metaFields[name]!
            return metaField
        }        

        pub fun withdraw(amount: UInt): @Vault {
            // TODO: Create custom operator to handle withdraw
            if withdrawOperator <- self.getMetaResource('withdrawOperator'){
                withdrawOperator.call('withdraw', {amount: amount}, )
            } else {
                self.balance = self.balance - amount
                return <- create Vault(balance: amount)
            }
        }

        pub fun deposit(from: @Vault) {
            // TODO: Create custom solution which will utilize owned resource
            // self.balance = self.balance + from.balance
            // destroy from
            log("deposit")
            destroy from
        }
    }

    // Public method to create empty vaults
    pub fun createEmptyVault(): @Vault {
        return <- create Vault(balance: 0)
    }

    // Resource that will control initial deposit to Vault
    pub resource VaultMinter {
        pub fun supplyBalance(amount: UInt, recipient: &Vault) {
            recipient.deposit(from: <- create Vault(balance: amount))
        }
    }

    init() {
        self.account.save(<-create VaultMinter(), to: /storage/MainMinter)
        self.account.link<&VaultMinter>(/private/Minter, target: /storage/MainMinter)
    }
}