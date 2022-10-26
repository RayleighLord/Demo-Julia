### A Pluto.jl notebook ###
# v0.19.9

#> [frontmatter]
#> title = "Julia Numerical Integration"
#> date = "2022-10-23"
#> tags = ["Julia", "Programming", "Numerical"]
#> description = "Julia Numerical Integration Showcase"

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 719af058-3505-4ede-be04-557a448d8ade
html"""
<div class="banner-background">
</div>

<div class="nb-intro">
	<div class="header-box">
		<p class="nb-intro-header"> Integración Numérica </p>
		<p class="nb-intro-title"> Integración en Julia</p>
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

input[type=range] {
  width: 60%;
}

</style>
"""

# ╔═╡ 58fdf9e2-8dc6-43e2-9798-8e992dac2053
begin
	using PlutoUI, UnPack
	PlutoUI.TableOfContents(title="Tabla de Contenidos", depth=3, aside=true, indent=true)
end

# ╔═╡ 34126511-785d-4ffc-9347-f8f68304475e
dx = Domain1D(a = 0.0, b = 1.0, n = 10^5);

# ╔═╡ 1dee686f-0e8a-4388-adcc-90d4a97c834c
md"""
# Integración Numérica en Julia
"""

# ╔═╡ d76248f3-4ef3-49b9-b1ee-dcbb2220b5fa
md"""
## 1. Sintáxis muy próxima a las matemáticas
"""

# ╔═╡ 95d7758d-642d-47c4-886a-67c6b0a34195
md"""
El cálculo de integrales de manera numérica es una operación necesaria en muchas ramas científicas. Prácticamente cualquier lenguaje de programación implementa en el propio lenguaje o en alguna librería externa esta funcionalidad.

En general, si uno quiere aproximar una integral por medio de sumas de Riemann, la sintáxis en la mayoría de los lenguajes de programación será llamar a una función del estilo

`riemann_sum(f, a, b, n)`,

donde `f` es la función a integrar, `a` el límite inferior de integración, `b` el límite superior y `n` el número de subintervalos en que dividimos el intervalo $[a, b]$. El resultado de esta función será una aproximación al valor real de la integral verdadera, suponiendo que la `f` es integrable según Riemann.
"""

# ╔═╡ bc9f64fb-fbe8-4f31-93a9-4ddfb4ce86bf
md"""
Imaginemos que queremos integrar la función $f(x) = x^3$ en el intervalo $[0, 1]$, cuyo resultado exacto es $0.25$. Esta función en Julia se puede definir como
"""

# ╔═╡ 035a9452-0790-4605-bfec-caed7e32196d
f(x) = x^3

# ╔═╡ 6693d002-4780-4643-8427-9684f00c6203
md"""
De manera matemática, la integral que queremos hacer se expresa como

$$\int_0^1 f(x) \mathrm{d}x.$$

¿Se puede conseguir una notación parecida en el código de un ordenador? En otros lenguajes esto es ciertamente imposible, pero en Julia el siguiente código
"""

# ╔═╡ d189e6a8-a163-4891-8763-9127b9c41953
∫(f) * dx

# ╔═╡ ac25f910-abed-4ee4-ad1d-4f0814ce232c
md"""
aporta el resultado esperado, que es muy próximo a 0.25. Es decir, la sintáxis `∫(f) * dx`, idéntica a la matemática, realiza numéricamente el cálculo de la integral para la función `f` definida anteriormente. Esto supone que, en la realización de cuestiones de cálculo numérico en Julia, la sintáxis del lenguaje y sus características nos permiten programarlo todo de tal manera que las diferencias respecto al problema matemático planteado en el papel sean mínimas.

Veamos cómo lograrlo.
"""

# ╔═╡ 4b93ec96-c68e-4e2f-b032-ee9bd4d168d3
md"""
## 2. ¿Cómo conseguimos que `∫(f) * dx` sea capaz de realizar una integral?
"""

# ╔═╡ e4700f04-ba07-45b8-97c3-c660700e01ad
md"""
Una integral es una operación en la que necesitamos conocer una función y el dominio de integración. Por lo tanto, vamos a definir las estructuras necesarias en Julia para trabajar con ambas y luego poder integrarlas en una sintáxis próxima a las matemáticas.
"""

# ╔═╡ 8119d19c-07a9-436a-8218-f921f754444e
md"""
### 2.1. Definiendo el dominio
"""

# ╔═╡ b488e5e8-0081-4d26-a3e7-c992335ab117
md"""
En un problema unidimensional, la integración tiene lugar en un cierto intervalo $[a, b]$, en general. Por lo tanto, podemos crear una estructura de datos llamada `Domain1D` que almacene ambos extremos de integración. Por otro lado, para el cálculo de la aproximación numérica, también es interesante que esta estructura contenga el número de subintervalos en el que queremos dividir el intervalo de integración. A este número lo vamos a llamar $n$.

Esta estructura la vamos a definir en la siguiente celda
"""

# ╔═╡ 9ee73c40-31d9-45c9-9e25-c17bb560e204
begin

	struct Domain1D
		a
		b
		n
		Δx
	end

	Domain1D(a, b, n) = Domain1D(a, b, n, (b - a) / n)
	Domain1D(; a, b, n) = Domain1D(a, b, n)

end

# ╔═╡ cda08f10-a27f-4237-a3c0-333025211765
md"""
El valor de `Δx` se deja precalculado para luego aplicar el algoritmo de la suma de Riemann. Las última definición en la celda anterior de `Domain1D` se realiza para que se puedan asignar los valores por nombre, es decir, como `Domain1D(a = 0.0, b = 1.0, n = 10^3)`.

Con esto ya tenemos todo lo que necesitamos saber del dominio para hacer la integral, ahora vamos a ver la estructura que albergará la función.
"""

# ╔═╡ 40ad33ad-bc2d-4bcf-9d4b-097d504d771a
md"""
### 2.2. Preparando la estructura del integrador
"""

# ╔═╡ 700c1469-bb2a-478e-b323-78e1eb4808a5
md"""
Para luego poder aplicar el símbolo ∫ a una función y realizar la integral, necesitamos crear otra estructura, que vamos a llamar `Integrator`, que únicamente va a albergar la función `f` que queramos integrar. Esto se hace de la siguiente manera
"""

# ╔═╡ c5e48f8d-afe7-40f4-9f93-af769648ada9
begin

	struct Integrator
		f
	end

	(I::Integrator)(f) = I.f = f

end

# ╔═╡ d23eab52-0fd2-489d-8d6c-4cc7b75679b4
md"""
Así, podemos almacenar una función en integrator de la siguiente manera
"""

# ╔═╡ d9fba7b4-51ca-414a-94dd-94bd0c0552e3
let
	g(x) = x^2
	int_g = Integrator(g)
	int_g.f(5) # Debería salir g(5) = 25
end

# ╔═╡ aaf6bba2-4bb9-46c6-930b-dea77c97dff0
md"""
Ahora, para conseguir la sintáxis deseada, vamos a asignarle al símbolo `∫` la estructura `Integrator`
"""

# ╔═╡ 3b618781-8ec6-4150-965a-06e5d26b0a14
const ∫ = Integrator

# ╔═╡ 5813852b-d9ec-48ff-b4ed-c2274a36e0c4
md"""
Por último, queda definir la interacción entre nuestro `Integrator` y `Domain1D`, lo cual se va a hacer extendiendo la funcionalidad del operador `*`.
"""

# ╔═╡ d48fea73-d16e-4535-86ed-0c2afe76b4ff
md"""
### 2.3. Implementación del método numérico
"""

# ╔═╡ a363504e-9c2b-497b-b954-98000d75ead2
md"""
La aproximación de la integral por sumas de Riemann, suponiendo intervalos de la misma longitud y de tamaño $\Delta x$, se obtiene como

$$\int_a^bf(x) \mathrm{d}x \approx \sum_{i = 0}^{n - 1}f(a + i * \Delta x) \Delta x.$$
"""

# ╔═╡ 2888abe6-27fd-44fc-afe4-0e6894a333c1
md"""
En este cuaderno ya hemos definido todos los elementos necesarios para hacer esta aproximación. Para el cálculo, vamos a extender el operador `*` con un método nuevo. En Julia, este operador se usa para todo tipo de multiplicaciones entre distintos tipos de variables. Lo que vamos a hacer ahora es enseñarle a operar cuando esas variables son un `Integrator` y un `Domain1D`. Esto es posible gracias a un paradigma central de Julia conocido como _**multiple dispatch**_.

En la próxima celda, definimos la función `Base.:*` cuando tiene los argumentos de entrada mencionados anteriormente. Es necesario hacer referencia a Base ya que queremos extender el método del lenguaje base de Julia. Dentro de la definición de esta función, realizamos el cálculo de la suma de Riemann y devolvemos el resultado.
"""

# ╔═╡ 0ab47efc-d953-481e-8a80-2d3f8bf82ed4
function Base.:*(I::Integrator, dx::Domain1D)
	f = I.f
	@unpack a, n, Δx = dx

	xs = a .+ (0:n-1) * Δx
	return sum(f.(xs)) * Δx
end

# ╔═╡ 0ab924e1-4836-4abc-82d0-4d5310cf66c2
md"""
¡Y con esto ya hemos acabado! Podemos integrar cualquier función en un intervalo arbitrario. Por ejemplo, programemos la integración de la función $h(x) = x + x^2 $ en el intervalo $[0, 2]$.
"""

# ╔═╡ 17cbbf12-f60d-4c26-8f0c-1ca990615a15
let
	dx = Domain1D(a = 0.0, b = 2.0, n = N)
	h(x) = x + 3x^2
	valor = ∫(h) * dx
	md"``\int_0^2 h(x) \mathrm{d}x =`` $(valor)" # Para imprimir bonito
end

# ╔═╡ 483bbbd3-fcb4-4a98-8e17-cd67f42895b8
md"""
``N = `` $(@bind N Slider(20:200:10^4; default=20, show_value = true))
"""

# ╔═╡ ffaecfaf-c365-4ea9-908f-9e0ea1f2363a
md"""
Juega a aumentar $N$, el número de subintervalos, y ver cómo el resultado se aproxima cada vez más al exacto!
"""

# ╔═╡ f9f65195-3f5a-4600-9611-40690ea9f094
md"""
## 3. ¡Define tu propias integrales!
"""

# ╔═╡ 822cfa58-e007-4dc5-82c4-950caf0215ad
md"""
En la siguiente casilla, cambiando la definición de `f(x)` y el dominio prueba a integrar cualquier función que se te ocurra
"""

# ╔═╡ 23066570-0126-43b5-8865-a9612e3ca211
let
	a, b = -1.5, 2.0
	dx = Domain1D(a = a, b = b, n = 10^5)
	f(x) = cosh(x) + x^2 - 2
	valor = ∫(f) * dx
	md"``\int f(x) \mathrm{d}x =`` $(valor)"
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
UnPack = "3a884ed6-31ef-47d7-9d2a-63182c4928ed"

[compat]
PlutoUI = "~0.7.39"
UnPack = "~1.0.2"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.2"
manifest_format = "2.0"
project_hash = "7dcc1906903fe59e048893dfdc9cd28fb0dfc5cc"

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

[[deps.UnPack]]
git-tree-sha1 = "387c1f73762231e86e0c9c5443ce3b4a0a9a0c2b"
uuid = "3a884ed6-31ef-47d7-9d2a-63182c4928ed"
version = "1.0.2"

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
# ╟─f5450eab-0f9f-4b7f-9b80-992d3c553ba9
# ╟─719af058-3505-4ede-be04-557a448d8ade
# ╠═58fdf9e2-8dc6-43e2-9798-8e992dac2053
# ╟─34126511-785d-4ffc-9347-f8f68304475e
# ╟─1dee686f-0e8a-4388-adcc-90d4a97c834c
# ╟─d76248f3-4ef3-49b9-b1ee-dcbb2220b5fa
# ╟─95d7758d-642d-47c4-886a-67c6b0a34195
# ╟─bc9f64fb-fbe8-4f31-93a9-4ddfb4ce86bf
# ╠═035a9452-0790-4605-bfec-caed7e32196d
# ╟─6693d002-4780-4643-8427-9684f00c6203
# ╠═d189e6a8-a163-4891-8763-9127b9c41953
# ╟─ac25f910-abed-4ee4-ad1d-4f0814ce232c
# ╟─4b93ec96-c68e-4e2f-b032-ee9bd4d168d3
# ╟─e4700f04-ba07-45b8-97c3-c660700e01ad
# ╟─8119d19c-07a9-436a-8218-f921f754444e
# ╟─b488e5e8-0081-4d26-a3e7-c992335ab117
# ╠═9ee73c40-31d9-45c9-9e25-c17bb560e204
# ╟─cda08f10-a27f-4237-a3c0-333025211765
# ╟─40ad33ad-bc2d-4bcf-9d4b-097d504d771a
# ╟─700c1469-bb2a-478e-b323-78e1eb4808a5
# ╠═c5e48f8d-afe7-40f4-9f93-af769648ada9
# ╟─d23eab52-0fd2-489d-8d6c-4cc7b75679b4
# ╠═d9fba7b4-51ca-414a-94dd-94bd0c0552e3
# ╟─aaf6bba2-4bb9-46c6-930b-dea77c97dff0
# ╠═3b618781-8ec6-4150-965a-06e5d26b0a14
# ╟─5813852b-d9ec-48ff-b4ed-c2274a36e0c4
# ╟─d48fea73-d16e-4535-86ed-0c2afe76b4ff
# ╟─a363504e-9c2b-497b-b954-98000d75ead2
# ╟─2888abe6-27fd-44fc-afe4-0e6894a333c1
# ╠═0ab47efc-d953-481e-8a80-2d3f8bf82ed4
# ╟─0ab924e1-4836-4abc-82d0-4d5310cf66c2
# ╠═17cbbf12-f60d-4c26-8f0c-1ca990615a15
# ╟─483bbbd3-fcb4-4a98-8e17-cd67f42895b8
# ╟─ffaecfaf-c365-4ea9-908f-9e0ea1f2363a
# ╟─f9f65195-3f5a-4600-9611-40690ea9f094
# ╟─822cfa58-e007-4dc5-82c4-950caf0215ad
# ╠═23066570-0126-43b5-8865-a9612e3ca211
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
