package main

import (
	"encoding/json"
	"html/template"
	"log"
	"net/http"
)

type TemplateData struct {
	Roll int
}

type Result struct {
	Roll int
}

func main() {
	tmpl := template.Must(template.ParseFiles("layout.html"))
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {

		var result Result
		resp, err := http.Get("http://roll-backend:9300/roll")
		if err != nil {
			log.Printf("Something went wrong during GET: %v", err)
		}
		defer resp.Body.Close()

		err = json.NewDecoder(resp.Body).Decode(&result)
		if err != nil {
			log.Println("Could not decode %v", err)
		}

		data := TemplateData{
			Roll: result.Roll,
		}
		tmpl.Execute(w, data)
		log.Println("200 - OK")
	})
	http.ListenAndServe(":9301", nil)
}
