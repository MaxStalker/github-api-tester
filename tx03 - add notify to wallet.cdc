import Operators from 0x01
import FungibleToken from 0x02

transaction{
    let vaultRef: &FungibleToken.ProgrammableVault
    let operator: {Operators.Operator}
    prepare(acct: AuthAccount){
        self.vaultRef = acct.borrow<&FungibleToken.ProgrammableVault>(from: /storage/ProgVault) 
                         ?? panic("No Programmable Vault stored there...")
        
        self.operator = Operators.Notify(next: nil)
    }

    execute{
        self.vaultRef.addAction(name: "deposit", op: self.operator)
    }
}