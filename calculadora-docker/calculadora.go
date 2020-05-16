package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"net/http"
	"strconv"
	"strings"
	"github.com/gorilla/mux"
)

type Calculadora struct {
	Valor1    int
	Operador  string
	Valor2    int
	Resultado int
}

type ErroDefault struct {
	ErroDefault string
}

var historico []Calculadora

func main() {

	mux := mux.NewRouter()
	mux.HandleFunc("/calc/", menu)
	mux.HandleFunc("/calc/{operador}/{a}/{b}", calculate)
	mux.HandleFunc("/calc/history", history)

	http.Handle("/", mux)
	http.ListenAndServe(":8080", nil)
}

func menu(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "\n********************************\n")
	fmt.Fprintf(w, "* Seja bem vindo à Calculadora *\n")
	fmt.Fprintf(w, "********************************\n\n")
	fmt.Fprintf(w, "a -> Refere-se ao 1º valor informado.\n")
	fmt.Fprintf(w, "b -> Refere-se ao 2º valor informado.\n")
	fmt.Fprintf(w, "\nOperações:\n")
	fmt.Fprintf(w, "\nSoma:")
	fmt.Fprintf(w, "Para realizar a operação de soma basta acessar: /calc/sum/{a}/{b} \n")
	fmt.Fprintf(w, "\nSubtração:")
	fmt.Fprintf(w, "Para realizar a operação de subtração basta acessar: /calc/sub/{a}/{b} \n")
	fmt.Fprintf(w, "\nMultiplicação:")
	fmt.Fprintf(w, "Para realizar a operação de multiplicação basta acessar: /calc/mult/{a}/{b} \n")
	fmt.Fprintf(w, "\nDivisão:")
	fmt.Fprintf(w, "Para realizar a operação de divisão basta acessar: /calc/div/{a}/{b} \n")
	fmt.Printf("********************************")
	fmt.Fprintf(w, "\nHistórico:")
	fmt.Fprintf(w, "Para acessar o histórico de operações basta acessar: calc/history \n")
}

func conversorNumeros(w http.ResponseWriter, request *http.Request) (int, int, error) {
	parametros := mux.Vars(request)
	valor1, errorValor1 := strconv.Atoi(parametros["a"])
	valor2, errorValor2 := strconv.Atoi(parametros["b"])
	if errorValor1 == nil && errorValor2 == nil {
		return valor1, valor2, nil
	}
	return 0, 0, errors.New("O formato dos números é inválido!")
}

func history(w http.ResponseWriter, request *http.Request) {
	response, err := json.Marshal(historico)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.Header().Set("Content-Type", "application/json")
	w.Write(response)

}

func calculate(w http.ResponseWriter, request *http.Request) {
	valor1, valor2, errConvert := conversorNumeros(w, request)
	url := strings.Split(request.URL.Path, "/")

	if errConvert != nil {
		http.Error(w, errConvert.Error(), http.StatusInternalServerError)
	}

	switch url[2] {
	case "sum":
		resultado := valor1 + valor2
		calculator := Calculadora{valor1, "+", valor2, resultado}
		historico = append(historico, calculator)
		js, err := json.Marshal(calculator)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		w.Header().Set("Content-Type", "application/json")
		w.Write(js)

	case "div":
		resultado := valor1 / valor2
		calculator := Calculadora{valor1,  "/" , valor2, resultado}
		historico = append(historico, calculator)
		js, err := json.Marshal(calculator)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}
		w.Header().Set("Content-Type", "application/json")
		w.Write(js)

	case "mult":
		resultado := valor1 * valor2
		calculator := Calculadora{valor1,"*", valor2, resultado}
		historico = append(historico, calculator)
		js, err := json.Marshal(calculator)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}

		w.Header().Set("Content-Type", "application/json")
		w.Write(js)

	case "sub":
		resultado := valor1 - valor2
		calculator := Calculadora{valor1,"-" ,valor2, resultado}
		historico = append(historico, calculator)
		js, err := json.Marshal(calculator)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}

		w.Header().Set("Content-Type", "application/json")
		w.Write(js)

	default:
		js, err := json.Marshal(ErroDefault{"Operação Inválida!"})
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		Error := []byte(js)
		w.WriteHeader(http.StatusBadRequest)
		w.Write([]byte(Error))
	}
}
