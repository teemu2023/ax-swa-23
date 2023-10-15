package sbercode

default ok = false

ok = true {
    input.command == "curl -v localhost:32100/auctions/12345/bids"
}

allow[msg] {
    ok
    msg := "[OK] Task completed successfully"
}

deny[msg] {
    ok == false
    msg := "[ERROR] Task not completed. Please try again."
}

error[msg] {
    msg := input.error
}