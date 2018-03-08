//: Funciones como valores

// Funciones como valores de retorno de otra funcion

typealias IntToInt = (Int) -> Int

func adder(n: Int) -> IntToInt {
    
    func f(x: Int) -> Int {
        return x + n
    }
    
    return f
}

let h = adder(n: 32)
h(1)

let g = adder(n: 100)
g(10)

// Funciones como parametros de entrada (de otra funcion):

func apply(f: IntToInt, n: Int) -> Int {
    return f(n)
}

apply(f: h, n: 12)

// Toda funcion de swift es, en realida, una clausura
// Puede acceder a todo lo que se haya definido previamente: capturar el entorno lexico

// Sintaxis de Clausura
func f(_ n: Int) -> Int {
    return n + 1
}

// Esto es equivalente a:
let f1 = { (n: Int) -> Int in
    let result = n + 1
    return result
}

f(8)
f1(8)

// metemos funciones dentro de un array
let functions = [f, f1, h, g]

for fn in functions {
    dump(fn(42))
}

// La sintaxis abreviada de clousures
let clousures = [
    f, // 100% explicita
    {(n: Int) -> Int in return n + 1 }, // 100% explicita
    { n in return n + 1 }, // No hace falta especificar el tipo de entrada. Lo infiere.
    { n in n * 3 }, // Si el cuerpo solo tiene una linea, no hace falta el return
    { $0 + 1 } // No hace falta el nombre del paramentro
]

// La sintaxis ultra-minimalista se usa mucho en Swift, sobre todo en las clausuras de finalizacion
let evens = [6, 12, 2, 8, 4, 10]

var array = evens.sorted(by: { (a: Int, b: Int) -> Bool in a > b })
print(array)

func ordenar(a: Int, b: Int) -> Bool {
    return a < b
}

array = evens.sorted(by: ordenar)
print(array)

array = evens.sorted(by: { (a: Int, b: Int) in a > b })
print(array)

array = evens.sorted(by: { a, b in a > b })
print(array)

array = evens.sorted(by: { $0 > $1 })
print(array)

// La clausura que cuelga

array = evens.sorted {
    $0 < $1
}

array = evens.sorted { a, b in
    a < b
}

//: Operacion sobre colecciones con PROGRAMACION FUNCIONAL
// Clasicos de FP: map, flatMap, filter, reduce...

// MAP
// Recibe una coleccion y una funcion que se aplica a cada uno de los elementos
// Iteracion para Chuck Norris

var results = [Int]()
for element in evens {
    results.append(element * 2)
}
print(evens)
print(results)

// Se puede hacer mejor con MAP
let resultsString =
    evens.map{ $0 * 2 }
         .map{ String($0) }

print(resultsString)

// Filter: recibe un filtro y devuelve un Bool
results = []
for element in evens {
    if element > 6 {
        results.append(element)
    }
}
print(results)

results = evens.filter { $0 > 6 }
print(results)


// FlatMap: es un map que se salta los niles
let intOrNil: [Int?] = [6, nil, nil, 12, 2, nil, 8, 4, nil, 10]

var res = intOrNil.flatMap { $0 }
print(res)

// limpiar nil
// * 2
// String
// Hola valor

let other = intOrNil
    .flatMap{ $0 }
    .map{ $0 * 2 }
    .map{ String($0) }
    .map{ "Hola \($0)" }

print(other)






































