### A Pluto.jl notebook ###
# v0.19.9

#> [frontmatter]
#> title = "Julia Overview"
#> date = "2022-10-23"
#> tags = ["Julia", " Programming ", "Numerical"]
#> description = "Quick introduction to the Julia Language"

using Markdown
using InteractiveUtils

# ╔═╡ e6320cf8-9301-11ec-3f30-93a359f008f5
html"""
<div class="banner-background">
</div>

<div class="nb-intro">
	<div class="header-box"> 
		<p class="nb-intro-header">Introducción</p>
		<p class="nb-intro-title">Julia, un lenguaje para el cálculo científico</p>
		<p style="text-align:center;"> 
			<img src="https://github.com/RayleighLord/Resources/blob/main/img/logos/julia-logo.png?raw=true" alt="RayleighLord"
			width="50%"
			class="logo">
		</p>
	</div>
</div>

<style>

.banner-background {
	position: absolute;
	top: -550px;
	left: -40vw;
	height: 550px;
	width: 150vw;
	background-color: #212529;
	opacity: 1;
}

.nb-intro {
	position: absolute;
	top: -550px;
	left: -8px;
	height: 550px;
	width: calc(100% + 8px);
	background-image: #212529;
}

.header-box {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	gap: 20px;

	height: 500px;
	margin-top: 20px;
	padding: 0px 10px 0px 10px;
	border: 5px solid #adb5bd;
	border-radius: 50px;
	box-shadow: 0px 5px 20px rgba(255, 255, 255, 0.25);
	text-align: center;
	position: relative;
	transition: all 0.3s;
}

.header-box:hover {
	transform: translateY(-5px);	
	box-shadow: 0px 10px 30px rgba(255, 255, 255, 0.3);
}

.nb-intro-header {
	margin: 0;
	color: #adb5bd;
	font-family: Vollkorn, serif;
	font-size: 32px;
	font-weight: 500;
	font-feature-settings: 'lnum', 'pnum';
}

.nb-intro-title {
	margin: 0;
	margin-bottom: 15px;
	color: #f1f3f5;
	font-family: Vollkorn, serif;
	font-size: 50px;
	font-weight: 600;
	font-feature-settings: 'lnum', 'pnum';
	line-height: 1.2;
}

body {
	overflow-x: hidden;
	box-sizing: border-box;
}

pluto-cell:first-child {
	margin-top: 550px;
}

main preamble {
    height: 0px;
    margin: 0px;
    padding: 0px;
}

</style>
"""

# ╔═╡ 85655f3a-d7ec-4c39-adcb-6b5893a435f9
begin
	using PlutoUI
	PlutoUI.TableOfContents(title="Tabla de Contenidos", depth=3, aside=true, indent=true)
end

# ╔═╡ 88e26e6d-4dbf-427c-8c29-88d315b26361
md"""
# El lenguaje más próximo a las matemáticas
"""

# ╔═╡ b14db253-adee-4588-a87a-d31ba0b3f289
md"""
**Julia** es un lenguaje de propósito general, pero con el cálculo científico con un rol central en el desarrollo del mismo. 

En este cuaderno interactivo se van a mostrar algunas de las características de este lenguaje, para ilustrar el atractivo que tiene para hacer ciencia, teniendo la sintáxis más conectada con las ecuaciones que uno escribe en un papel.

Julia junta lo mejor de la sintáxis de lenguajes modernos, con un flujo de trabajo dinámico, pero permitiendo la compilación de código y así obteniendo velocidades de lenguajes de más bajo nivel.
"""

# ╔═╡ f18a63b1-ed8e-440e-9157-33f2d9e66373
md"""
## 1. Creación de vectores
"""

# ╔═╡ 9f7f0c59-1048-46fd-a898-142bfaf8fb1c
md"""
Productos con vectores y matrices son dos tipos de operaciones muy demandadas a realizar por un ordenador. Veamos cómo se trabaja con estos elementos en **Julia**, haciendo uso de caracteres especiales que este lenguaje nos permite para acercar el código lo más posible a las matemáticas. 
"""

# ╔═╡ 208a0087-4839-41de-a9fb-bad8f8bfc69f
md"""
Para empezar, vamos a crear dos vectores

$$\vec{u} = (1, 2, 3)^\top, \ \ \ \vec{v} = (1, 1, 1)^\top,$$
en las siguientes celdas.
"""

# ╔═╡ 316aa724-2b2c-4911-b5de-aa5302761808
u⃗ = [1, 2, 3]

# ╔═╡ cef72184-6aee-4984-a54b-8737adb0bde9
v⃗ = [1, 1, 1]

# ╔═╡ a98672ac-164d-4f81-b3eb-b0548bb36dd1
md"""
Como se puede observar, los vectores que hemos creado se han asignado a unas variables `u⃗` y `v⃗`, donde tienen la *flechita* de vector encima, lo cual no es común en un lenguaje de programación. Una gran característica de Julia es que permite utilizar casi cualquier caracter *Unicode* como variable, por lo que para crear una variable con el símbolo del vector simplemente se debe escribir `u\vec <tab>`, es decir, escribimos `u\vec` y luego presionamos el tabulador y el símbolo u se actualiza a `u⃗`.
"""

# ╔═╡ 5fba1a6b-fffe-4ec1-94f9-54d26f99e9ec
md"""
Adicionalmente, podemos utilizar letras griegas como variables usando los comandos de $\LaTeX$:
"""

# ╔═╡ d790336e-65f3-442f-88b8-1ab05bbb5b25
α, ω, λ = 1, 2, 3  # \alpha, \omega, \lambda

# ╔═╡ b60894c6-cc18-40e0-afd0-a78070d99f0d
md"""
## 2. Operaciones con vectores
"""

# ╔═╡ 5ff813d1-4e2f-4ada-9566-1d4102d8ee9e
md"""
Una vez hemos creado vectores, vamos a ver cómo se trabaja con ellos en Julia. Como este lenguaje permite usar un amplio rango de caracteres, también podemos incluir aquellos que representan ciertas operaciones matemáticas. Por ello, debido a la expresividad que tiene el lenguaje,  se pueden utilizar símbolos como `⋅` y `×` para ejecutar la operación de producto escalar y vectorial, respectivamente. 

Estas operaciones ya están definidas en la librería de Álgebra Lineal, que se puede importar con la línea `using LinearAlgebra`.
"""

# ╔═╡ fa730b29-923f-4aac-9746-c4263cd13ef4
using LinearAlgebra

# ╔═╡ 8523cacb-1260-42a2-aa84-930e6161246d
md"""
En primer lugar, haremos el producto escalar entre `u⃗` y `v⃗` utilizando el operador `*`, al cual ya estaremos acostumbrados si hemos usado *MATLAB*.
"""

# ╔═╡ 3e342bb6-8d16-4ac6-86cb-87be2fc6c06c
u⃗' * v⃗

# ╔═╡ fcd74f15-1ea7-47aa-8c59-9224eeaba491
md"""
donde se ha tomado la traspuesta del primer vector `u⃗`. Otra manera de realizar esta operación es directamente quitando el símbolo `*`, emulando así la notación matemática $\vec{u}^\top\vec{v}$,
"""

# ╔═╡ acd87882-9d96-4f7a-8fa1-95b0c64e873e
u⃗'v⃗

# ╔═╡ ac33c72f-26ba-411a-bd1e-f6a83a1ea941
md"""
Y, en último lugar, usando el símbolo `⋅` que suele denotar producto escalar,
"""

# ╔═╡ 91bfde05-4929-46af-85c8-e9d03c497566
u⃗ ⋅ v⃗  # Esta línea se escribe u\vec<tab> \cdot<tab> v\vec<tab>

# ╔═╡ a965957f-0dd9-4d83-9c4f-fa33b118cafc
md"""
Otra operación que implementa la librería `LinearAlgebra` es la de realizar el producto vectorial usando el comando `×`. Para demostrarlo, en la siguiente línea se calcula el producto $\vec{u} \times \vec{v}$
"""

# ╔═╡ 9ac7106f-4c20-4ab8-90f6-2dac9b695c30
u⃗ × v⃗ # Esta línea se escribe u\vec<tab> \times<tab> v\vec<tab>

# ╔═╡ 52312114-6ff5-44aa-8e51-205e152d7bac
md"""
- El **producto escalar** elimina una dimensión a los vectores, devolviendo un escalar. 
- El **producto vectorial** no varía el rango de los vectores, devolviendo otro vector del mismo tamaño. 

Ahora vamos a ver un tipo de operación que se denota como **producto tensorial**, el cual partiendo de dos vectores sube de rango y nos devuelve una matriz. Esta operación se denota con el símbolo `⊗` y, de manera visual, la operación que se realiza es 

$$\vec{u} \otimes \vec{v} = \begin{pmatrix}1 \\ 2 \\ 3\end{pmatrix} \otimes \begin{pmatrix}1 & 1 & 1\end{pmatrix} = \begin{pmatrix}1 * \begin{pmatrix}1 & 1 & 1\end{pmatrix}  \\ 2 * \begin{pmatrix}1 & 1 & 1\end{pmatrix} \\ 3 * \begin{pmatrix}1 & 1 & 1\end{pmatrix}\end{pmatrix} = 
\begin{pmatrix}
1 & 1 & 1 \\
2 & 2 & 2 \\
3 & 3 & 3 \\
\end{pmatrix},$$

es decir, se adjunta el vector $\vec{v}$ a cada una de las componentes del vector $\vec{u}$ y se multiplica por ellas.
"""

# ╔═╡ 3a9f04da-467e-46bd-9ff5-50103bec2287
md"""
Al contrario que con las anteriores operaciones, la librería de `LinearAlgebra` no tiene implementada la función del producto tensorial utilizando el símbolo `⊗`. Para realizar el producto tensorial, se usando el comando `kron`
"""

# ╔═╡ 93d9fe20-5964-4f54-a256-24ac195be54b
kron(u⃗, v⃗')

# ╔═╡ 2f39c616-e8f7-4f21-9788-cb4d9309c03c
md"""
Sin embargo, Julia nos permite definir nuestros propios símbolos para las operaciones! Por tanto, ejecutando la siguiente línea de código
"""

# ╔═╡ 560b658e-f24d-4115-b91d-495905878b3d
const ⊗ = kron

# ╔═╡ 90c03a13-b871-474b-88c8-d89c84a07ad8
md"""
ya podemos usar el símbolo ⊗ como producto tensorial, obteniendo el resultado correcto.
"""

# ╔═╡ 5edc73cd-9266-4c86-a18f-6023de6c1156
u⃗ ⊗ v⃗'

# ╔═╡ f0806dfa-37bc-46b4-8bd1-3e30fb340ef1
md"""
## 3. Matrices y sistemas lineales
"""

# ╔═╡ a991938e-bb3c-48c9-a65c-70f888aded85
md"""
Para generar una matriz, utilizamos una sintáxis idéntica a como lo escribiríamos en un papel.
"""

# ╔═╡ f8dfb372-07ba-4510-88ca-e94e4bd1d2a5
A = [1  2  3
     4  2  0 
     2  1  1]

# ╔═╡ ab61018a-bf28-4394-b09e-84d0e1b567ef
md"""
De esta manera, ya tenemos una matriz `A` con la que podemos operar con distintos elementos de una manera natural. Por ejemplo, si la multiplicamos por un vector por la derecha
"""

# ╔═╡ cb935843-51da-46d6-ae43-e0ea909bb6f1
A * u⃗

# ╔═╡ 249182a1-97b8-4df1-b6e7-657c96a7eec8
md"""
y por la izquierda
"""

# ╔═╡ ca75cba8-1d6d-4ec0-8726-8d4553bb9bd7
v⃗' * A

# ╔═╡ 814ba04b-d1ba-4997-9391-d94e50c91ac1
md"""
donde el vector `v` se ha tenido que trasponer, como es de esperar para que la operación tenga sentido matemático. Finalmente, si multiplicamos por un vector en cada lado, obtenemos un escalar
"""

# ╔═╡ 402d3b72-b46c-45f9-82b5-49167d6b4a70
v⃗' * A * u⃗

# ╔═╡ 33ebe4db-d360-44ff-bbbd-70415057dc66
md"""
Ahora vamos a ver brevemente cómo resolver un sistema lineal de ecuaciones en Julia. La resolución de sistemas lineales es uno de los problemas más frecuentes para los que se recurre a un ordenador. Estos problemas son del tipo $Ax = b$, donde para un $A$ y $b$ conocidos, tenemos que hallar el vector de incógnitas $x$.

Sin mucho conocimiento de nuestro problema, la aproximación más sencilla es utilizar el operador `\`, que resuelve el sistema sin invertir la matriz, por motivos de eficiencia. Sin embargo, Julia es un lenguaje que dependiendo del tipo de los argumentos de entrada de las funciones, puede ejecutar unas sentencias u otras (en inglés esto se llama *multiple dispatch* y es más general que la sobrecarga de funciones que hay en otros lenguajes como C++). 

Así, si por ejemplo la matriz `A` que le damos es una matriz factorizada con un tipo que reconoce Julia, el operador `\` se aprovecha directamente de esta factorización.
"""

# ╔═╡ 17f156dc-5748-4bf9-8448-464980bea454
md"""
Por ejemplo, si para la matriz $A$ definida anteriormente y un vector $b$ definido como
"""

# ╔═╡ f7a6b2f2-2983-4b17-b8ae-46dc17f2bd3b
b = [1, 2, 3]

# ╔═╡ 633087ba-b8b1-468c-89b6-e38f8360d3ad
md"""
podemos resolver el sistema lineal y obtener la solución $x$.
"""

# ╔═╡ 94a61f0c-fcc2-4324-9d12-45a96393ea46
x = A \ b

# ╔═╡ 0d5314bc-f3fc-42c9-a01f-fa861fa324e8
md"""
Si en vez de utilizar la matriz $A$ directamente, la queremos factorizar primero (por ejemplo usando LU), lo podemos realizar utilizando el comando `lu(A)`.
"""

# ╔═╡ af865a86-7601-4f2b-9d3b-bf286a21283b
luA = lu(A)

# ╔═╡ 1fdfe3a2-18d9-4877-b77d-2ac6341920fd
md"""
En este caso, cuando al operador `\` le pasemos la matriz `luA`, detectará que es una matriz factorizada y resolverá el sistema directamente por sustitución hacia atras.
"""

# ╔═╡ 2dddd1f8-6cd0-453c-99fb-ff072ba0f4f7
xlu = luA \ b

# ╔═╡ 7f622b13-7ca0-4627-b3be-4ebf6e6a4f22
md"""
Como vemos, obtenemos la misma solución con el método LU y sin él. Además, la sintáxis es muy sencilla sin requerir la ejecución de comandos complicados para realizar la factorización LU.
"""

# ╔═╡ 51fdc6fd-0b25-40a0-9fac-a06f2a6942ac
md"""
## 4. Funciones en Julia
"""

# ╔═╡ ce3d0cca-9c01-4a9e-95e4-bee564ea5881
md"""
En Julia, como en otros lenguajes de programación, las funciones son ciudadanos de primera clase. En Julia, las funciones se pueden definir de varias maneras distintas, asignar a variables, pasar como argumento a otras funciones...

Y, de nuevo, para su definición se permite una sintáxis muy próxima al lenguaje matemático.
"""

# ╔═╡ baf63de6-447b-4947-be23-a441bdd81f8d
md"""
 Por ejemplo, si queremos definir la función $f(x) = x^3 + 6x$, lo podemos hacer como
"""

# ╔═╡ dc8a7b0e-152b-4da5-84b1-0645acfa5686
f(x) = x^3 + 6x

# ╔═╡ 8086471a-2b98-427f-bd3c-4836fac8ee6e
md"""
En este caso, no es necesario el símbolo `*` entre el $6$ y la $x$, aunque habría sido una definición equivalente poner `6 * x`. Para comprobar que funciona bien, la evaluamos en un punto concreto
"""

# ╔═╡ 2628e240-b6e8-4bbb-9863-f1d8bcf6d85e
f(2)

# ╔═╡ 16ebe9bc-54c3-4824-8e72-961ba2add984
md"""
Una manera equivalente de definir la función `f(x)`, con una sintáxis más parecida a la de otros lenguajes de programación es
"""

# ╔═╡ 130d6e36-f8e6-4382-b6a3-7a4dd83c5bb4
function g(x)
	return x^3 + 6x
end

# ╔═╡ 67171529-8374-4bb3-a1e4-9a0444611c73
md"""
Que, como no puede ser de otra manera, aporta el mismo resultado al evaluarla en $x = 2$.
"""

# ╔═╡ 7a0b0ecb-90e3-42f3-9d81-ee9659be5445
g(2)

# ╔═╡ 36054816-4e6a-42d9-8405-db3f686272c8
md"""
Si hemos estado atentos, al definir una función habremos visto el mensaje `g (generic function with 1 method)`. ¿Qué quiere decir que tiene un método? ¿Se puede usar la misma función para realizar tareas distintas?

Esto tiene que ver con una característica muy importante de Julia, conocida como **Multiple Dispatch**. Esto es que una función, dependiendo del tipo de sus variables de entrada, puede realizar una tarea u otra.

En lenguajes como Python o JavaScript, no existe esta funcionalidad, ya que estos lenguajes solo permiten *Single Dispatch*. Es decir, solo pueden especializar las funciones en base al primer argumento de entrada.

En Julia, para indicar que una variable es de un tipo concreto, se usa la sintáxis `::`. Por ejemplo, `x::Int64` quiere decir que la variable `x` es un entero que ocupa 64 bits.

Retomando la función anteriormente definida, vamos a indicar que tenga un comportamiento distinto si su variable de entrada es entera o real.
"""

# ╔═╡ 7880ec38-3308-481a-a9d1-f1d9abea3039
f(x::Int64) = x^3 + 6x

# ╔═╡ d18935bf-bc84-473e-998c-1aefbdafd50a
f(x::Float64) = 400

# ╔═╡ 44828337-6857-4e8c-8394-418f070777ce
f(2)

# ╔═╡ 8c48cd89-84e1-43e8-bd11-d73f9fe1d880
f(2.0)

# ╔═╡ 6fd30161-bdd4-4f7b-a2f6-ab34f3fce07f
md"""
En los ejemplo anteriores, vemos que la misma función `f` devuelve dos valores distintos según sus argumentos de entrada. Esto nos permite utilizar el mismo nombre de una función para ejecutar diferentes sentencias de código según el tipo de sus argumentos de entrada. Pero eso no es todo... como veremos en la próxima sección.
"""

# ╔═╡ 02b387e6-7a49-487b-8395-a2e6f8963389
md"""
Como última pincelada, Julia también implementa una sintáxis muy matemática para la composición de funciones. Por ejemplo, si queremos implementar una función $h(x) = (h₁ ∘ h₂)(x)$, se escribiría como
"""

# ╔═╡ f84cba9e-5999-4c9c-aa87-6a8c567b89a7
h₁(x) = x + 1

# ╔═╡ f6e73ccd-bcba-4107-aedf-0bb020067e40
h₂(x) = exp(x)

# ╔═╡ 78808720-76c4-4be0-ace3-e5f1d6e65004
h(x) = (h₁ ∘ h₂)(x)

# ╔═╡ 5f997fdb-f2c2-4177-8dac-4b94f662a89f
h(2)

# ╔═╡ 5fa78379-ad75-46b5-9985-2fb59bee773e
md"""
¡Se implementa exactamente igual a como lo haríamos en papel!
"""

# ╔═╡ 91aad26b-7dce-4c22-939f-ea8a08c1d522
md"""
## 5. Tipos de variables en Julia, compilación JIT
"""

# ╔═╡ a202909a-c860-43dd-84f9-d3feb128c07a
md"""
Una persona que haya utilizado lenguajes dinámicos como *Python*, *MATLAB* o *R*, podría pensar que, a parte de por ciertos aspectos estéticos, Julia no aporta mucho más respecto a estos lenguajes.
"""

# ╔═╡ 15e7dd40-7a2d-4488-9f86-fdd1675673f3
md"""
Sin embargo, hay una distinción que implica una gran diferencia y es que Julia, a diferencia de estos otros lenguajes, *no* es interpretado. Esto quiere decir que, cuando se ejecuta una función en Julia, primero se genera un código compilado y luego se ejecuta este código compilado cuando se llame a la función.

Esto se realiza mediante un compilador *Just in Time* (JIT), que permite que el lenguaje sea dinámico y no haya que generar ejecutables de una serie de archivos fuente como en lenguajes de más bajo nivel como C/C++ o Fortran.

Además, cabe destacar que las velocidades de ejecución de los programas en Julia alcanzan a códigos escritos en estos otros lenguajes de mucho más bajo nivel.

Esto permite resolver el conocido como **_Problema de los dos lenguajes_**. Actualmente, para obtener un prototipo rápido de una idea, la velocidad de desarrollo es mucho mayor en un lenguaje dinámico e interpretado como Python. Una vez probada esta idea, si se requiere de rendimiento, hay que acudir a un lenguaje de más bajo nivel y mucho más complicado de programar.

Julia pretende resolver este problema ofreciendo un lenguaje dinámico pero donde las las funciones se compilan antes de ejecutarse, ganando así el rendimiento que se perdería en lenguajes interpretados.
"""

# ╔═╡ 1cea1cae-c9bd-4fc3-a4b5-d8b11efa7c21
md"""
Como Julia permite acceder a otros lenguajes de manera muy sencilla, vamos a comparar la velocidad de ejecución de la una función que sume todas las componentes de un vector cualquiera.

En primer lugar, generamos un vector de $10^7$ componentes
"""

# ╔═╡ 1d07ba4c-c5f0-45c2-893b-c8288d0020f1
t = rand(10^7) # vector de 10.000.000 de componentes generadas de manera aleatoria

# ╔═╡ f4a7023d-e674-47b6-bc24-fd886b063229
md"""
A continuación, realizamos una implementación sencilla de la función `j_suma` que realice esta operación. Indicamos los tipos de variable de la función.
"""

# ╔═╡ ce98ba8d-eccd-4df5-95d2-0d354334bfaf
function j_suma(xs::Vector{Float64})
	suma = 0.0
	for x in xs
		suma += x
	end
	return suma
end

# ╔═╡ 28af7bdc-a27e-4f65-985a-4f2efd7c57f6
md"""
Para medir el rendimiento de la función, importamos el paquete `BenchmarkTools'. que nos da unas macros muy sencillas de usar que nos mide los distintos tiempos de ejecución de una función.
"""

# ╔═╡ b1f50a69-cb67-4d7c-a1d7-3d0e824f0090
using BenchmarkTools

# ╔═╡ 9a0fa2e2-72fe-449f-a674-6eea81d852b6
@benchmark j_suma($t)  # Mide el tiempo de ejecución de la función suma

# ╔═╡ 02203802-d942-4c35-b617-df9a869ba3af
md"""
Como vemos, el mínimo tiempo de ejecución es de unos 10 ms. El valor de la variable de entrada dado es `$t`. El único motivo por el que se incluye el símbolo `$` es para que Julia no lo tome como una variable global y pueda medir el rendimiento de manera justa respecto a otros lenguajes.

Veamos ahora un código en C que se puede importar fácilmente en Julia.
"""

# ╔═╡ c2fee776-5fa2-4014-86be-392327c7e414
begin
	using Libdl
	C_code = """
	    #include <stddef.h>
	    double c_sum(size_t n, double *X) {
	        double s = 0.0;
	        for (size_t i = 0; i < n; ++i) {
	            s += X[i];
	        }
	        return s;
	    }
	"""
	const Clib = tempname()
	open(`gcc -fPIC -O3 -msse3 -xc -shared -o $(Clib * "." * Libdl.dlext) -`, "w") do f
    print(f, C_code)
end
end

# ╔═╡ c1fa0c53-a859-4cdc-87a8-7df6d70eb41c
c_suma(X::Array{Float64}) = ccall(("c_sum", Clib), Float64, (Csize_t, Ptr{Float64}), length(X), X)

# ╔═╡ 3a9c5db0-615f-41a5-8b50-dddd2ad8193e
@benchmark c_suma($t)

# ╔═╡ 82fb52d0-d02f-434b-aab2-78d090092d13
md"""
A la vista de los benchmark anteriores, una implementación *naive* de la función suma tanto en Julia como en C aporta tiempos muy similares. 

Probemos esta misma implementación utilizando Python nativo (sin librerías).
"""

# ╔═╡ cfcae87d-a350-46bb-a2a2-882c4f2ab982
using PyCall

# ╔═╡ a52b5ed1-a6ce-49f4-9999-fd0f59b0f8e6
begin
py"""
def py_suma(xs):
	s = 0.0
	for x in xs:
		s +=x
	return s
"""
suma_py = py"py_suma"
end

# ╔═╡ e7088dc8-25c6-4eb4-9050-8deb67008e71
@benchmark suma_py($t)

# ╔═╡ 0d7df1b9-c9cf-4967-89b7-2b1bebb04945
md"""
Como se puede ver, la implementación nativa de Python es muchísimo más lenta que Julia y C. Esto es debido a que, en un lenguaje interpretado, la ejecución de bucles es una operación muy mala para el rendimiento porque en cada iteración tiene que checkear los tipos de variables. 

En Python, para conseguir velocidad se necesita utilizar una librería llamada NumPy, la cual llama a códigos optimizados en C y Fortran para realizar este tipo de cálculos. En la jerga de Python y MATLAB, siempre se suele decir que para obtener rendimiento hay que vectorizar todo lo posible el código, que no es otra cosa que escribirlo de tal manera que se puedan hacer el máximo número de llamadas posibles a lenguajes de bajo nivel que ejecuten el código de manera muy eficiente.
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
BenchmarkTools = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
Libdl = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
PyCall = "438e738f-606a-5dbb-bf0a-cddfbfd45ab0"

[compat]
BenchmarkTools = "~1.3.1"
PlutoUI = "~0.7.39"
PyCall = "~1.94.1"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.2"
manifest_format = "2.0"
project_hash = "764a2da6c23813b09ad1fec485fcb8257e385a1c"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BenchmarkTools]]
deps = ["JSON", "Logging", "Printf", "Profile", "Statistics", "UUIDs"]
git-tree-sha1 = "4c10eee4af024676200bc7752e536f858c6b8f93"
uuid = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
version = "1.3.1"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "0.5.2+0"

[[deps.Conda]]
deps = ["Downloads", "JSON", "VersionParsing"]
git-tree-sha1 = "6e47d11ea2776bc5627421d59cdcc1296c058071"
uuid = "8f4d0f93-b110-5947-807f-2305c1781a2d"
version = "1.7.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "c47c5fa4c5308f27ccaac35504858d8914e102f9"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.4"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "3d3e902b31198a27340d0bf00d6ac452866021cf"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.9"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.0+0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.2.1"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.20+0"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "3d5bf43e3e8b412656404ed9466f1dcbf7c50269"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.4.0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.8.0"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "8d1f54886b9037091edf146b517989fc4a09efec"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.39"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Profile]]
deps = ["Printf"]
uuid = "9abbd945-dff8-562f-b5e8-e1ebf5ef1b79"

[[deps.PyCall]]
deps = ["Conda", "Dates", "Libdl", "LinearAlgebra", "MacroTools", "Serialization", "VersionParsing"]
git-tree-sha1 = "53b8b07b721b77144a0fbbbc2675222ebf40a02d"
uuid = "438e738f-606a-5dbb-bf0a-cddfbfd45ab0"
version = "1.94.1"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.Tricks]]
git-tree-sha1 = "6bac775f2d42a611cdfcd1fb217ee719630c4175"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.6"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.VersionParsing]]
git-tree-sha1 = "58d6e80b4ee071f5efd07fda82cb9fbe17200868"
uuid = "81def892-9a0e-5fdd-b105-ffc91e053289"
version = "1.3.0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.12+3"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.1.1+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"
"""

# ╔═╡ Cell order:
# ╟─f5450eab-0f9f-4b7f-9b80-992d3c553ba9
# ╟─e6320cf8-9301-11ec-3f30-93a359f008f5
# ╠═85655f3a-d7ec-4c39-adcb-6b5893a435f9
# ╟─88e26e6d-4dbf-427c-8c29-88d315b26361
# ╟─b14db253-adee-4588-a87a-d31ba0b3f289
# ╟─f18a63b1-ed8e-440e-9157-33f2d9e66373
# ╟─9f7f0c59-1048-46fd-a898-142bfaf8fb1c
# ╟─208a0087-4839-41de-a9fb-bad8f8bfc69f
# ╠═316aa724-2b2c-4911-b5de-aa5302761808
# ╠═cef72184-6aee-4984-a54b-8737adb0bde9
# ╟─a98672ac-164d-4f81-b3eb-b0548bb36dd1
# ╟─5fba1a6b-fffe-4ec1-94f9-54d26f99e9ec
# ╠═d790336e-65f3-442f-88b8-1ab05bbb5b25
# ╟─b60894c6-cc18-40e0-afd0-a78070d99f0d
# ╟─5ff813d1-4e2f-4ada-9566-1d4102d8ee9e
# ╠═fa730b29-923f-4aac-9746-c4263cd13ef4
# ╟─8523cacb-1260-42a2-aa84-930e6161246d
# ╠═3e342bb6-8d16-4ac6-86cb-87be2fc6c06c
# ╟─fcd74f15-1ea7-47aa-8c59-9224eeaba491
# ╠═acd87882-9d96-4f7a-8fa1-95b0c64e873e
# ╟─ac33c72f-26ba-411a-bd1e-f6a83a1ea941
# ╠═91bfde05-4929-46af-85c8-e9d03c497566
# ╟─a965957f-0dd9-4d83-9c4f-fa33b118cafc
# ╠═9ac7106f-4c20-4ab8-90f6-2dac9b695c30
# ╟─52312114-6ff5-44aa-8e51-205e152d7bac
# ╟─3a9f04da-467e-46bd-9ff5-50103bec2287
# ╠═93d9fe20-5964-4f54-a256-24ac195be54b
# ╟─2f39c616-e8f7-4f21-9788-cb4d9309c03c
# ╠═560b658e-f24d-4115-b91d-495905878b3d
# ╟─90c03a13-b871-474b-88c8-d89c84a07ad8
# ╠═5edc73cd-9266-4c86-a18f-6023de6c1156
# ╟─f0806dfa-37bc-46b4-8bd1-3e30fb340ef1
# ╟─a991938e-bb3c-48c9-a65c-70f888aded85
# ╠═f8dfb372-07ba-4510-88ca-e94e4bd1d2a5
# ╟─ab61018a-bf28-4394-b09e-84d0e1b567ef
# ╠═cb935843-51da-46d6-ae43-e0ea909bb6f1
# ╟─249182a1-97b8-4df1-b6e7-657c96a7eec8
# ╠═ca75cba8-1d6d-4ec0-8726-8d4553bb9bd7
# ╟─814ba04b-d1ba-4997-9391-d94e50c91ac1
# ╠═402d3b72-b46c-45f9-82b5-49167d6b4a70
# ╟─33ebe4db-d360-44ff-bbbd-70415057dc66
# ╟─17f156dc-5748-4bf9-8448-464980bea454
# ╠═f7a6b2f2-2983-4b17-b8ae-46dc17f2bd3b
# ╟─633087ba-b8b1-468c-89b6-e38f8360d3ad
# ╠═94a61f0c-fcc2-4324-9d12-45a96393ea46
# ╟─0d5314bc-f3fc-42c9-a01f-fa861fa324e8
# ╠═af865a86-7601-4f2b-9d3b-bf286a21283b
# ╟─1fdfe3a2-18d9-4877-b77d-2ac6341920fd
# ╠═2dddd1f8-6cd0-453c-99fb-ff072ba0f4f7
# ╟─7f622b13-7ca0-4627-b3be-4ebf6e6a4f22
# ╟─51fdc6fd-0b25-40a0-9fac-a06f2a6942ac
# ╟─ce3d0cca-9c01-4a9e-95e4-bee564ea5881
# ╟─baf63de6-447b-4947-be23-a441bdd81f8d
# ╠═dc8a7b0e-152b-4da5-84b1-0645acfa5686
# ╟─8086471a-2b98-427f-bd3c-4836fac8ee6e
# ╠═2628e240-b6e8-4bbb-9863-f1d8bcf6d85e
# ╟─16ebe9bc-54c3-4824-8e72-961ba2add984
# ╠═130d6e36-f8e6-4382-b6a3-7a4dd83c5bb4
# ╟─67171529-8374-4bb3-a1e4-9a0444611c73
# ╠═7a0b0ecb-90e3-42f3-9d81-ee9659be5445
# ╟─36054816-4e6a-42d9-8405-db3f686272c8
# ╠═7880ec38-3308-481a-a9d1-f1d9abea3039
# ╠═d18935bf-bc84-473e-998c-1aefbdafd50a
# ╠═44828337-6857-4e8c-8394-418f070777ce
# ╠═8c48cd89-84e1-43e8-bd11-d73f9fe1d880
# ╟─6fd30161-bdd4-4f7b-a2f6-ab34f3fce07f
# ╟─02b387e6-7a49-487b-8395-a2e6f8963389
# ╠═f84cba9e-5999-4c9c-aa87-6a8c567b89a7
# ╠═f6e73ccd-bcba-4107-aedf-0bb020067e40
# ╠═78808720-76c4-4be0-ace3-e5f1d6e65004
# ╠═5f997fdb-f2c2-4177-8dac-4b94f662a89f
# ╟─5fa78379-ad75-46b5-9985-2fb59bee773e
# ╟─91aad26b-7dce-4c22-939f-ea8a08c1d522
# ╟─a202909a-c860-43dd-84f9-d3feb128c07a
# ╟─15e7dd40-7a2d-4488-9f86-fdd1675673f3
# ╟─1cea1cae-c9bd-4fc3-a4b5-d8b11efa7c21
# ╠═1d07ba4c-c5f0-45c2-893b-c8288d0020f1
# ╟─f4a7023d-e674-47b6-bc24-fd886b063229
# ╠═ce98ba8d-eccd-4df5-95d2-0d354334bfaf
# ╟─28af7bdc-a27e-4f65-985a-4f2efd7c57f6
# ╠═b1f50a69-cb67-4d7c-a1d7-3d0e824f0090
# ╠═9a0fa2e2-72fe-449f-a674-6eea81d852b6
# ╟─02203802-d942-4c35-b617-df9a869ba3af
# ╠═c2fee776-5fa2-4014-86be-392327c7e414
# ╠═c1fa0c53-a859-4cdc-87a8-7df6d70eb41c
# ╠═3a9c5db0-615f-41a5-8b50-dddd2ad8193e
# ╟─82fb52d0-d02f-434b-aab2-78d090092d13
# ╠═cfcae87d-a350-46bb-a2a2-882c4f2ab982
# ╠═a52b5ed1-a6ce-49f4-9999-fd0f59b0f8e6
# ╠═e7088dc8-25c6-4eb4-9050-8deb67008e71
# ╟─0d7df1b9-c9cf-4967-89b7-2b1bebb04945
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
