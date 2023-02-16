### A Pluto.jl notebook ###
# v0.19.9

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
		<p class="nb-intro-header"> Derivación numérica </p>
		<p class="nb-intro-title"> Diferenciación automática </p>
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

main {
	max-width: 900px
}

</style>
"""

# ╔═╡ 58fdf9e2-8dc6-43e2-9798-8e992dac2053
begin
    using PlutoUI
    PlutoUI.TableOfContents(title="Tabla de Contenidos", depth=3, aside=true, indent=true)
end

# ╔═╡ 27d55bc5-af2f-40e5-b633-79dc53f30c27
md"""
# Diferenciación Automática
"""

# ╔═╡ 53c85181-c111-4441-bd50-8fa029c90a99
md"""
## 1. ¿Qué problema hay con las diferencias finitas?
"""

# ╔═╡ 758a6077-f323-490d-80a7-d71b12f6f445
md"""
Cuando uno está analizando un problema físico, es muy frecuente que necesite realizar el cálculo de alguna derivada. Típicamente, la manera de realizar este proceso es a través de **diferencias finitas**, pero este método conlleva una pérdida inherente de precisión que puede ser crítica en algunos casos.

Por ejemplo, si queremos calcular la derivada de una función, la podemos aproximar por

$$f'(x) \approx \frac{f(x + h) - f(x)}{h},$$

para $h$ suficientemente pequeña. La cuestión es, ¿cómo de pequeña? Supongamos que hay una $h$ óptima a la que denotaremos como $h_{\text{opt}}$. Pues bien, para valores más grandes de $h$ que el óptimo, podemos esperar tener un error debido a la aproximación que estamos realizando, ya que la derivada es el límite cuando $h$ tiende a 0 (este error se conoce como _**error de truncación**_). Por otro lado, para valores de $h$ más pequeños que el óptimo, incurrimos en un error que podría no ser evidente en un primer análisis. Cuando $h$ es muy pequeño, por ejemplo, $h = 10^{-8}$, podemos esperar que los valores de $f(x+h)$ y $f(x)$ sean prácticamente iguales en las 8 primeras cifras. Esto quiere decir que, una vez se realice la diferencia $f(x+h) - f(x)$, nos quedaran solo 8 cifras significativas, suponiendo que trabajamos en doble precisión (donde el ordenador solo puede acarrear 16 cifras significativas). Después, dividir entre $h=10^{-8}$ solo va a desplazar las 8 cifras significativas a la izquierda y deja un rastro de ceros detrás. Esta pérdida de precisión se conoce como _**error de redondeo**_. El valor óptimo $h_{\text{opt}}$ es aquel en el que los errores de truncación y redondeo tienen valores similares.

Cabe destacar que hay métodos de diferencias finitas de mayor orden, pero todos acaban estando sujetos al balance entre el error de truncación y redondeo, lo que conlleva una pérdida de precisión.

Sin embargo, con el creciente interés en el área de *machine learning*, una nueva aproximación al cálculo de derivadas en ordenador, llamada **diferenciación automática**, está sobrepasando a todos los métodos establecidos pues reduce el coste de calcular la derivada a la una evaluación de la función sin pérdida de precisión debida a tener que calcular alguna diferencia de números muy parecidos (que es una operación muy mal condicionada numéricamente).

"""

# ╔═╡ abf319e2-af6c-4863-b985-47e8e2a312e6
md"""
## 2. ¿Por qué diferenciación automática?
"""

# ╔═╡ 1ee1a5b3-4e31-431f-95a2-d8c480b9336c
md"""
En esta sección vamos a implementar el método de diferenciación automática en unas pocas líneas de código para ilustrar su funcionamiento.

Este método tiene dos ventajas respecto a diferencias finitas. Es, en general, más *rápido* (necesita de menos operaciones) y más *preciso* (el error es del mismo orden que el que se obtiene de evaluar una función en un punto en un ordenador). Antes de comenzar con la explicación, también hay que destacar un método interesante que permite el cálculo de una derivada numérica para una función analítica sin tener que calcular ninguna diferencia. Este método se conoce como [Complex Step Differentiation](https://blogs.mathworks.com/cleve/2013/10/14/complex-step-differentiation/) y la idea es extender la función al plano complejo y calcular la derivada por una dirección paralela al eje imaginario.

La idea de la diferenciación automática se basa en la introducción de un nuevo tipo de número, conocido como los [**números duales**](https://en.wikipedia.org/wiki/Dual_number). El álgebra de estos números es completamente análoga a la de los números complejos, con la diferencia en que si en los números complejos se introduce el símbolo $i$ con la propiedad $i^2=-1$, en los números duales se introduce el símbolo $\epsilon$ con la propiedad $\epsilon^2 = 0$.

Por lo tanto, los números duales son todos los pares ordenados de números reales, que podemos denotar como $(a, b) \equiv a + b\epsilon$ en el que la operación suma y producto cumplen las propiedades

$$(a + b\epsilon) + (c + d\epsilon) = (a + c) + \epsilon(b + d),$$
$$(a + b\epsilon) ⋅ (c + d\epsilon) = ac + \epsilon(ad - bd).$$

Entonces, ¿por qué son interesantes los números duales? Imagina la función $f(x) = x^2$ y vamos a evaluarla en el número dual $c + \epsilon$. Esto aporta

$$f(c+\epsilon) = (c + \epsilon)^2 = c^2 + 2c\epsilon + \epsilon^2 = c^2 + 2c\epsilon \equiv (c^2, 2c).$$

Es decir, que evaluando la función en $c + \epsilon$, obtenemos el par ordenado donde la primera entrada es el valor de la función en el punto $x = c$ y la segunda entrada es el valor de la derivada de la función en el mismo punto $f'(c) = 2c$. En conclusión, si queremos conocer la derivada de cualquier función analítica en un punto $c$, basta con evaluarla en $c + \epsilon$.

La idea matemática no es muy complicada, y cuadra con nuestra noción de $\epsilon$ como un número muy pequeño para luego solo retener el término lineal del desarrollo en serie de Taylor de la función. Por ello, la implementación de la diferenciación automática acaba siendo más una cuestión de programación que matemática.

En Julia, la implementación de estos números se puede hacer en muy pocas líneas de código y, aunque ya hay paquetes con números duales, vamos a programarlos aquí para entender completamente la idea.
"""

# ╔═╡ b5395e77-ef52-4cd3-bd55-6c3b665e3251
md"""
## 3. Implementando los números duales y su álgebra
"""

# ╔═╡ 0a4122b2-4a7c-43ef-b87d-cc6bfe662154
md"""
Lo primero que vamos a hacer va a ser definir un nuevo tipo llamado **Dual**, que va a albergar los dos elementos del par ordenado llamados *val* y *der*.
"""

# ╔═╡ f70178ed-8b32-49e9-953a-a68f44c48c0a
begin
    struct Dual{T<:Real}
        val::T
        der::T
    end

    Dual(x, y) = Dual(promote(x, y)...)
    Dual(x) = Dual(x, zero(x))
end

# ╔═╡ 8b7f8281-a7ef-4a62-b647-28270ff224a0
md"""
Las dos últimas líneas de la celda anterior simplemente se asegura que las dos entradas del número dual sean del mismo tipo (Float, Integer, ...) y nos permiten crear un número dual donde no nos interese el cálculo de la derivada.

A continuación, vamos a definir cómo se imprimen por pantalla los números duales
"""

# ╔═╡ db850874-4504-4a3a-b41b-1c18dc7da0ae
Base.show(io::IO, x::Dual) = print(io, x.val, " + ", x.der, " ϵ")

# ╔═╡ 2a9489ab-2d65-4d0d-8c71-2d79c094c24d
md"""
Por lo tanto, ya podemos crear un número dual y ver cómo queda expresado, lo cual se hace en la siguiente celda
"""

# ╔═╡ 7d9d590d-6347-42e1-95a6-b8d76ece0351
z = Dual(2, 3.0)

# ╔═╡ 8138e9a2-eb5f-4787-b82d-7d7f6a5a6cb7
md"""
Por último, para facilitar la creación de número duales de una manera más natural utilizando $\epsilon$, vamos a definir este símbolo como el número dual $(0, 1)$
"""

# ╔═╡ 4c46a8f0-1785-45c9-80ce-fd3447c07cf7
const ϵ = Dual(0, 1);

# ╔═╡ 19bbe5e5-8beb-4bf2-9ce3-b84727ee4121
md"""
Lo cual ya nos permite generar números duales con la notación
"""

# ╔═╡ fdef22c6-036b-4d17-8411-4e41196374f0
1 + 3ϵ

# ╔═╡ be186ab3-7d8b-4287-9550-1d51298130df
md"""
### 3.1. Suma y resta de números duales
"""

# ╔═╡ 7114cd1d-f778-4df9-a7a4-eb2db0541a5b
md"""
En esta sección, definimos en Julia la operación suma de los números duales. Para ello, vamos a _**extender**_ la funcionalidad del operador + que ya implementa Julia en la base de su lenguaje para que sepa operar con el nuevo tipo de variable que hemos definido.

Para ello, enseñamos al operador cómo sumar dos números duales y luego cómo sumar un número dual con cualquier otro tipo de número de los que Julia ya por defecto.
"""

# ╔═╡ af0d8f53-0d91-420b-a383-68eb37d37867
begin
    Base.:+(x::Dual, y::Dual) = Dual(x.val + y.val, x.der + y.der)
    Base.:+(x::Dual, a::Number) = Dual(x.val + a, x.der)
    Base.:+(a::Number, x::Dual) = x + a
end

# ╔═╡ 061f0e4d-391e-4f7a-a46d-02df226833e3
md"""
Ahora, ya podemos realizar operaciones que involucren la suma de estos números, como por ejemplo
"""

# ╔═╡ 268b9d66-162b-4ab2-845f-4a3b04aaf047
(2 + 5ϵ) + (3 + 7ϵ)

# ╔═╡ 84202dd1-1f54-49a1-b1c5-2ea55d74907b
18.4 + (1 + 2.5ϵ)

# ╔═╡ f60ba72f-bde7-4cdd-a408-54995e9b13a8
md"""
Del mismo modo, definimos la resta de los números duales y el elemento inverso de la suma de un número dual
"""

# ╔═╡ 9dc6e59f-3eca-47e6-8d9b-f76c14ec519a
Base.:-(x::Dual, y::Dual) = Dual(x.val - y.val, x.der - y.der)

# ╔═╡ 1db9b9b9-7fc4-440b-b35c-ecf1dfa93d16
Base.:-(x::Dual) = Dual(-x.val, -x.der)

# ╔═╡ 1b5b997d-2604-439d-8cc1-49fd22139615
md"""
Y operando con ellos
"""

# ╔═╡ f02e0e75-cf78-4daa-96a5-35c70dd08abc
(2 + 3ϵ) - (5 + 3ϵ)

# ╔═╡ 1d1d8926-c81e-4e0f-a9f2-a97dae7ca394
-(3 + 4ϵ)

# ╔═╡ f78814fc-a747-487b-97f0-1be987f04f85
md"""
### 3.2. Multiplicación y división de números duales
"""

# ╔═╡ bc8e9223-8143-4f97-8663-0929e89c4725
md"""
De manera análoga al apartado anterior, ahora extendemos la funcionalidad del operador `*` para que sepa tratar con números duales. (Notar que la parte de la derivada del producto de números duales es exactamente la regla del producto para la derivación funciones)
"""

# ╔═╡ 455f0f48-a95f-482e-84f1-393a3c6abd3f
begin
    Base.:*(x::Dual, y::Dual) = Dual(x.val * y.val, x.der * y.val + y.der * x.val)
    Base.:*(x::Dual, a::Number) = Dual(x.val * a, x.der * a)
    Base.:*(a::Number, x::Dual) = x * a
end

# ╔═╡ b633a32f-9b41-44be-ada1-ef091506b110
md"""
Con esta operación ya podemos calcular la derivada por diferenciación automática de cualquier función que solo involucre operaciones de + y `*`. Por ejemplo, para la siguiente función
"""

# ╔═╡ f930f7cb-44aa-4d48-a148-f7c77092fcab
f₁(x) = (2 + x) * x

# ╔═╡ f52b0585-8a8d-43bd-8e42-1b979c1862a4
md"""
si queremos su derivada en $x = 2$, simplemente la evaluamos en el número dual $2 + ϵ$ y obtenemos
"""

# ╔═╡ 32c5607b-5c5a-474d-8ec1-c41493465047
f₁(2 + ϵ)

# ╔═╡ 609c82e3-642a-401d-9d25-e355c15205e9
md"""
donde la diferenciación automática nos dice $f_1(2) = 8 $ y $f_1'(2) = 6$. Esto lo podemos comprobar calculando la derivada real
"""

# ╔═╡ 609bcf69-1d11-4037-a610-df48ea6309ea
f₁′(x) = 2(1 + x)

# ╔═╡ 4c4deff7-38ce-469b-b16d-6eef97709d9f
f₁(2)

# ╔═╡ bd63cc6b-a3be-448c-abe6-5dc1351e1381
f₁′(2)

# ╔═╡ 5f0e09f2-b5b6-4393-9cb8-629db1561d70
md"""
Hay que darse cuenta de que en ningún momento nosotros hemos dado ninguna información acerca de la derivada de la función $f_1'(x)$ para hallar su valor con diferenciación automática. Simplemente, definiendo el álgebra de los números duales necesaria, hemos obtenido el valor exacto tras una única evaluación de la función. Si hubiéramos empleado diferencias finitas, hubieramos obtenido
"""

# ╔═╡ f198f716-2020-4af0-9d64-c4aeebf47270
let
    h = 1e-8
    (f₁(2 + h) - f₁(2)) / h
end

# ╔═╡ 6468765a-9107-4c34-b71c-74c91e5d0fac
md"""
A continuación, definimos el operador `/` para enseñar a dividir números duales y, de la misma manera que para el producto, ahora en la derivada entre dos números duales aparece la regla del cociente.
"""

# ╔═╡ 4ef88a55-3ecb-41ec-8885-285978558f7c
begin
    Base.:/(x::Dual, y::Dual) = Dual(x.val / y.val, (x.der * y.val - x.val * y.der) / (y.val^2))
    Base.:/(x::Dual, a::Number) = Dual(x.val / a, x.der / a)
    Base.:/(a::Number, x::Dual) = a / x.val * Dual(1, -x.der / x.val)
end

# ╔═╡ 2b658ad9-3919-473f-bda9-0ad0baac5df7
md"""
Finalmente, definimos la potenciación a un entero $n$ como la aplicación sucesiva del operador `*` $n$ veces a través de la siguiente línea de código
"""

# ╔═╡ 244a9c9a-0658-463e-9df4-a060f17c0959
Base.:^(x::Dual, n::Integer) = Base.power_by_squaring(x, n)

# ╔═╡ 1d5ad669-39d7-49a0-b4b8-d296fe174033
md"""
Por lo tanto, ahora ya podemos considerar funciones más interesantes como
"""

# ╔═╡ 931fce01-dea4-4d26-af98-225423423d8d
f₂(x) = x^3 / (2x + 2)

# ╔═╡ 9e8323a4-dd6f-4309-84b7-d7d1117d6e45
f₂′(x) = 3x^2 / (2x + 2) - 2x^3 / (2x + 2)^2

# ╔═╡ 0436ee2e-8e15-41b1-82c3-4311d18ee12f
md"""
y comparar su derivada exacta con la obtenida por diferenciación automática en cualquier punto del dominio utilizando el siguiente slider
"""

# ╔═╡ 9b3e7015-a3bb-4057-aeb7-40d9266414ef
md"""
  ``x_0 =`` $(@bind x₀ Slider(-20:20, default = -3, show_value = true))
"""

# ╔═╡ 0dca92e9-f3e9-4c5a-bf18-fa00628b25b3
f₂(x₀ + ϵ)

# ╔═╡ de63c63f-20e5-4e7d-bdf7-22adb8eafa87
f₂′(x₀)

# ╔═╡ 2d6e5a61-786b-4156-bec6-c035c47e8093
md"""
### 3.3. Operando con composiciones de funciones elementales
"""

# ╔═╡ 9555254d-9a00-4761-8e77-9d6ec284c85d
md"""
Antes de continuar, vamos a reflexionar sobre lo que hemos hecho para calcular derivadas por diferenciación automática en Julia.

En primer lugar, definimos un tipo de variable llamado Dual, y seguidamente le enseñamos al lenguaje a cómo operar con estos números duales. Este tipo de operaciones que hemos implementado no son nada especiales, y la manera de definirlas es, de hecho, completamente análoga a como los desarrolladores del lenguaje [implementaron el álgebra de números complejos](https://github.com/JuliaLang/julia/blob/master/base/complex.jl).

Esta manera de programarlo, que no es posible realizarla exactamente igual en otros lenguajes, habilita a que estos números duales se puedan usar con librerías que, en principio, ni se han diseñado para ellos. Mientras las operaciones que se realicen en estas librerías sean tales que solo involucren aquellas para las que nosotros hemos enseñado a operar a los números duales, se pueden componer sin ningún problema. De hecho, Julia está repleta de [sinergías](https://rayleighlord.github.io/Demo-Julia/notebooks_collection_ode_measure/) como esta.

Para terminar de extender la funcionalidad de nuestros números duales, vamos a programar cómo se deben comportar las funciones seno, coseno y exponencial cuando reciben como argumento un número dual. De esta manera, todas las funciones que se puedan expresar como composición de todas las que hemos definido anteriormente, pueden ser utilizadas para hallar su derivada por diferenciación automática.

"""

# ╔═╡ f0603abc-e503-4b52-b7d3-9a91f0bba936
md"""
En la siguiente celda, definimos el comportamiento de estas funciones con números duales
"""

# ╔═╡ fab01c1f-2155-4657-ab06-d53834709706
Base.sin(x::Dual) = Dual(sin(x.val), cos(x.val) * x.der)

# ╔═╡ 6f869b37-4d65-469f-996c-be3055928301
Base.cos(x::Dual) = Dual(cos(x.val), -sin(x.val) * x.der)

# ╔═╡ f975179f-09c5-481c-9db0-0d5c90686fe4
Base.exp(x::Dual) = exp(x.val) * Dual(1, x.der)

# ╔═╡ d96757d3-a709-4f94-ba46-0164afe9bc8b
md"""
donde cabe notar que la segunda entrada de los números duales a los que corresponden son las reglas de derivación de cada una de las funciones. Si bien cuando definimos una función compuesta no damos ninguna información de como es la derivada de esa función específica, a través de la definición de las reglas de derivación de los bloques que componen la función somos capaces de evaluar su derivada.
"""

# ╔═╡ 0c8fc23d-68c8-4685-a193-a4c5b02cf5e7
md"""
Ahora, podemos operar con funciones que implementen todas las operaciones anteriores. Por ejemplo, definimos las funciones $f(x)$ y $g(x)$
"""

# ╔═╡ 559c2462-f027-476d-9d51-a608aecd4480
f(x) = exp(sin(x) + cos(3x^3))

# ╔═╡ 10949fa6-f59f-4137-b5b8-a807911a9b94
g(x) = exp(-cos(1 / (x^2 + 1)))

# ╔═╡ 920fcde3-f47c-4746-8768-d64dfbc9c879
md"""
Y calculamos su derivada en $x = 5$ con diferenciación automática
"""

# ╔═╡ 02b1201f-4324-4071-a00f-765d55f193d3
f(5 + ϵ)

# ╔═╡ 0dbd9ae2-8fad-47fb-b0bc-80942216e36f
g(5 + ϵ)

# ╔═╡ 48f79c90-1fa1-4ac9-ac1d-1fec7449e1ee
md"""
Ahora comparamos con sus valores reales
"""

# ╔═╡ 867feb7d-ecc7-4fae-8ca4-aa5ee6cd6e34
f′(x) = (cos(x) - sin(3x^3) * 9x^2) * f(x)

# ╔═╡ 30876dcf-a3c4-4294-a7ad-bccf0088cb3b
g′(x) = -sin(1 / (x^2 + 1)) * 2x / (x^2 + 1)^2 * g(x)

# ╔═╡ cbf8dee2-b837-43f0-958d-1df923c1f371
f′(5)

# ╔═╡ 49bd1197-fe35-454a-8dc6-40d7e123a819
g′(5)

# ╔═╡ 99199d1f-0981-4a3e-ad7b-95e51de84501
md"""
y vemos que los resultados por diferenciación automática son exactos. También podemos definir ahora una función $h = g ∘ f$
"""

# ╔═╡ 0cf0c49d-375e-48de-9172-0204000d4ed4
h = g ∘ f

# ╔═╡ ac5120b0-18b5-4e62-add3-9b7152fd9985
md"""
Y también comprobamos que la derivada se pueda obtener correctamente por diferenciación automática en, por ejemplo, $x = 2$
"""

# ╔═╡ ab0fb9f5-4ca9-4ea8-8690-b244d003f63e
h(2 + ϵ)

# ╔═╡ afeb97c8-870f-41c8-85ac-f756bec02029
md"""
Como $h'(x) = g'(f(x)) f'(x)$, obtenemos la derivada exacta y vemos que coinciden.
"""

# ╔═╡ c5e5c756-d8b5-40f6-a2ad-1d85ece75d57
g′(f(2)) * f′(2)

# ╔═╡ 1292f98e-c8a1-4013-8a1a-4b8b6b471032
md"""
Finalmente, como puede que no nos interese obtener la función evaluada en un punto cuando pasamos un número dual, creamos la función `derivative` para extraer solo la derivada de la función en el punto de interés
"""

# ╔═╡ 28de6242-fee9-49a0-b4b8-e7e2c23b1b69
derivative(f, x) = f(Dual(x, one(x))).der

# ╔═╡ 9c8396d0-62ec-4954-8a0e-28aa73f21555
derivative(h, 2)

# ╔═╡ dcce4a72-cdaf-4b1b-b84e-16fbf3f8ad70
md"""
y nos da el resultado correcto.
"""

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

julia_version = "1.8.4"
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
version = "1.0.1+0"

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
# ╟─f5450eab-0f9f-4b7f-9b80-992d3c553ba9
# ╟─719af058-3505-4ede-be04-557a448d8ade
# ╠═58fdf9e2-8dc6-43e2-9798-8e992dac2053
# ╟─27d55bc5-af2f-40e5-b633-79dc53f30c27
# ╟─53c85181-c111-4441-bd50-8fa029c90a99
# ╟─758a6077-f323-490d-80a7-d71b12f6f445
# ╟─abf319e2-af6c-4863-b985-47e8e2a312e6
# ╟─1ee1a5b3-4e31-431f-95a2-d8c480b9336c
# ╟─b5395e77-ef52-4cd3-bd55-6c3b665e3251
# ╟─0a4122b2-4a7c-43ef-b87d-cc6bfe662154
# ╠═f70178ed-8b32-49e9-953a-a68f44c48c0a
# ╟─8b7f8281-a7ef-4a62-b647-28270ff224a0
# ╠═db850874-4504-4a3a-b41b-1c18dc7da0ae
# ╟─2a9489ab-2d65-4d0d-8c71-2d79c094c24d
# ╠═7d9d590d-6347-42e1-95a6-b8d76ece0351
# ╟─8138e9a2-eb5f-4787-b82d-7d7f6a5a6cb7
# ╠═4c46a8f0-1785-45c9-80ce-fd3447c07cf7
# ╟─19bbe5e5-8beb-4bf2-9ce3-b84727ee4121
# ╠═fdef22c6-036b-4d17-8411-4e41196374f0
# ╟─be186ab3-7d8b-4287-9550-1d51298130df
# ╟─7114cd1d-f778-4df9-a7a4-eb2db0541a5b
# ╠═af0d8f53-0d91-420b-a383-68eb37d37867
# ╟─061f0e4d-391e-4f7a-a46d-02df226833e3
# ╠═268b9d66-162b-4ab2-845f-4a3b04aaf047
# ╠═84202dd1-1f54-49a1-b1c5-2ea55d74907b
# ╟─f60ba72f-bde7-4cdd-a408-54995e9b13a8
# ╠═9dc6e59f-3eca-47e6-8d9b-f76c14ec519a
# ╠═1db9b9b9-7fc4-440b-b35c-ecf1dfa93d16
# ╟─1b5b997d-2604-439d-8cc1-49fd22139615
# ╠═f02e0e75-cf78-4daa-96a5-35c70dd08abc
# ╠═1d1d8926-c81e-4e0f-a9f2-a97dae7ca394
# ╟─f78814fc-a747-487b-97f0-1be987f04f85
# ╟─bc8e9223-8143-4f97-8663-0929e89c4725
# ╠═455f0f48-a95f-482e-84f1-393a3c6abd3f
# ╟─b633a32f-9b41-44be-ada1-ef091506b110
# ╠═f930f7cb-44aa-4d48-a148-f7c77092fcab
# ╟─f52b0585-8a8d-43bd-8e42-1b979c1862a4
# ╠═32c5607b-5c5a-474d-8ec1-c41493465047
# ╟─609c82e3-642a-401d-9d25-e355c15205e9
# ╠═609bcf69-1d11-4037-a610-df48ea6309ea
# ╠═4c4deff7-38ce-469b-b16d-6eef97709d9f
# ╠═bd63cc6b-a3be-448c-abe6-5dc1351e1381
# ╟─5f0e09f2-b5b6-4393-9cb8-629db1561d70
# ╠═f198f716-2020-4af0-9d64-c4aeebf47270
# ╟─6468765a-9107-4c34-b71c-74c91e5d0fac
# ╠═4ef88a55-3ecb-41ec-8885-285978558f7c
# ╟─2b658ad9-3919-473f-bda9-0ad0baac5df7
# ╠═244a9c9a-0658-463e-9df4-a060f17c0959
# ╟─1d5ad669-39d7-49a0-b4b8-d296fe174033
# ╠═931fce01-dea4-4d26-af98-225423423d8d
# ╠═9e8323a4-dd6f-4309-84b7-d7d1117d6e45
# ╟─0436ee2e-8e15-41b1-82c3-4311d18ee12f
# ╟─9b3e7015-a3bb-4057-aeb7-40d9266414ef
# ╠═0dca92e9-f3e9-4c5a-bf18-fa00628b25b3
# ╠═de63c63f-20e5-4e7d-bdf7-22adb8eafa87
# ╟─2d6e5a61-786b-4156-bec6-c035c47e8093
# ╟─9555254d-9a00-4761-8e77-9d6ec284c85d
# ╟─f0603abc-e503-4b52-b7d3-9a91f0bba936
# ╠═fab01c1f-2155-4657-ab06-d53834709706
# ╠═6f869b37-4d65-469f-996c-be3055928301
# ╠═f975179f-09c5-481c-9db0-0d5c90686fe4
# ╟─d96757d3-a709-4f94-ba46-0164afe9bc8b
# ╟─0c8fc23d-68c8-4685-a193-a4c5b02cf5e7
# ╠═559c2462-f027-476d-9d51-a608aecd4480
# ╠═10949fa6-f59f-4137-b5b8-a807911a9b94
# ╟─920fcde3-f47c-4746-8768-d64dfbc9c879
# ╠═02b1201f-4324-4071-a00f-765d55f193d3
# ╠═0dbd9ae2-8fad-47fb-b0bc-80942216e36f
# ╟─48f79c90-1fa1-4ac9-ac1d-1fec7449e1ee
# ╠═867feb7d-ecc7-4fae-8ca4-aa5ee6cd6e34
# ╠═30876dcf-a3c4-4294-a7ad-bccf0088cb3b
# ╠═cbf8dee2-b837-43f0-958d-1df923c1f371
# ╠═49bd1197-fe35-454a-8dc6-40d7e123a819
# ╟─99199d1f-0981-4a3e-ad7b-95e51de84501
# ╠═0cf0c49d-375e-48de-9172-0204000d4ed4
# ╟─ac5120b0-18b5-4e62-add3-9b7152fd9985
# ╠═ab0fb9f5-4ca9-4ea8-8690-b244d003f63e
# ╟─afeb97c8-870f-41c8-85ac-f756bec02029
# ╠═c5e5c756-d8b5-40f6-a2ad-1d85ece75d57
# ╟─1292f98e-c8a1-4013-8a1a-4b8b6b471032
# ╠═28de6242-fee9-49a0-b4b8-e7e2c23b1b69
# ╠═9c8396d0-62ec-4954-8a0e-28aa73f21555
# ╟─dcce4a72-cdaf-4b1b-b84e-16fbf3f8ad70
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
