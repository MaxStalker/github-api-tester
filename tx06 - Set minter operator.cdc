import LikeSystem from 0x04

transaction{
    let vaultRef: &LikeSystem.LikeVault

    prepare(acct: AuthAccount){
        self.vaultRef = acct.borrow<&LikeSystem.LikeVault>(from: /storage/LikeVault) 
                         ?? panic("No Programmable Vault stored there...")
        
        // self.operator = Operators.Notify(next: nil)
        log(self.vaultRef.balance)
        self.vaultRef.initMintOperator(next: nil, ref: self.vaultRef)
    }

    execute{
        // self.vaultRef.addAction(name: "deposit", op: self.operator)
        // self.vaultRef.
    }
}