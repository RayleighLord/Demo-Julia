### A Pluto.jl notebook ###
# v0.19.14

#> [frontmatter]
#> title = "Julia Homework Demonstration"
#> date = "2022-10-23"
#> tags = ["Julia", "Programming", "Numerical"]
#> description = "Julia Homework Demonstration Completed"

using Markdown
using InteractiveUtils

# ╔═╡ c4a419ab-64d2-486c-a001-50a200d17f45
begin
	using PlutoUI
	PlutoUI.TableOfContents(title="Tabla de Contenidos", depth=3, aside=true, indent=true)
end

# ╔═╡ e6320cf8-9301-11ec-3f30-93a359f008f5
html"""
<div class="banner-background">
</div>

<div class="nb-intro">
	<div class="header-box"> 
		<p class="nb-intro-header"> Entregable Completado </p>
		<p class="nb-intro-title">Cuaderno con ejercicios interactivos en Julia</p>
		<p style="text-align:center;"> 
			<img src="https://github.com/RayleighLord/Resources/blob/main/img/logos/logo.png?raw=true" alt="RayleighLord"
			width="30%"
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

# ╔═╡ 7e714c42-fca6-4298-8e8e-8ed26d549617
md"""
# Cuadernos interactivos en Pluto
"""

# ╔═╡ 6c741cbd-e728-41fb-8519-8e652567c048
md"""
Este cuaderno pretende ser un pequeño ejemplo de las posibilidades que nos permiten los cuadernos interactivos de _**Pluto**_ con el lenguaje _**Julia**_. 

A diferencia de los _**Jupyter Notebooks**_, en _**Pluto**_ todas las celdas se actualizan de manera automática. Esto quiere decir que, al modificar una variable en una celda, se modifican todas las celdas que dependen de esa variable. En _**Jupyter**_ habría que reejecutar todo el cuaderno para ver cómo afecta el cambio de una variable.

A continuación, a través de varios ejercicios, se va a mostrar el abanico de opciones que nos ofrece la herramienta para generar cuadernos de ejercicios los cuales van guiando a la persona que lo está haciendo de manera interactiva, indicando si el resultado que se obtiene es correcto o no y dando pistas sobre donde pueden estar los errores.

"""

# ╔═╡ 94773345-69a2-4c73-ad9c-0649176699e9
md"""
_Ejemplo de ejercicios de clase_
"""

# ╔═╡ a53f7ba6-db95-451a-b34e-33d08d8843c8
estudiante = (nombre = "Javier", correo = "javier.gonzalez.monge")

# ╔═╡ 589ec36c-672c-4f61-af1c-9502ace05074
md"""
Enviado por: _**$(estudiante.nombre)**_ ($(estudiante.correo)@alumnos.upm.es)
"""

# ╔═╡ 8d734d93-e6ee-4a3b-8e48-eaf402997bce
md"""
## Ejercicio 1. Encontrar números primos
"""

# ╔═╡ b7c8437a-c2bb-4d5d-bb33-02f958253ce8
md"""
📝 En este ejercicio se pide completar la función esprimo (de una manera sencilla, no es necesario optimizar), para que, dado un número, nos devuelva `true` si es primo o `false` si no lo es. 
"""

# ╔═╡ 8787e409-299c-45c2-aec5-15921116850c
md"""
Una vez programada la función, comenzaremos comprobando que el número $19$ es primo.
"""

# ╔═╡ c5ab0653-1996-48a9-ae44-467f94fd07fa
"""
	esprimo(x)

Comprueba si el número `x` es primo.
"""
function esprimo(x::Int)
	
	for k in 2:x-1
		if x % k == 0
			return false
		end
	end
	
	return true
end

# ╔═╡ f133d62e-819a-4a6a-8fb8-3e70ed9dc5ad
primo = esprimo(19)

# ╔═╡ 1040cfca-6e6d-491a-878e-d65356286ac9
md"""
Es probable que en la implementación realizada en `esprimo`, no se haya tenido en cuenta los casos en los que se da como argumento de entrada un número entero negativo o cero. Por tanto, vamos a crear una versión mejorada de nuestra función para tener en cuenta este caso.
"""

# ╔═╡ 1b2b42ed-5497-4ba1-8671-aa15cd0a91b3
md"""
📝 Crea una función `esprimo2` que devuelva un error cuando el número introducido no es natural. 
"""

# ╔═╡ 40c0cb49-296e-428f-94cd-e78447f5b19b
function esprimo2(x::Int)
	if x ≤ 0 
		throw("No se puede introducir un número negativo")
	else
		for k in 2:x-1
			if x % k == 0
				return false
			end
		end
	
		return true
	end
end

# ╔═╡ 2c454d25-1892-454e-a55e-a4faddeaeb4e
error = esprimo2(-1)

# ╔═╡ 6ca766ff-e0ca-46a0-b787-7f7b38d36f2f
md"""
## Ejercicio 2: Sorpresas con la aritmética en coma flotante
"""

# ╔═╡ 9946abb5-b504-46b7-a19d-8320f60215af
md"""
A diferencia de la aritmética con números reales, donde para algunos cálculos esperamos el resultado exacto `0`, es frecuente encontrarse al operar en un ordenador con números como `1e-15` ó `1e-16`. Esto está relacionado con la manera de almacenar números de un ordenador.
"""

# ╔═╡ cdb3d006-c4d1-4e10-9c59-28b7e89eb263
md"""
### Ejercicio 2.1
"""

# ╔═╡ d8447d04-17a6-438e-810a-065c6198071b
md"""
📝 Encuentra todos los enteros $k$ con $1 ≤ k ≤ 10000$ para los cuales `Julia` satisface que `k * (1 / k) ≠ 1`. Almacénalos en la variable `lista`.
"""

# ╔═╡ 7d04eec0-f8ac-46d7-b5fb-f13b324a72bb
md"""
### Ejercicio 2.2
"""

# ╔═╡ ae751e41-2009-4d3f-9a8e-101e322d92c1
md"""
📝 Utilizando el número `k` mayor encontrado que cumple lo pedido en el apartado [anterior](#cdb3d006-c4d1-4e10-9c59-28b7e89eb263), calcular el error respecto al cálculo exacto.
"""

# ╔═╡ ecc5827c-6f73-4478-928a-d1ade24268c6
md"""
📝 Toma el logaritmo en base 2 del error hallado utilizando la función `log2`. ¿Qué potencia se obtiene?
"""

# ╔═╡ c53abfbb-dd2f-4464-8e74-f0f8bca20247
md"""
El número que se obtiene, $53$, tiene su origen en cómo se almacenan los números de doble precisión en el ordenador. Para más información sobre esto se puede consultar [Wikipedia](https://es.wikipedia.org/wiki/Formato_en_coma_flotante_de_doble_precisi%C3%B3n).
"""

# ╔═╡ bbf18992-debb-41d0-9b77-849a7314e217
md"""
## Ejercicio 3: Creación de tipos de variable
"""

# ╔═╡ 8a2548f9-1124-415b-a977-61221188973c
md"""
Julia nos permite crear nuestros propios tipos de variable y operar con ellos de la manera en que lo haríamos con los que ya están implementados en el lenguaje. En este ejercicio, vamos a explorar la creación de un tipo de variable y la definición de varias funciones para poder operar con ellos.
"""

# ╔═╡ 40d8080f-2fb0-4599-a704-e1ed4350d6b5
md"""
📝 Crea la estructura `MyComplex` que tendrá dos atributos de tipo `Float64`, que son `real` e `imag`.
"""

# ╔═╡ 95a85541-c12e-4d6d-861b-1bfc9988269a
struct MyComplex
	real::Float64
	imag::Float64
end

# ╔═╡ c9708723-c349-4e39-8e90-1dc092f800b8
md"""
📝 Crea una variable `a` de tipo `MyComplex` con los valores `(2.0, 3.0)`.
"""

# ╔═╡ 0baf4e96-6b52-4113-a9a0-86d144feacbe
a = MyComplex(2.0, 3.0)

# ╔═╡ b7756675-8044-4507-8549-564cd0990e73
md"""
A continuación, vamos a crear una variable `b` de tipo `MyComplex` para operar con `a` tal y como lo harían los números complejos.
"""

# ╔═╡ c5e61a4f-a427-49f5-9817-efb38f5411cf
b = MyComplex(1.0, 4.0)

# ╔═╡ 3ec86e86-aae7-4095-810f-fdad54a2901c
md"""
Para poder sumar estas dos variables de tipo `MyComplex`, hay que definir el método de la suma con el símbolo `+`, que se hace de la siguiente manera
"""

# ╔═╡ 7fda9c99-0f69-49a7-8b6b-8d59c5b75e6a
Base.:+(a::MyComplex, b::MyComplex) = MyComplex(a.real + b.real, a.imag + b.imag)

# ╔═╡ 95523242-3539-46c2-805f-d84044b48cb2
md"""
En las anteriores líneas, hemos extendido la función `+`, que opera con todo tipo de variables ya implementadas en Julia, a nuestros nuevos tipos de variable. De esa manera, si introducimos variables con el tipo nuevo que hemos creado en otras funciones que solo tengan la operación suma, se ejecutarán correctamente.
"""

# ╔═╡ 4c231b46-f9da-4b0f-bc8d-8cfc909df767
md"""
En general, también nos gustaría que las variables `MyComplex` se puedan relacionar con todos los subtipos `Real` que ya están en Julia.
"""

# ╔═╡ c2605300-ca53-4531-b2c5-432ca2ee89e5
md"""
📝 Implementar el método `+` para sumar variables de tipo `MyComplex` a cualquier número `Real`.
"""

# ╔═╡ 615972e7-2f2e-4433-ab8b-608e888f76f4
begin
	Base.:+(a::MyComplex, α::Real) = MyComplex(a.real + α, a.imag)
	Base.:+(α::Real, a::MyComplex) = a + α
end

# ╔═╡ 3335af80-7c3c-4c60-970d-25fd0ebb2ff7
a + b

# ╔═╡ df43a43b-22af-4693-ae51-e5d57c04e7d4
md"""
El tipo de variable `MyComplex` ahora se puede sumar con otros `MyComplex` y cualquier tipo de `Real` de los que tiene Julia. Vamos a extender las funcionalidades de `MyComplex` para incluir la operación de multiplicación `*`.
"""

# ╔═╡ 67724a27-5f66-4227-a4f0-956de808b2d9
md"""
📝 Implementar el método `*` para multiplicar dos números `MyComplex`.
"""

# ╔═╡ f5ea6deb-56f5-40ed-ba2f-baecbdc12881
Base.:*(a::MyComplex, b::MyComplex) = MyComplex(a.real * b.real - a.imag * b.imag,
											   a.imag * b.real + a.real * b.imag)

# ╔═╡ ae6f68ef-ceff-46b1-903f-3d47a2bcec99
md"""
📝 Por último, implementar el método `*` para multiplicar tipos `MyComplex` con `Real`.
"""

# ╔═╡ 637a7b99-b71a-438e-95f1-ab011d194e48
begin
	Base.:*(a::MyComplex, α::Real) = MyComplex(a.real * α, a.imag * α)
	Base.:*(α::Real, a::MyComplex) = a * α
end

# ╔═╡ 95b2bcee-5a99-4916-a60e-b50dbcd1a1ef
lista = filter(k -> k * (1 / k) ≠ 1, 1:10000)

# ╔═╡ 15025d83-6cb8-4f04-9200-eb6542f1395b
floating_error = abs(9992 * (1 / 9992) - 1)

# ╔═╡ 6839fe2e-47e5-4d42-80ef-b6af65388f67
log2(floating_error)

# ╔═╡ 0d63053c-a418-49d3-b8f0-f247f6564a60
md"""
**¡Prueba ahora a realizar algunas operaciones con variables `MyComplex`!**
"""

# ╔═╡ 1582c8e4-992a-4e49-ac1a-45bbf0efa515
begin
	z₁ = MyComplex(1.0, 3.0)
	z₂ = MyComplex(-1.0, 2.0)
	β = 2.75
	λ = 1.45
end;

# ╔═╡ 289abdad-20b5-4721-ac07-01a25bc5528b
z₁ * z₂

# ╔═╡ 6638e32a-f2fd-41a7-9b5d-398b2ed29b31
β * λ * z₂

# ╔═╡ 2c5eacec-cf2b-47aa-bce8-9be60b9ad0c4
z₁ + β * z₂

# ╔═╡ 0797877e-a115-481e-9522-19fd91e001b1
space = html"<br><br><br>";

# ╔═╡ 82282db6-240f-4318-a475-f91229aa6c76
note(text) = Markdown.MD(Markdown.Admonition("note", "Nota", [text]));

# ╔═╡ e74a20f8-e37e-47cc-af35-e687a32efbcc
md"""
El error se calcula como el valor absoluto de la diferencia entre `k * (1 / k)` y `1`.
""" |> note

# ╔═╡ 19c98e87-2114-4362-aa55-4859c20ffc27
hint(text) = Markdown.MD(Markdown.Admonition("hint", "Pista 🔎", [text]));

# ╔═╡ 3305d00d-af3d-4c53-8947-57a07127b137
hint(md"Recuerda que un número primo es aquel que únicamente es divisible por $1$ y por sí mismo")

# ╔═╡ 3f752325-5236-45b9-bd75-775300ae390a
md"""
Intenta realizar este ejercicio sin utilizar un bucle `for`. Se puede emplear:

☝️ La función `filter`.

☝️ Comprehensions pueden tener sentencias `if`, como en `[k for k=1:10000 if 5 < k < 17]`.

(Recuerda que la documentación se puede consultar en todo momento abajo a la derecha en Live docs.)
""" |> hint

# ╔═╡ 5ec47455-fff8-4a4f-80fc-6843c3c2a0fd
md"""
Recuerda que, dados dos números complejos $a + ib$ y $c + id$, su producto viene dado por

$$(a+ib)(c+id) = (ac - bd) + i(ad + bc)$$
""" |> hint

# ╔═╡ 80e9a650-57d9-4e11-acad-aa0f5894ef34
almost(text) = Markdown.MD(Markdown.Admonition("warning", "¡Ya casi lo tienes!", [text]));

# ╔═╡ 7a89b51b-51d7-4090-8a9f-2585363183fc
still_missing(text=md"Sustituye `missing` por tu respuesta.") = Markdown.MD(Markdown.Admonition("warning", "Completa el ejercicio 🧐", [text]));

# ╔═╡ a9cd5b48-921f-4b48-8c63-5060c5d7c1d5
keep_working(text=md"La respuesta todavía no es correcta.") = Markdown.MD(Markdown.Admonition("danger", "¡Sigue intentándolo!", [text]));

# ╔═╡ 20089647-2ac5-405f-b8ba-aa5dd1733271
good = [md"¡Buen trabajo! 🎉", md"¡Correcto! 🎉", md"¡Bien hecho! 👍", md"La respuesta es correcta 🎉", md"Continúa a la siguiente pregunta 👍", md"¡Enhorabuena! 🎉",];

# ╔═╡ 8fd2f719-294a-41cc-bb47-5afbbc2bfa9c
correct(text=rand(good)) = Markdown.MD(Markdown.Admonition("correct", "¡Lo conseguiste!", [text]));

# ╔═╡ 11943935-7bea-44c7-84dc-f736d3c36c3c
let
	c = MyComplex(1.0, 2.0)
	α = 2.5
	
	if ismissing(c + α)
		still_missing(md"Implementa la suma entre `MyComplex` y `Real`")
	elseif ismissing(α + c) 
		keep_working(md"Hay que implementar la suma en el caso de sumar `MyComplex + Real` y viceversa")
	elseif (c + α) ≠ MyComplex(3.5, 2.0)
		keep_working(md"Revisa el método de la suma")
	elseif (α + c) ≠ MyComplex(3.5, 2.0)
		keep_working(md"Revisa el método de la suma")
	else
		correct()
	end
		
end

# ╔═╡ 16865930-4a61-4df0-b1fc-efebde71523f
let
	c = MyComplex(1.0, 2.0)
	d = MyComplex(3.0, 4.0)
	
	if ismissing(c * d)
		still_missing(md"Implementa el método `*`")
	elseif (c * d) ≠ MyComplex(-5.0, 10.0)
		keep_working(md"Revisa la implementación del producto (consulta la Pista)")
	else
		correct()
	end
		
end

# ╔═╡ a4301f7d-bc20-49a0-8535-c83f69c40d4d
let
	c = MyComplex(1.0, 2.0)
	α = 2.0
	
	if ismissing(c * α)
		still_missing(md"Implementa el producto entre `MyComplex` y `Real`")
	elseif ismissing(α * c) 
		keep_working(md"Hay que implementar el producto en el caso de sumar `MyComplex * Real` y viceversa")
	elseif (c * α) ≠ MyComplex(2.0, 4.0)
		keep_working(md"Revisa la implementación del producto")
	elseif (α * c) ≠ MyComplex(2.0, 4.0)
		keep_working(md"Revisa la implementación del producto")
	else
		correct()
	end
		
end

# ╔═╡ 3f6aec31-e108-4caf-bec1-c4ae57b6b72c
not_defined(variable_name) = Markdown.MD(Markdown.Admonition("danger", "¡Cuidado!", [md"Aségurate de haber definido una variable llamada **$(Markdown.Code(string(variable_name)))**"]));

# ╔═╡ f2cf6e9c-47f5-4f88-b7c1-86150d231a1b
let
	if !@isdefined(primo)
		not_defined(:primo)
	else
		if primo isa Missing
			still_missing(md"Sustituye el valor `missing` de la función por tu respuesta")
		elseif primo == true
			correct()
		elseif primo == false
			keep_working()
		end
	end
		
end

# ╔═╡ a55c85dd-7682-47a1-bc20-f245c566cad1
let
	if !@isdefined(error)
		not_defined(:error)
	else
		if error isa Missing
			still_missing(md"Sustituye el valor `missing` de la función por tu respuesta")
		elseif typeof(error) <: Function
			correct()
		else
			keep_working()
		end
	end
		
end

# ╔═╡ 03092e4e-f191-4899-9a06-14101495eaa5
let
	if !@isdefined(lista)
		not_defined(lista)
	else
		if lista isa Missing
			still_missing()
		elseif length(lista) ≠ 1178
			keep_working(md"La longitud de la lista no es la correcta")
		elseif lista[5] == 161 && lista[end] == 9992
			correct()
		else
			keep_working()
		end
	end
		
end

# ╔═╡ 21395849-7cdf-4836-ad79-804341c41a6a
let
	if !@isdefined(a)
		not_defined("a")
	else
		if a isa Missing
			still_missing()
		elseif !(a isa MyComplex)
			keep_working(md"`a` debería ser una variable de tipo `MyComplex`.")
		elseif (a.real == 2.0 && a.imag == 3.0) 
			correct()
		else
			almost(md"Aségurate de que la parte real sea `2.0` y la imaginaria `3.0`")
		end
	end
end

# ╔═╡ 5ec67974-c7dc-43d6-a0ef-b804ab1bf64b
todo(text) = HTML("""<div
	style="background: rgb(220, 200, 255); padding: 2em; border-radius: 1em;"
	><h2>TODO</h2>$(repr(MIME"text/html"(), text))</div>""");

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7.39"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.2"
manifest_format = "2.0"
project_hash = "6ff2529dffd0652d0349be095d4d180abf958f56"

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

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "0.5.2+0"

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
# ╟─e6320cf8-9301-11ec-3f30-93a359f008f5
# ╠═c4a419ab-64d2-486c-a001-50a200d17f45
# ╟─7e714c42-fca6-4298-8e8e-8ed26d549617
# ╟─6c741cbd-e728-41fb-8519-8e652567c048
# ╟─94773345-69a2-4c73-ad9c-0649176699e9
# ╟─589ec36c-672c-4f61-af1c-9502ace05074
# ╠═a53f7ba6-db95-451a-b34e-33d08d8843c8
# ╟─8d734d93-e6ee-4a3b-8e48-eaf402997bce
# ╟─b7c8437a-c2bb-4d5d-bb33-02f958253ce8
# ╟─8787e409-299c-45c2-aec5-15921116850c
# ╠═c5ab0653-1996-48a9-ae44-467f94fd07fa
# ╟─3305d00d-af3d-4c53-8947-57a07127b137
# ╠═f133d62e-819a-4a6a-8fb8-3e70ed9dc5ad
# ╟─f2cf6e9c-47f5-4f88-b7c1-86150d231a1b
# ╟─1040cfca-6e6d-491a-878e-d65356286ac9
# ╟─1b2b42ed-5497-4ba1-8671-aa15cd0a91b3
# ╠═40c0cb49-296e-428f-94cd-e78447f5b19b
# ╠═2c454d25-1892-454e-a55e-a4faddeaeb4e
# ╟─a55c85dd-7682-47a1-bc20-f245c566cad1
# ╟─6ca766ff-e0ca-46a0-b787-7f7b38d36f2f
# ╟─9946abb5-b504-46b7-a19d-8320f60215af
# ╟─cdb3d006-c4d1-4e10-9c59-28b7e89eb263
# ╟─d8447d04-17a6-438e-810a-065c6198071b
# ╠═95b2bcee-5a99-4916-a60e-b50dbcd1a1ef
# ╟─3f752325-5236-45b9-bd75-775300ae390a
# ╟─03092e4e-f191-4899-9a06-14101495eaa5
# ╟─7d04eec0-f8ac-46d7-b5fb-f13b324a72bb
# ╟─ae751e41-2009-4d3f-9a8e-101e322d92c1
# ╟─e74a20f8-e37e-47cc-af35-e687a32efbcc
# ╠═15025d83-6cb8-4f04-9200-eb6542f1395b
# ╟─ecc5827c-6f73-4478-928a-d1ade24268c6
# ╠═6839fe2e-47e5-4d42-80ef-b6af65388f67
# ╟─c53abfbb-dd2f-4464-8e74-f0f8bca20247
# ╟─bbf18992-debb-41d0-9b77-849a7314e217
# ╟─8a2548f9-1124-415b-a977-61221188973c
# ╟─40d8080f-2fb0-4599-a704-e1ed4350d6b5
# ╠═95a85541-c12e-4d6d-861b-1bfc9988269a
# ╟─c9708723-c349-4e39-8e90-1dc092f800b8
# ╠═0baf4e96-6b52-4113-a9a0-86d144feacbe
# ╟─21395849-7cdf-4836-ad79-804341c41a6a
# ╟─b7756675-8044-4507-8549-564cd0990e73
# ╠═c5e61a4f-a427-49f5-9817-efb38f5411cf
# ╟─3ec86e86-aae7-4095-810f-fdad54a2901c
# ╠═7fda9c99-0f69-49a7-8b6b-8d59c5b75e6a
# ╠═3335af80-7c3c-4c60-970d-25fd0ebb2ff7
# ╟─95523242-3539-46c2-805f-d84044b48cb2
# ╟─4c231b46-f9da-4b0f-bc8d-8cfc909df767
# ╟─c2605300-ca53-4531-b2c5-432ca2ee89e5
# ╠═615972e7-2f2e-4433-ab8b-608e888f76f4
# ╟─11943935-7bea-44c7-84dc-f736d3c36c3c
# ╟─df43a43b-22af-4693-ae51-e5d57c04e7d4
# ╟─67724a27-5f66-4227-a4f0-956de808b2d9
# ╠═f5ea6deb-56f5-40ed-ba2f-baecbdc12881
# ╟─5ec47455-fff8-4a4f-80fc-6843c3c2a0fd
# ╟─16865930-4a61-4df0-b1fc-efebde71523f
# ╟─ae6f68ef-ceff-46b1-903f-3d47a2bcec99
# ╠═637a7b99-b71a-438e-95f1-ab011d194e48
# ╟─a4301f7d-bc20-49a0-8535-c83f69c40d4d
# ╟─0d63053c-a418-49d3-b8f0-f247f6564a60
# ╠═1582c8e4-992a-4e49-ac1a-45bbf0efa515
# ╠═289abdad-20b5-4721-ac07-01a25bc5528b
# ╠═6638e32a-f2fd-41a7-9b5d-398b2ed29b31
# ╠═2c5eacec-cf2b-47aa-bce8-9be60b9ad0c4
# ╟─0797877e-a115-481e-9522-19fd91e001b1
# ╟─82282db6-240f-4318-a475-f91229aa6c76
# ╟─19c98e87-2114-4362-aa55-4859c20ffc27
# ╟─80e9a650-57d9-4e11-acad-aa0f5894ef34
# ╟─7a89b51b-51d7-4090-8a9f-2585363183fc
# ╟─a9cd5b48-921f-4b48-8c63-5060c5d7c1d5
# ╟─20089647-2ac5-405f-b8ba-aa5dd1733271
# ╟─8fd2f719-294a-41cc-bb47-5afbbc2bfa9c
# ╟─3f6aec31-e108-4caf-bec1-c4ae57b6b72c
# ╟─5ec67974-c7dc-43d6-a0ef-b804ab1bf64b
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
