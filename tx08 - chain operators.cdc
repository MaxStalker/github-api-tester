import FungibleToken from 0x02
import Operators from 0x03
import LikeSystem from 0x04

transaction{
    let vaultRef: &FungibleToken.ProgrammableVault
    let likeVaultRef: &LikeSystem.LikeVault
    let operator: {Operators.Operator}

    prepare(acct: AuthAccount){
        self.vaultRef = acct.borrow<&FungibleToken.ProgrammableVault>(from: /storage/ProgVault) 
                         ?? panic("No Programmable Vault stored there...")

        self.likeVaultRef = acct.borrow<&LikeSystem.LikeVault>(from: /storage/LikeVault) 
                         ?? panic("No Programmable Vault stored there...")

       
        // there is an optional...

        let mintOperator = self.likeVaultRef.mintOperator!
        self.operator = Operators.Notify(next: mintOperator)
    }

    execute{
        self.vaultRef.addAction(name: "deposit", op: self.operator)
    }
}