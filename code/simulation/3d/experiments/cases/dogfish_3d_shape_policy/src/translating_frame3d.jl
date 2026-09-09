# Translating computational frame for long-distance 3D free swimming.
#
# Let X be an inertial/world coordinate and x = X - O(t) the WaterLily
# coordinate.  The stored velocity is therefore
#
#     u_frame = u_world - dO/dt,
#
# so quiescent water has the far-field boundary value -dO/dt.  WaterLily
# differentiates a time-dependent uBC and adds duBC/dt to the momentum
# equation, which supplies the required -d²O/dt² reference-frame term.
#
# The seven coefficients live in backend memory.  On CUDA, Adapt/CUDA turns
# the CuArray captured by this callable into a CuDeviceVector when launching
# WaterLily kernels.  Updating the small buffer between steps changes the
# segment without rebuilding the Flow, Poisson hierarchy, or fluid arrays.
struct TranslatingFrameBC{T, A<:AbstractVector{T}} <: Function
    coefficients::A
end

const TRANSLATING_FRAME_COEFFICIENT_COUNT = 7

"""
    translating_frame_bc(T, mem=Array)

Create a mutable, backend-resident, piecewise-linear translating-frame
boundary condition.  It initially represents a stationary frame.
"""
function translating_frame_bc(::Type{T}, mem=Array) where {T<:AbstractFloat}
    coefficients = zeros(T, TRANSLATING_FRAME_COEFFICIENT_COUNT) |> mem
    return TranslatingFrameBC{T, typeof(coefficients)}(coefficients)
end

@inline function (bc::TranslatingFrameBC{T})(i, x, t) where {T}
    t0 = bc.coefficients[1]
    velocity0 = bc.coefficients[1 + i]
    acceleration = bc.coefficients[4 + i]
    return -(velocity0 + acceleration * (t - t0))
end

"""
    set_translating_frame_segment!(bc, t0, velocity0, velocity1, dt)

Set one linear frame-velocity segment over `[t0, t0 + dt]`.  Velocities are
world-frame 2-vectors (or 3-vectors); a missing vertical component is zero.
"""
function set_translating_frame_segment!(
    bc::TranslatingFrameBC{T},
    t0,
    velocity0,
    velocity1,
    dt,
) where {T}
    dt_t = T(dt)
    dt_t > zero(T) || error("translating-frame segment dt must be positive")
    v0 = SVector{3, T}(
        T(velocity0[1]),
        T(velocity0[2]),
        length(velocity0) >= 3 ? T(velocity0[3]) : zero(T),
    )
    v1 = SVector{3, T}(
        T(velocity1[1]),
        T(velocity1[2]),
        length(velocity1) >= 3 ? T(velocity1[3]) : zero(T),
    )
    acceleration = (v1 - v0) / dt_t
    host_coefficients = T[
        T(t0),
        v0[1],
        v0[2],
        v0[3],
        acceleration[1],
        acceleration[2],
        acceleration[3],
    ]
    copyto!(bc.coefficients, host_coefficients)
    return (
        t0=T(t0),
        dt=dt_t,
        velocity0=v0,
        velocity1=v1,
        acceleration=acceleration,
    )
end

"""Convert an inertial rigid state into a translating WaterLily frame."""
function translating_frame_local_state(world_state, frame_origin, frame_velocity)
    T = eltype(world_state.center)
    return Base2D.FreeSwimState(
        world_state.center - SVector{2, T}(T(frame_origin[1]), T(frame_origin[2])),
        world_state.theta,
        world_state.velocity - SVector{2, T}(T(frame_velocity[1]), T(frame_velocity[2])),
        world_state.omega,
    )
end

"""World point corresponding to a WaterLily-frame point."""
@inline translating_frame_world_point(local_point, frame_origin) =
    local_point + frame_origin

"""WaterLily-frame point corresponding to an inertial/world point."""
@inline translating_frame_local_point(world_point, frame_origin) =
    world_point - frame_origin
