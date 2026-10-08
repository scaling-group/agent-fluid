using StaticArrays
using WaterLily

# Case-local compatibility contract for reflection-equivariant immersed-boundary
# measurement and pressure smoothing.
#
# Include this file at top level before constructing a Simulation. It does not
# edit the installed WaterLily package; it replaces the method only in the
# current Julia process. Each staggered face uses both adjacent pressure cells
# for the narrow-band gate and retains the signed distance queried at the face.
# PCG replaces fixed-order red-black smoothing to avoid a color-order reflection
# bias while retaining near-default H200 throughput.
@eval WaterLily begin
    function measure!(a::Flow{N,T}, body::AbstractBody; t=zero(T), ϵ=1) where {N,T}
        a.V .= zero(T)
        a.μ₀ .= one(T)
        a.μ₁ .= zero(T)
        d² = T(2 + ϵ)^2
        measure_sdf!(a.σ, body, t; fastd²=d²)

        @fastmath @inline function fill_reflection_equivariant!(μ₀, μ₁, V, d, I)
            for i in 1:N
                Im = I - δ(i, I)
                dplus, dminus = d[I], d[Im]
                crosses = signbit(dplus) != signbit(dminus)
                if min(dplus^2, dminus^2) < d² || crosses
                    dface, nface, Vface = measure(
                        body, loc(i, I, T), t; fastd²=d²,
                    )
                    V[I, i] = Vface[i]
                    μ₀[I, i] = WaterLily.μ₀(dface, ϵ)
                    for j in 1:N
                        μ₁[I, i, j] = WaterLily.μ₁(dface, ϵ) * nface[j]
                    end
                elseif dplus < zero(T) && dminus < zero(T)
                    μ₀[I, i] = zero(T)
                end
            end
        end

        @loop fill_reflection_equivariant!(
            a.μ₀, a.μ₁, a.V, a.σ, I,
        ) over I in inside(a.p)
        BC!(a.μ₀, zeros(SVector{N,T}), false, a.perdir)
        BC!(a.V, zeros(SVector{N,T}), a.exitBC, a.perdir)
        return nothing
    end

    smooth! = pcg!
end

const DOGFISH_REFLECTION_EQUIVARIANT_IBM_CONTRACT = (
    measure="two-sided staggered-face gate plus direct face SDF sign",
    pressure_smoother="WaterLily.pcg!",
    scope="current Julia process only",
)
