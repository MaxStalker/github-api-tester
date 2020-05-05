// Dictionary with AnyStruct are not working 😟

pub fun main(): Void {
  let data: { String: AnyStruct } = {
    "amount": UInt(42) as AnyStruct,
    "sender": "other user" as AnyStruct
  }

  let sender = data["sender"]!
  log(sender)     
}
