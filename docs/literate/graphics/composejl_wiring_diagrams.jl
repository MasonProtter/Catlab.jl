# # Wiring diagrams in Compose.jl
#
#md # [![](https://img.shields.io/badge/show-nbviewer-579ACA.svg)](@__NBVIEWER_ROOT_URL__/generated/graphics/composejl_wiring_diagrams.ipynb)
#
# Catlab can draw wiring diagrams using the Julia package
# [Compose.jl](https://github.com/GiovineItalia/Compose.jl).

using Catlab.WiringDiagrams, Catlab.Graphics

# ## Examples

# ### Symmetric monoidal category

using Catlab.Doctrines

A, B, C, D = Ob(FreeSymmetricMonoidalCategory, :A, :B, :C, :D)
f, g = Hom(:f, A, B), Hom(:g, B, A);

# To start, here are a few very simple examples.

to_composejl(f)
#-
to_composejl(f⋅g)
#-
to_composejl(f⊗g)

# Here is a more complex example, involving generators with compound domains and
# codomains.

h, k = Hom(:h, C, D),  Hom(:k, D, C)
m, n = Hom(:m, B⊗A, A⊗B), Hom(:n, D⊗C, C⊗D)
q = Hom(:l, A⊗B⊗C⊗D, D⊗C⊗B⊗A)

to_composejl((f⊗g⊗h⊗k)⋅(m⊗n)⋅q⋅(n⊗m)⋅(h⊗k⊗f⊗g))

# Identities and braidings appear as wires.

to_composejl(id(A))
#-
to_composejl(braid(A,B))
#-
to_composejl(braid(A,B) ⋅ (g⊗f) ⋅ braid(A,B))

# The isomorphism $A \otimes B \otimes C \to C \otimes B \otimes A$ induced by
# the permutation $(3\ 2\ 1)$ is a composite of braidings and identities.

to_composejl((braid(A,B) ⊗ id(C)) ⋅ (id(B) ⊗ braid(A,C) ⋅ (braid(B,C) ⊗ id(A))))

# ## Custom styles

# The style of wiring diagrams can be customized by passing Compose
# [properties](http://giovineitalia.github.io/Compose.jl/latest/gallery/properties/).

using Compose: fill

to_composejl(f⋅g, box_props=[fill("lavender")])
