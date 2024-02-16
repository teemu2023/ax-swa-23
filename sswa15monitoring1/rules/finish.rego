package sbercode

allow[msg] {
	res := input.results[_]
	res.httpbin_retcode == "OK"
	msg := "[OK] /probe отвечает"
}

deny[msg] {
	res := input.results[_]
	res.httpbin_retcode != "OK"
	msg := sprintf("[ERROR] /probe не отвечает")
}

error[msg] {                                                                                                           
  msg := input.error
}
